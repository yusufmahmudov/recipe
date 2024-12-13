import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';

class MyRecipeWidget extends StatelessWidget {
  final dynamic product;

  const MyRecipeWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                const Text(
                  "Ramyon",
                  style: TextStyle(
                    fontSize: 14,
                    color: redOrange40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Pepper sweetcorn ramen",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 8, vertical: 4),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[200],
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: const Text(
                    //     "Easy",
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                    // ),
                    // const SizedBox(width: 5),
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
                            text: const TextSpan(
                              style: TextStyle(fontSize: 14, color: black),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.access_time_sharp,
                                    size: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 15 Minut',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(width: 5),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 8, vertical: 4),
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[200],
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: const Text(
                    //     "4.8",
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
