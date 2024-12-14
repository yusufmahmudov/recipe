import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/dto/product_dto.dart';
import 'package:recipe/presentation/views/add/category_view.dart';
import 'package:recipe/presentation/views/home/product_view.dart';
import 'package:recipe/presentation/views/recipe/my_recipe_widget.dart';
import 'package:recipe/presentation/widgets/w_tabbar.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void navigateToProductPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProductView(),
      ),
    );
  }

  void navigateToNewProductPage(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const CategoryView(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Tab o'zgarganda UI yangilanishi uchun
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Retseptlar",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26),
          ),
          centerTitle: true,
          actions: [
            if (_tabController.index == 1)
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 32,
                ),
                onPressed: () {
                  navigateToNewProductPage(context);
                },
              ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 56),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: WTabBar(
                tabController: _tabController,
                tabs: const [
                  Text(
                    "Sevimlilar",
                    maxLines: 1,
                  ),
                  Text(
                    "Mening retseptlarim",
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 232,
              ),
              itemBuilder: (context, index) {
                // ignore: collection_methods_unrelated_type
                final product = products[index];
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
                                product['name'],
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
                                        product['time'],
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.favorite,
                                    color: redOrange,
                                  ),
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
            ),
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) =>
                  MyRecipeWidget(product: products[index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              itemCount: products.length,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
