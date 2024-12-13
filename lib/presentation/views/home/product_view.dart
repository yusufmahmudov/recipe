import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/dto/product_dto.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retsept'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Burger xonim manti",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
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
                    Text("SHirinlik", style: originTextStyle),
                    Text("3", style: originTextStyle),
                    Text("2:45", style: originTextStyle),
                    Text("8 dona", style: originTextStyle),
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
