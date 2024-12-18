import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:recipe/application/product/product_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/assets/constants/storage_keys.dart';
import 'package:recipe/data/model/category_model.dart';
import 'package:recipe/data/model/g_model/product_model_g.dart';
import 'package:recipe/infrasuruktura/apis/category_service.dart';
import 'package:recipe/infrasuruktura/apis/product_service.dart';
import 'package:recipe/infrasuruktura/repo/storage_repository.dart';
import 'package:recipe/presentation/views/add/serves_view.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/presentation/widgets/w_button.dart';
import 'package:recipe/utils/custom_toast_bar.dart';
import 'package:recipe/utils/log_service.dart';

class AddProductView extends StatefulWidget {
  final CategoryModel categoryModel;
  const AddProductView({super.key, required this.categoryModel});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  late TextEditingController controllerRecipe;
  late TextEditingController controllerPortion;
  final TextEditingController controllerItemName = TextEditingController();
  final TextEditingController controllerQuantity = TextEditingController();
  late ValueNotifier<int> selHour;
  late ValueNotifier<int> selMinute;
  final ProductService productService = ProductService();
  final CategoryService categoryService = CategoryService();
  List<CategoryModel> categoryes = [];
  List<Map<String, String>> preparations = [];
  List<Map<String, String>> ingredients = [];
  String? categorySelectedVal;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    controllerRecipe = TextEditingController();
    controllerPortion = TextEditingController();
    selHour = ValueNotifier(0);
    selMinute = ValueNotifier(0);
    super.initState();
  }

  void _addIngredient() {
    if (controllerItemName.text.isNotEmpty &&
        controllerQuantity.text.isNotEmpty) {
      setState(() {
        ingredients.add(
          {
            'name': controllerItemName.text,
            'quantity': controllerQuantity.text,
          },
        );
        controllerItemName.clear();
        controllerQuantity.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  void navigateToServesPage(BuildContext context) async {
    final List<Map<String, String>> preparationSteps = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServesView(preparations: preparations),
      ),
    );
    // ignore: unnecessary_null_comparison
    if (preparationSteps != null) {
      setState(() {
        preparations = preparationSteps;
      });
    }
  }

  String timeSetup() {
    return "${selHour.value < 10 ? '0' : ''}${selHour.value}:${selMinute.value < 10 ? '0' : ''}${selMinute.value}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: redOrange,
        title: const Text(
          'Yangi retsept',
          style: TextStyle(
            fontSize: 24,
            color: white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return WButton(
              color: redOrange,
              height: 54,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              text: "Saqlash",
              onTap: () {
                if (controllerItemName.text.isNotEmpty &&
                    controllerQuantity.text.isNotEmpty) {
                  setState(
                    () {
                      ingredients.add(
                        {
                          'name': controllerItemName.text,
                          'quantity': controllerQuantity.text,
                        },
                      );
                      controllerItemName.clear();
                      controllerQuantity.clear();
                    },
                  );
                }
                if (controllerRecipe.text.isEmpty) {
                  showCustomToast(
                      context: context,
                      message: "Retsept nomi bo'sh bo'lmasligi kerak!");
                } else if (controllerPortion.text.isEmpty) {
                  showCustomToast(
                      context: context,
                      message: "Retsept portsiyasini kiriting!");
                } else if (ingredients.isEmpty) {
                  showCustomToast(
                      context: context,
                      message: "Mahsulotlar ro'yxatini kiriting!");
                } else if (preparations.isEmpty) {
                  showCustomToast(
                      context: context,
                      message: "Tayyorlash jarayonlarini yozishingiz kerak");
                } else {
                  String time = timeSetup();
                  int userId = StorageRepository.getInt(StorageKeys.USERID);

                  final ProductModelG product = ProductModelG(
                    name: controllerRecipe.text,
                    portion: int.tryParse(controllerPortion.text) ?? 0,
                    time: time,
                    categoryId: widget.categoryModel.id,
                    categoryName: widget.categoryModel.name,
                    ingredientCount: ingredients.length,
                    userId: userId,
                  );
                  Log.i(product.categoryName);
                  context.read<ProductBloc>().add(
                        AddProductEvent(
                          productG: product,
                          ingredients: ingredients,
                          preparations: preparations,
                          image: _image,
                        ),
                      );

                  if (state.statusProduct.isFailure) {
                    showCustomToast(
                        context: context,
                        message: "Nimadir xato ketdi, Retsept saqlanmadi!");
                  } else if (state.statusProduct.isSuccess) {
                    showCustomToast(
                      context: context,
                      message: "Retsept saqlandi",
                      color: green,
                    );
                  }
                }
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_camera),
                  onPressed: () async => _pickImageFromCamera(),
                  color: black,
                ),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () async => _pickImageFromGallery(),
                  color: black,
                ),
              ],
            ),
            Container(
              width: 334,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: greyBack.withOpacity(.18),
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text('Rasm tanlanmagan'),
                    ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              // onChanged: () {},
              borderColor: redOrange,
              controller: controllerRecipe,
              hintText: "Retsept nomi",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              // onChanged: () {},
              borderColor: redOrange,
              controller: controllerPortion,
              hintText: "Retsept portsiyasi",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => navigateToServesPage(context),
              child: Container(
                padding: const EdgeInsets.only(right: 12),
                height: 60,
                decoration: BoxDecoration(
                  color: greyBack.withOpacity(.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: const Icon(
                            Icons.supervisor_account_rounded,
                            color: redOrange,
                            size: 30,
                          ),
                        ),
                        const Text(
                          "Tayyorlash jarayonlari",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: black,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (_) => buildTimePicker(),
                // barrierColor: Colors.black,
              ),
              child: Container(
                padding: const EdgeInsets.only(right: 12),
                height: 60,
                decoration: BoxDecoration(
                  color: greyBack.withOpacity(.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: white,
                          ),
                          child: const Icon(
                            Icons.access_time_filled_sharp,
                            color: redOrange,
                            size: 24,
                          ),
                        ),
                        const Text(
                          "Tayyorlanish vaqti",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: black,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mahsulotlar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              ingredients.length + 1,
              (index) {
                if (index == ingredients.length) {
                  return _buildAddNewIngredientRow();
                }
                return _buildIngredientRow(index);
              },
            ),
            GestureDetector(
              onTap: _addIngredient,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Yangi mahsulot qo'shish",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: black),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                readOnly: true,
                hintText: ingredients[index]['name']!,
                hintTextColor: black,
                borderColor: redOrange,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                readOnly: true,
                hintText: ingredients[index]['quantity']!,
                hintTextColor: black,
                borderColor: redOrange,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => _removeIngredient(index),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewIngredientRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                controller: controllerItemName,
                hintText: 'Mahsulot nomi',
                borderColor: redOrange,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                controller: controllerQuantity,
                hintText: 'Miqdori',
                borderColor: redOrange,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _addIngredient,
          ),
        ],
      ),
    );
  }

  Widget buildTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 160),
      child: AlertDialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text("Vaqtni tanlang"),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "OK",
              style: TextStyle(color: black, fontSize: 18),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: selHour,
                builder: (BuildContext context, int value, Widget? child) {
                  return CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 60,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selHour.value = index;
                      });
                    },
                    children: List<Widget>.generate(24, (int index) {
                      return Center(
                        child: Text(
                          '$index h',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 32),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: selMinute,
                builder: (BuildContext context, int value, Widget? child) {
                  return CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 60,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selMinute.value = index;
                      });
                    },
                    children: List<Widget>.generate(
                      60,
                      (int index) {
                        return Center(
                          child: Text(
                            '$index m',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 32),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
