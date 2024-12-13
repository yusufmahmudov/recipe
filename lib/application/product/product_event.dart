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

  AddProductEvent({
    required this.productG,
    required this.ingredients,
    required this.preparations,
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
