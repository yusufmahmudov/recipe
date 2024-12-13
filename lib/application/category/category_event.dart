part of 'category_bloc.dart';

sealed class CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final CategoryModelG category;

  AddCategoryEvent({required this.category});
}