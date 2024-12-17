import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/application/category/category_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/presentation/views/add/add_category_view.dart';
import 'package:recipe/presentation/widgets/category_widget.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(GetCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: redOrange,
        title: const Text(
          "Kategoriyalar",
          style: TextStyle(
            fontSize: 26,
            color: white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
            size: 26,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 28,
                color: white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCategoryView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: BlocBuilder<CategoryBloc, CategoryState>(
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
                  "Kategoriyalar ro'yxati bo'sh",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            state.categoryes.sort(
              (a, b) => a.name.toString().compareTo(b.name.toString()),
            );

            return ListView.separated(
              itemCount: state.categoryes.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (BuildContext context, int index) {
                return CategoryWidget(
                  category: state.categoryes[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
