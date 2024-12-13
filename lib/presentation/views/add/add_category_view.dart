import 'package:flutter/material.dart';

import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/category_model.dart';
import 'package:recipe/data/model/g_model/category_model_g.dart';
import 'package:recipe/infrasuruktura/apis/category_service.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/presentation/widgets/w_button.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final CategoryService categoryService = CategoryService();
  final TextEditingController controllerCategory = TextEditingController();
  List<CategoryModel> categorys = [];

  Future<void> _submitForm() async {
    final CategoryModelG model = CategoryModelG(name: controllerCategory.text);

    await categoryService.addCategory(model);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<List<CategoryModel>> _getAll() async {
    categorys = await categoryService.fetchCategoryes();

    return categorys;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategoriya qo'shish"),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: WButton(
          color: redOrange,
          height: 54,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          text: "Saqlash",
          onTap: () {
            _submitForm();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kategoriya qo'shishdan avval, kategoriyalar ro'yxatini ko'rib chiqing!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => buildCategoryList(),
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: greyBack.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kategoriyalar ro'yxati",
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: black,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
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

  Widget buildCategoryList() {
    _getAll();
    return AlertDialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text("Kategoriyalar"),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "Ortga qaytish",
            style: TextStyle(color: black, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categorys.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${index + 1} - ${categorys[index].name!}"),
            );
          },
        ),
      ),
    );
  }
}
