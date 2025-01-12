part of 'home_bloc.dart';

class HomeState extends Equatable {
  final FormzSubmissionStatus statusProduct;
  final FormzSubmissionStatus statusCategory;
  final List<ProductModel> products;
  final List<CategoryModel> categoryes;
  final int selProduct;
  final int selCategory;

  const HomeState({
    this.statusProduct = FormzSubmissionStatus.initial,
    this.statusCategory = FormzSubmissionStatus.initial,
    this.products = const [],
    this.categoryes = const [],
    this.selProduct = -1,
    this.selCategory = -1,
  });

  @override
  List<Object> get props => [
        statusProduct,
        products,
        selProduct,
        statusCategory,
        categoryes,
        selCategory
      ];

  HomeState copyWith({
    FormzSubmissionStatus? statusProduct,
    FormzSubmissionStatus? statusCategory,
    List<ProductModel>? products,
    List<CategoryModel>? categoryes,
    int? selProduct,
    int? selCategory,
  }) {
    return HomeState(
      statusProduct: statusProduct ?? this.statusProduct,
      statusCategory: statusCategory ?? this.statusCategory,
      products: products ?? this.products,
      categoryes: categoryes ?? this.categoryes,
      selProduct: selProduct ?? this.selProduct,
      selCategory: selCategory ?? this.selCategory,
    );
  }
}
