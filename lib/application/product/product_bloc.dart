import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/data/model/g_model/product_model_g.dart';
import 'package:recipe/data/model/ingredient_model.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/data/model/serves_model.dart';
import 'package:recipe/infrasuruktura/apis/favorite_service.dart';
import 'package:recipe/infrasuruktura/apis/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<GetProductsEvent>(
      (event, emit) async {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.inProgress));

        try {
          final result = await ProductService().fetchProducts();

          emit(
            state.copyWith(
              products: result,
              statusProduct: FormzSubmissionStatus.success,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              statusProduct: FormzSubmissionStatus.failure,
            ),
          );
        }
      },
    );

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

    on<GetProductsByUserIdEvent>(
      (event, emit) async {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.inProgress));
        try {
          final result = await ProductService().fetchProductByUserId();
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

    on<AddProductEvent>(
      (event, emit) async {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.inProgress));
        try {
          await ProductService().addProduct(
            event.productG,
            event.ingredients,
            event.preparations,
            event.image,
          );
          emit(
            state.copyWith(
              statusProduct: FormzSubmissionStatus.success,
            ),
          );
          add(GetProductsEvent());
          // add(GetFavoriteProductEvent());
          // add(GetProductsByUserIdEvent());
        } catch (e) {
          emit(
            state.copyWith(statusProduct: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<UpdateProductEvent>(
      (event, emit) async {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.inProgress));
        try {
          await ProductService().updateProduct(
            event.product,
            event.ingredients,
            event.preparations,
          );
          emit(
            state.copyWith(
              statusProduct: FormzSubmissionStatus.success,
            ),
          );
          add(GetProductsEvent());
          add(GetFavoriteProductEvent());
          add(GetProductsByUserIdEvent());
        } catch (e) {
          emit(
            state.copyWith(statusProduct: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<DeleteProductEvent>(
      (event, emit) async {
        emit(state.copyWith(statusProduct: FormzSubmissionStatus.inProgress));

        try {
          await ProductService().deleteProduct(event.productId);
          emit(
            state.copyWith(
              statusProduct: FormzSubmissionStatus.success,
            ),
          );
          add(GetProductsEvent());
          add(GetFavoriteProductEvent());
          add(GetProductsByUserIdEvent());
        } catch (e) {
          emit(
            state.copyWith(statusProduct: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<GetProductParts>(
      (event, emit) async {
        emit(
            state.copyWith(statusIngredient: FormzSubmissionStatus.inProgress));
        try {
          final result =
              await ProductService().fetchProductIngredients(event.productId);
          final result2 =
              await ProductService().fetchProductPreparations(event.productId);
              
          emit(
            state.copyWith(
              statusIngredient: FormzSubmissionStatus.success,
              ingredients: result,
              serveses: result2,
            ),
          );
        } catch (e) {
          emit(state.copyWith(statusIngredient: FormzSubmissionStatus.failure));
        }
      },
    );

    on<GetFavoriteProductEvent>(
      (event, emit) async {
        emit(state.copyWith(statusFavorite: FormzSubmissionStatus.inProgress));
        try {
          final result = await ProductService().fetchProductFavorite();
          emit(
            state.copyWith(
              statusFavorite: FormzSubmissionStatus.success,
              favoriteProducts: result,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(statusFavorite: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<GetFavoriteProductById>(
      (event, emit) async {
        emit(state.copyWith(statusFavorite: FormzSubmissionStatus.inProgress));

        try {
          final result =
              await FavoriteService().fetchFavoriteByProductId(event.productId);
          emit(
            state.copyWith(
              statusFavorite: FormzSubmissionStatus.success,
              selProduct: result,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(statusFavorite: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<AddFavoriteEvent>(
      (event, emit) async {
        emit(state.copyWith(statusFavorite: FormzSubmissionStatus.inProgress));
        try {
          await FavoriteService().addFavorite(event.productId);
          emit(
            state.copyWith(
              statusFavorite: FormzSubmissionStatus.success,
            ),
          );
          add(GetFavoriteProductEvent());
        } catch (e) {
          emit(
            state.copyWith(statusFavorite: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<DeleteFavoriteEvent>(
      (event, emit) async {
        emit(state.copyWith(statusFavorite: FormzSubmissionStatus.inProgress));

        try {
          await FavoriteService().deleteFavorite(event.productId);
          emit(
            state.copyWith(
              statusFavorite: FormzSubmissionStatus.success,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(statusFavorite: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<GetProductIngredient>(
      (event, emit) async {
        emit(
            state.copyWith(statusIngredient: FormzSubmissionStatus.inProgress));
        try {
          final result =
              await ProductService().fetchProductIngredient(event.productId);
          emit(
            state.copyWith(
              statusIngredient: FormzSubmissionStatus.success,
              ingredients: result,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(statusIngredient: FormzSubmissionStatus.failure),
          );
        }
      },
    );

    on<GetProductServes>(
      (event, emit) async {
        emit(state.copyWith(statusServes: FormzSubmissionStatus.inProgress));
        try {
          final result =
              await ProductService().fetchProductServes(event.productId);
          emit(
            state.copyWith(
              statusServes: FormzSubmissionStatus.success,
              serves: result,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(statusServes: FormzSubmissionStatus.failure),
          );
        }
      },
    );
  }
}
