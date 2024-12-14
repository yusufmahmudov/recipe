import 'package:recipe/assets/constants/storage_keys.dart';
import 'package:recipe/data/model/g_model/product_model_g.dart';
import 'package:recipe/data/model/ingredient_model.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/data/model/serves_model.dart';
import 'package:recipe/infrasuruktura/apis/favorite_service.dart';
import 'package:recipe/infrasuruktura/repo/storage_repository.dart';
import 'package:recipe/utils/enum_filtr.dart';
import 'package:recipe/utils/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Mahsulotlarni olish
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final List<dynamic> response =
          await supabase.from(Tables.product.text).select();

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(int categoryId) async {
    try {
      final List<dynamic> response = await supabase
          .from(Tables.product.text)
          .select()
          .eq("category_id", categoryId);

      return response.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }

  // Mahsulotni ma'lumotlarini olish
  Future<List<ProductModel>> fetchProductByUserId() async {
    try {
      int userId = StorageRepository.getInt(StorageKeys.USERID);

      final dynamic response = await supabase
          .from(Tables.product.text)
          .select()
          .eq('user_id', userId);

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  // Yangi mahsulot qo'shish
  Future<void> addProduct(
      ProductModelG product,
      List<Map<String, String>> ingredients,
      List<Map<String, String>> preparations) async {
    try {
      final productModel = await supabase
          .from(Tables.product.text)
          .insert(product.toJson())
          .select('id');
      Log.i("product Id: ${productModel[0]['id']}");
      int productId = productModel[0]['id'];
      addIngredient(ingredients, productId);
      addPreparations(preparations, productId);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  // Ingredientlarni qo'shish
  Future<void> addIngredient(
      List<Map<String, String>> ingredients, int productId) async {
    try {
      List<IngredientModel> newIngredient = [];
      for (int i = 0; i < ingredients.length; i++) {
        newIngredient.add(
          IngredientModel(
            productId: productId,
            ingredient: ingredients[i]['name'] ?? '',
            quantity: ingredients[i]['quantity'] ?? '',
          ),
        );
      }
      List<Map<String, dynamic>> jsonList = newIngredient
          .map((e) => e.toJson())
          .cast<Map<String, dynamic>>()
          .toList();

      await supabase.from(Tables.ingredient.text).insert(jsonList);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<void> addPreparations(
      List<Map<String, String>> preparations, int productId) async {
    try {
      List<ServesModel> newPreparation = [];
      for (int i = 0; i < preparations.length; i++) {
        newPreparation.add(
          ServesModel(
            productId: productId,
            servesName: preparations[i]['name'] ?? '',
            servesBody: preparations[i]['body'] ?? '',
          ),
        );
      }
      List<Map<String, dynamic>> jsonList = newPreparation
          .map((e) => e.toJson())
          .cast<Map<String, dynamic>>()
          .toList();

      await supabase.from(Tables.serves.text).insert(jsonList);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  // Mahsulotni yangilash
  Future<void> updateProduct(
    ProductModel product,
    List<Map<String, String>> ingredients,
    List<Map<String, String>> preparations,
  ) async {
    try {
      await supabase
          .from('product')
          .update(product.toJson() as Map)
          .eq('id', product.id!);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  // Mahsulotni o'chirish
  Future<void> deleteProduct(int productId) async {
    try {
      await supabase.from('product').delete().eq('id', productId);
      await supabase.from("product").delete().eq('product', 3);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<List<ProductModel>> fetchProductFavorite() async {
    try {
      final List<int> productIds = await FavoriteService().fetchFavorite();
      String ids = productIds.join(",");

      final response = await supabase
          .from(Tables.product.text)
          .select()
          .filter("id", "in", "($ids)");

      return response.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Xatolik yuz berdi $e");
    }
  }
}
