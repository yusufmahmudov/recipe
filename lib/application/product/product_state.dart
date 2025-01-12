part of 'product_bloc.dart';

class ProductState extends Equatable {
  final FormzSubmissionStatus statusProduct;
  final FormzSubmissionStatus statusFavorite;
  final FormzSubmissionStatus statusIngredient;
  final FormzSubmissionStatus statusServes;
  final FormzSubmissionStatus statusIngredient;
  final FormzSubmissionStatus statusServes;
  final List<ProductModel> products;
  final List<ProductModel> favoriteProducts;
  final List<IngredientModel> ingredients;
  final List<ServesModel> serves;
  final int selProduct;

  const ProductState({
    this.statusProduct = FormzSubmissionStatus.initial,
    this.statusFavorite = FormzSubmissionStatus.initial,
    this.statusIngredient = FormzSubmissionStatus.initial,
    this.statusServes = FormzSubmissionStatus.initial,
    this.statusIngredient = FormzSubmissionStatus.initial,
    this.statusServes = FormzSubmissionStatus.initial,
    this.products = const [],
    this.favoriteProducts = const [],
    this.ingredients = const [],
    this.serves = const [],
    this.selProduct = -2,
  });

  @override
  List<Object?> get props => [
        statusProduct,
        statusFavorite,
        products,
        favoriteProducts,
        selProduct,
        ingredients,
        serves,
        statusIngredient,
        statusServes
      ];

  ProductState copyWith({
    FormzSubmissionStatus? statusProduct,
    FormzSubmissionStatus? statusFavorite,
    FormzSubmissionStatus? statusIngredient,
    FormzSubmissionStatus? statusServes,
    FormzSubmissionStatus? statusIngredient,
    FormzSubmissionStatus? statusServes,
    List<ProductModel>? products,
    List<ProductModel>? favoriteProducts,
    List<IngredientModel>? ingredients,
    List<ServesModel>? serves,
    int? selProduct,
  }) {
    return ProductState(
      statusProduct: statusProduct ?? this.statusProduct,
      statusFavorite: statusFavorite ?? this.statusFavorite,
      statusIngredient: statusIngredient ?? this.statusIngredient,
      statusServes: statusServes ?? this.statusServes,
      statusIngredient: statusIngredient ?? this.statusIngredient,
      statusServes: statusServes ?? this.statusServes,
      products: products ?? this.products,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      ingredients: ingredients ?? this.ingredients,
      serves: serves ?? this.serves,
      selProduct: selProduct ?? this.selProduct,
    );
  }
}
