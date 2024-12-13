part of 'product_bloc.dart';

class ProductState extends Equatable {
  final FormzSubmissionStatus statusProduct;
  final FormzSubmissionStatus statusFavorite;
  final List<ProductModel> products;
  final List<ProductModel> favoriteProducts;
  final int selProduct;

  const ProductState({
    this.statusProduct = FormzSubmissionStatus.initial,
    this.statusFavorite = FormzSubmissionStatus.initial,
    this.products = const [],
    this.favoriteProducts = const [],
    this.selProduct = -1,
  });

  @override
  List<Object?> get props =>
      [statusProduct, statusFavorite, products, favoriteProducts, selProduct];

  ProductState copyWith({
    FormzSubmissionStatus? statusProduct,
    FormzSubmissionStatus? statusFavorite,
    List<ProductModel>? products,
    List<ProductModel>? favoriteProducts,
    int? selProduct,
  }) {
    return ProductState(
      statusProduct: statusProduct ?? this.statusProduct,
      statusFavorite: statusFavorite ?? this.statusFavorite,
      products: products ?? this.products,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      selProduct: selProduct ?? this.selProduct,
    );
  }
}
