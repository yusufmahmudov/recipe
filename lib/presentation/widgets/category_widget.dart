import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/assets/icons.dart';
import 'package:recipe/data/model/category_model.dart';
import 'package:recipe/presentation/views/add/add_category_view.dart';
import 'package:recipe/presentation/views/add/add_product_view.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (category.id == -1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCategoryView(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductView(categoryId: category.id!),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              redOrange,
              redOrange,
              redOrange20,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                selectIcon(),
                const SizedBox(width: 8),
                Text(
                  "${category.name}",
                  style: const TextStyle(color: white, fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SvgPicture selectIcon() {
    return AppIcons.recipe.svg(width: 32, height: 32, color: white);
  }
}
