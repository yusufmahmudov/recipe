import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/presentation/views/home/product_view.dart';

class MyRecipeWidget extends StatelessWidget {
  final ProductModel product;

  const MyRecipeWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductView(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyBack.withOpacity(.12)),
          color: greyBack.withOpacity(.12),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Background.png', // Rasm manzili
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!, // category
                    style: const TextStyle(
                      fontSize: 14,
                      color: redOrange40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.name!,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                style:
                                    const TextStyle(fontSize: 14, color: black),
                                children: [
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.access_time_sharp,
                                      size: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: product.time!,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
