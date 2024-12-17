import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/application/category/category_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/g_model/category_model_g.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/presentation/widgets/w_button.dart';
import 'package:recipe/utils/custom_toast_bar.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final TextEditingController controllerCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: redOrange,
        title: const Text(
          "Kategoriya qo'shish",
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
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return WButton(
              color: redOrange,
              height: 54,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              text: "Saqlash",
              onTap: () {
                if (controllerCategory.text.isNotEmpty) {
                  context.read<CategoryBloc>().add(
                        AddCategoryEvent(
                          category:
                              CategoryModelG(name: controllerCategory.text),
                        ),
                      );
                  if (state.statusCategory.isSuccess) {
                    showCustomToast(
                        context: context,
                        message: "Yangi kategoriya saqlandi",
                        color: green);
                    Navigator.pop(context);
                  } else if (state.statusCategory.isFailure) {
                    showCustomToast(
                        context: context, message: "Xatolik yuz berdi");
                    Navigator.pop(context);
                  }
                } else {
                  showCustomToast(
                      context: context, message: "Kategoriya nomini kiriting!");
                }
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controllerCategory,
              title: "Kategoriya qo'shish",
              hintText: "Kategoriya nomi",
              borderColor: redOrange,
            ),
          ],
        ),
      ),
    );
  }
}
