import 'package:recipe/data/model/category_model.dart';
import 'package:recipe/data/model/g_model/category_model_g.dart';
import 'package:recipe/utils/enum_filtr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> addCategory(CategoryModelG category) async {
    try {
      await supabase.from(Tables.category.text).insert(category.toJson());
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<List<CategoryModel>> fetchCategoryes() async {
    try {
      final List<dynamic> response =
          await supabase.from(Tables.category.text).select();
      return response.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<List<CategoryModel>> fetchCategoryeById(int categoryId) async {
    try {
      final List<dynamic> response = await supabase
          .from(Tables.category.text)
          .select()
          .eq("id", categoryId);

      return response.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }
}
