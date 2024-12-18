part of 'category_bloc.dart';

sealed class CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {}

class GetCategoryByIdEvent extends CategoryEvent {
  final int categoryId;

  GetCategoryByIdEvent({required this.categoryId});
}

class AddCategoryEvent extends CategoryEvent {
  final CategoryModelG category;

  AddCategoryEvent({required this.category});
}
