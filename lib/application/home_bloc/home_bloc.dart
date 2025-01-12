import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/data/model/category_model.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/infrasuruktura/apis/category_service.dart';
import 'package:recipe/infrasuruktura/apis/product_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<GetProductsByCategoryEvent>(
      (event, emit) async {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.inProgress));
        try {
          final result =
              await ProductService().fetchProductsByCategory(event.categoryId);
          emit(
            state.copyWith(
              statusProduct: FormzSubmissionStatus.success,
              products: result,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(statusProduct: FormzSubmissionStatus.failure),
          );
        }
      },
    );

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
  }
}
