import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/application/category/category_bloc.dart';
import 'package:recipe/application/product/product_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/product_model.dart';
import 'package:recipe/presentation/views/home/product_view.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ValueNotifier<int> selIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoryEvent());
    context
        .read<ProductBloc>()
        .add(GetProductsByCategoryEvent(categoryId: selIndex.value));
  }

  void navigateToProductPage(BuildContext context, ProductModel product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductView(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
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
                    return BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state.statusCategory.isInProgress) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              strokeWidth: 4.0,
                            ),
                          );
                        } else if (state.categoryes.isEmpty) {
                          return const Center(
                            child: Text(
                              "Category ro'yxati bo'sh",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemCount: state.categoryes.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => selIndex.value = index,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 34,
                              decoration: BoxDecoration(
                                color: value == index
                                    ? redOrange
                                    : Colors.transparent,
                                border: value == index
                                    ? Border.all(color: redOrange)
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.categoryes[index].name!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          value == index ? white : redOrange20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
          body: BlocBuilder<ProductBloc, ProductState>(
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
              return GridView.builder(
                itemCount: state.products.length,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
