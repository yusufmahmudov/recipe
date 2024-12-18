import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/application/category/category_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/dto/product_dto.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/presentation/views/add/add_category_view.dart';

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
        .read<CategoryBloc>()
        .add(GetCategoryByIdEvent(categoryId: widget.product.categoryId!));

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
            const Text(
              "Mahsulotlar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              products.length,
              (index) {
                if (index != products.length) {
                  return _buildIngredientRow(index);
                }
                return const Text("Error");
              },
            ),
            const SizedBox(height: 12),
            const Text(
              "Tayyorlash jarayoni",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              products.length,
              (index) {
                if (index != products.length) {
                  return _buildServesRow(index);
                }
                return const Text("Error");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientRow(int index) {
    return Row(
      children: [
        const Text(
          "  ·  ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Text("Tuxum   4 dona", style: originTextStyle),
      ],
    );
  }

  Widget _buildServesRow(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${index + 1}-jarayon: ${products[index]['name']}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
            "An interpunct ·, also known as an interpoint, middle dot, middot, centered dot or centred dot, is a punctuation mark consisting of a vertically centered dot used for interword separation in Classical Latin. (Word-separating spaces did not appear until some time between 600 and 800 CE.)",
            style: originTextStyle),
        const SizedBox(height: 14),
      ],
    );
  }
}
