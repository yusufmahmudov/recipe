part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final FormzSubmissionStatus statusCategory;
  final List<CategoryModel> categoryes;
  final int selCategory;

  const CategoryState({
    this.statusCategory = FormzSubmissionStatus.initial,
    this.categoryes = const [],
    this.selCategory = -1,
  });

  @override
  List<Object?> get props => [statusCategory, categoryes, selCategory];

  CategoryState copyWith({
    FormzSubmissionStatus? statusCategory,
    List<CategoryModel>? categoryes,
    int? selCategory,
  }) {
    return CategoryState(
      statusCategory: statusCategory ?? this.statusCategory,
      categoryes: categoryes ?? this.categoryes,
      selCategory: selCategory ?? this.selCategory,
    );
  }
}
