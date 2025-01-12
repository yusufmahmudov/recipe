import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/ingredient_model.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/data/model/serves_model.dart';
import 'package:recipe/presentation/views/add/add_category_view.dart';
import 'package:recipe/utils/log_service.dart';

import '../../../application/product/product_bloc.dart';

class ProductView extends StatefulWidget {
  final ProductModel product;
  final int index;
  const ProductView({super.key, required this.product, required this.index});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late bool favorite = false;

  final TextStyle defaultTextStyle = TextStyle(
    fontSize: 16,
    color: greyBack.withOpacity(.6),
    fontWeight: FontWeight.w400,
  );

  final TextStyle originTextStyle = const TextStyle(
    fontSize: 16,
    color: black,
    fontWeight: FontWeight.w400,
  );

  @override
  void initState() {
    context
        .read<ProductBloc>()
        .add(GetProductIngredient(productId: widget.product.id!));

    context
        .read<ProductBloc>()
        .add(GetProductServes(productId: widget.product.id!));

    context
        .read<ProductBloc>()
        .add(GetFavoriteProductById(productId: widget.product.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          'Retsept',
        ),
        actions: [
          if (widget.index == 0) ...[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCategoryView(),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: redOrange,
                size: 22,
              ),
            ),
          ] else ...[
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.statusFavorite.isFailure) {
                  return const Center(
                    child: Icon(
                      Icons.abc,
                      color: white,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      try {
                        state.selProduct == -1
                            ? context.read<ProductBloc>().add(
                                  AddFavoriteEvent(
                                    productId: widget.product.id!,
                                  ),
                                )
                            : context.read<ProductBloc>().add(
                                  DeleteFavoriteEvent(
                                    productId: widget.product.id!,
                                  ),
                                );

                        context.read<ProductBloc>().add(GetFavoriteProductById(
                            productId: widget.product.id!));
                      } catch (e) {
                        Log.d(e);
                      }
                    },
                    icon: state.selProduct != -1
                        ? const Icon(
                            Icons.favorite,
                            size: 26,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                            size: 26,
                          ),
                  ),
                );
              },
            ),
          ]
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Background.png',
                width: 334,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  widget.product.name!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kategoriya", style: defaultTextStyle),
                    Text("Portsiya", style: defaultTextStyle),
                    Text("Vaqti", style: defaultTextStyle),
                    Text("Mahsulotlar", style: defaultTextStyle),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.product.categoryName}",
                        style: originTextStyle),
                    Text("${widget.product.portion!}", style: originTextStyle),
                    Text(widget.product.time!, style: originTextStyle),
                    Text("${widget.product.ingredientCount!}",
                        style: originTextStyle),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Kerakli mahsulotlar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.statusIngredient.isInProgress) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 4.0,
                    ),
                  );
                } else if (state.ingredients.isEmpty) {
                  return const Center(
                    child: Text(
                      "Mahsulotlar ro'yxati bo'sh",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.ingredients.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 0);
                  },
                  itemBuilder: (context, index) {
                    return _buildIngredientRow(state.ingredients[index]);
                  },
                );
              },
            ),
            const SizedBox(height: 12),
            const Text(
              "Tayyorlash jarayoni",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.statusServes.isInProgress) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 4.0,
                    ),
                  );
                } else if (state.serves.isEmpty) {
                  return const Center(
                    child: Text(
                      "Tayyorlash jarayonlari ro'yxati bo'sh",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.serves.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 4);
                  },
                  itemBuilder: (context, index) {
                    return _buildServesRow(state.serves[index], index);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientRow(IngredientModel ingredient) {
    return Row(
      children: [
        const Text(
          "  ·  ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Text("${ingredient.ingredient}  ${ingredient.quantity}",
            style: originTextStyle),
      ],
    );
  }

  Widget _buildServesRow(ServesModel serves, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${index + 1}-jarayon: ${serves.servesName}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text("${serves.servesBody}", style: originTextStyle),
        const SizedBox(height: 14),
      ],
    );
  }
}
