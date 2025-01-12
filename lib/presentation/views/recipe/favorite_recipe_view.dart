import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/application/product/product_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/presentation/views/add/category_view.dart';
import 'package:recipe/presentation/views/home/product_view.dart';
import 'package:recipe/presentation/views/recipe/my_recipe_widget.dart';
import 'package:recipe/presentation/widgets/w_tabbar.dart';

class FavoriteRecipeView extends StatefulWidget {
  const FavoriteRecipeView({super.key});

  @override
  State<FavoriteRecipeView> createState() => _FavoriteRecipeViewState();
}

class _FavoriteRecipeViewState extends State<FavoriteRecipeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void navigateToProductPage(BuildContext context, ProductModel product) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => ProductView(product: product, index: 1),
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
    context.read<ProductBloc>().add(GetFavoriteProductEvent());

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        // Sevimli retseptlarni yuklash
        context.read<ProductBloc>().add(GetFavoriteProductEvent());
      } else {
        // Mening retseptlarimni yuklash
        context.read<ProductBloc>().add(GetProductsByUserIdEvent());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
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
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<ProductBloc>().add(GetFavoriteProductEvent());
            await Future.delayed(Duration.zero);
          },
          child: TabBarView(
            controller: _tabController,
            children: [
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state.statusFavorite.isInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        strokeWidth: 4.0,
                      ),
                    );
                  } else if (state.favoriteProducts.isEmpty) {
                    return const Center(
                      child: Text(
                        "Retseptlar ro'yxati bo'sh",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return GridView.builder(
                    itemCount: state.favoriteProducts.length,
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 232,
                    ),
                    itemBuilder: (context, index) {
                      // ignore: collection_methods_unrelated_type
                      final product = state.products[index];
                      return GestureDetector(
                        onTap: () => navigateToProductPage(context, product),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Vaqt",
                                              style: TextStyle(color: gray),
                                            ),
                                            Text(
                                              product.time!,
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
                  );
                },
              ),
              RefreshIndicator.adaptive(
                onRefresh: () async {
                  context.read<ProductBloc>().add(GetProductsByUserIdEvent());
                  await Future.delayed(Duration.zero);
                },
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state.statusProduct.isInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          strokeWidth: 4.0,
                        ),
                      );
                    } else if (state.products.isEmpty) {
                      return const Center(
                        child: Text(
                          "Retseptlar ro'yxati bo'sh",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) =>
                          MyRecipeWidget(product: state.products[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: state.products.length,
                    );
                  },
                ),
              ),
            ],
          ),
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
