part of 'product_bloc.dart';

sealed class ProductEvent {}

class GetProductsEvent extends ProductEvent {}

class GetProductsByCategoryEvent extends ProductEvent {
  final int categoryId;

  GetProductsByCategoryEvent({required this.categoryId});
}

class GetProductsByUserIdEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final ProductModelG productG;
  final List<Map<String, String>> ingredients;
  final List<Map<String, String>> preparations;
  final File? image;

  AddProductEvent({
    required this.productG,
    required this.ingredients,
    required this.preparations,
    required this.image,
  });
}

class UpdateProductEvent extends ProductEvent {
  final ProductModel product;
  final List<Map<String, String>> ingredients;
  final List<Map<String, String>> preparations;

  UpdateProductEvent({
    required this.product,
    required this.ingredients,
    required this.preparations,
  });
}

class DeleteProductEvent extends ProductEvent {
  final int productId;

  DeleteProductEvent({required this.productId});
}

class GetFavoriteProductEvent extends ProductEvent {}

class GetFavoriteProductById extends ProductEvent {
  final int productId;

  GetFavoriteProductById({required this.productId});
}

class AddFavoriteEvent extends ProductEvent {
  final int productId;

  AddFavoriteEvent({required this.productId});
}

class DeleteFavoriteEvent extends ProductEvent {
  final int productId;

  DeleteFavoriteEvent({required this.productId});
}

class GetProductIngredient extends ProductEvent {
  final int productId;

  GetProductIngredient({required this.productId});
}

class GetProductServes extends ProductEvent {
  final int productId;

  GetProductServes({required this.productId});
}
