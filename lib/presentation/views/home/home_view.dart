import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/infrasuruktura/apis/product_service.dart';
import 'package:recipe/presentation/views/home/product_view.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/utils/log_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ValueNotifier<int> selIndex = ValueNotifier(0);
  final List<String> categories = [
    "Salad",
    "Breakfast",
    "Appetizer",
    "Noodle",
    "Salad",
    "Breakfast",
    "Appetizer",
    "Noodle",
  ];

  final List<Map<String, dynamic>> products = [
    {
      "name": "Burger manti xonim",
      "time": "40 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Peper non kabob rapmen",
      "time": "20 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
    {
      "name": "Pepper sweetcorn ramen",
      "time": "10 Mins",
      "image": "assets/ramen.png",
      "isSelected": false,
    },
  ];

  final List<ProductModel> product = [];

  // final List<Map<String, dynamic>> selectedProduct = [];

  void navigateToProductPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProductView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const CustomTextField(
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            borderColor: gray,
            borderRadius: 10,
            enableBorderColor: red,
            hintText: 'Search recipe',
            suffixIcon: Icon(
              CupertinoIcons.search,
              color: gray,
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: 48,
                child: ValueListenableBuilder(
                  valueListenable: selIndex,
                  builder: (context, value, child) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => selIndex.value = index,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 34,
                          decoration: BoxDecoration(
                            color:
                                value == index ? redOrange : Colors.transparent,
                            border: value == index
                                ? Border.all(color: redOrange)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                categories[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: value == index ? white : redOrange20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          body: FutureBuilder(
            future: ProductService().fetchProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              Log.d(snapshot.data?.length);

              return GridView.builder(
                itemCount: snapshot.data?.length,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 232,
                ),
                itemBuilder: (context, index) {
                  // ignore: collection_methods_unrelated_type
                  final product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () => navigateToProductPage(context),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            width: 150,
                            height: 170,
                            decoration: BoxDecoration(
                              color: greyBack.withOpacity(.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  maxLines: 2,
                                  product.name!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Time",
                                          style: TextStyle(color: gray),
                                        ),
                                        Text(
                                          "${product.time}",
                                        ),
                                      ],
                                    ),
                                    // IconButton(
                                    //   icon: Icon(
                                    //     products[index]['isSelected']
                                    //         ? Icons.favorite
                                    //         : Icons.favorite_border_outlined,
                                    //   ),
                                    //   color: products[index]['isSelected']
                                    //       ? redOrange
                                    //       : natural20,
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       products[index]['isSelected'] =
                                    //           !products[index]['isSelected'];
                                    //     });
                                    //   },
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  color: natural20,
                                  spreadRadius: 3),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 56,
                            backgroundImage:
                                AssetImage("assets/images/Background.png"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
