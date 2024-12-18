import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/data/model/category_model.dart';
import 'package:recipe/data/model/g_model/category_model_g.dart';
import 'package:recipe/infrasuruktura/apis/category_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<GetCategoryEvent>(
      (event, emit) async {
        emit(state.copyWith(statusCategory: FormzSubmissionStatus.inProgress));

        try {
          final result = await CategoryService().fetchCategoryes();
          emit(
            state.copyWith(
                categoryes: result,
                statusCategory: FormzSubmissionStatus.success),
          );
        } catch (e) {
          emit(
            state.copyWith(
              statusCategory: FormzSubmissionStatus.failure,
            ),
          );
        }
      },
    );

    on<GetCategoryByIdEvent>(
      (event, emit) async {
        emit(state.copyWith(statusCategory: FormzSubmissionStatus.inProgress));
        try {
          final result =
              await CategoryService().fetchCategoryeById(event.categoryId);
          emit(
            state.copyWith(
                categoryes: result,
                statusCategory: FormzSubmissionStatus.success),
          );
        } catch (e) {
          emit(
            state.copyWith(
              statusCategory: FormzSubmissionStatus.failure,
            ),
          );
        }
      },
    );

    on<AddCategoryEvent>(
      (event, emit) async {
        emit(state.copyWith(statusCategory: FormzSubmissionStatus.inProgress));

        try {
          await CategoryService().addCategory(event.category);

          emit(
            state.copyWith(
              statusCategory: FormzSubmissionStatus.success,
            ),
          );
          add(GetCategoryEvent());
        } catch (e) {
          emit(
            state.copyWith(
              statusCategory: FormzSubmissionStatus.failure,
            ),
          );
        }
      },
    );
  }
}
