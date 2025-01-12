part of 'home_bloc.dart';

sealed class HomeEvent {}

class GetCategoryEvent extends HomeEvent {}

class GetProductsByCategoryEvent extends HomeEvent {
  final int categoryId;

  GetProductsByCategoryEvent({required this.categoryId});
}