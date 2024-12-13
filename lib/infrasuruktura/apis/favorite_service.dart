import 'package:recipe/assets/constants/storage_keys.dart';
import 'package:recipe/data/model/favorite_model.dart';
import 'package:recipe/infrasuruktura/repo/storage_repository.dart';
import 'package:recipe/utils/enum_filtr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<FavoriteModel>> fetchFavorite() async {
    try {
      int userId = StorageRepository.getInt(StorageKeys.USERID);

      final List<dynamic> response = await supabase
          .from(Tables.favorite.text)
          .select()
          .eq("user_id", userId);

      return response.map((json) => FavoriteModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<void> addFavorite(int productId) async {
    try {
      int userId = StorageRepository.getInt(StorageKeys.USERID);
      final favoriteModel = FavoriteModel(productId: productId, userId: userId);

      await supabase.from(Tables.product.text).insert(favoriteModel.toJson());
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<void> deleteFavorite(int productId) async {
    try {
      int userId = StorageRepository.getInt(StorageKeys.USERID);

      await supabase
          .from(Tables.product.text)
          .delete()
          .eq("product_id", productId)
          .eq("user_id", userId);
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }
}
