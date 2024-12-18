import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/product_model.dart';
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
        .add(GetProductParts(productId: widget.product.id!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: redOrange,
        title: const Text(
          'Retsept',
          style: TextStyle(
            fontSize: 24,
            color: white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: white,
          ),
          onPressed: () => Navigator.pop(context),
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
                color: white,
                size: 22,
              ),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Background.png',
                width: 334,
                height: 200,
                fit: BoxFit.cover,
              ),
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

                final ingredients = ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    children: [
                      const Text(
                        "  ·  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "${state.ingredients[index].ingredient}   ${state.ingredients[index].quantity}",
                        style: originTextStyle,
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 4,
                  ),
                  itemCount: state.ingredients.length,
                );
                Log.i(state.serveses.first.servesBody);
                final serveres = ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}-jarayon: ${state.serveses[index].servesName}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),

                      Text("${state.serveses[index].servesBody}",
                          style: originTextStyle),
                      const SizedBox(height: 14),
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 6),
                  itemCount: state.serveses.length,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mahsulotlar",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ingredients,
                    const SizedBox(height: 12),
                    const Text(
                      "Tayyorlash jarayoni",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    serveres,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
