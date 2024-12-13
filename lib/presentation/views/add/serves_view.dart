import 'package:flutter/material.dart';

import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/presentation/widgets/w_button.dart';

class ServesView extends StatefulWidget {
  const ServesView({super.key});

  @override
  State<ServesView> createState() => _ServesViewState();
}

class _ServesViewState extends State<ServesView> {
  final TextEditingController controllerProcessName = TextEditingController();
  final TextEditingController controllerProcess = TextEditingController();

  List<Map<String, String>> preparations = [];

  void _addPreparation() {
    if (controllerProcessName.text.isNotEmpty &&
        controllerProcess.text.isNotEmpty) {
      setState(() {
        preparations.add({
          'name': controllerProcessName.text,
          'process': controllerProcess.text,
        });
        controllerProcessName.clear();
        controllerProcess.clear();
      });
    }
  }

  void _removePreparation(int index) {
    setState(() {
      preparations.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tayyorlash jarayonlari",
          style: TextStyle(fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: WButton(
          color: redOrange,
          height: 54,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          text: "Saqlash",
          onTap: () {
            Navigator.pop(context, preparations);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jarayonlar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: preparations.length + 1,
                itemBuilder: (context, index) {
                  if (index == preparations.length) {
                    return _buildAddNewPreparationRow();
                  }
                  return _buildPreparationRow(index);
                },
              ),
            ),
            GestureDetector(
              onTap: _addPreparation,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      "Yangi jarayon qo'shish",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewPreparationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${preparations.length + 1}-jarayon",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => _addPreparation(),
              ),
            ],
          ),
          CustomTextField(
            controller: controllerProcessName,
            hintText: "Jarayon nomi",
            borderColor: greyBack.withOpacity(.8),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            maxLines: 3,
            expands: false,
            noHeight: true,
            minLines: 3,
            controller: controllerProcess,
            hintText: "Tayyorlash ketma-ketligi...",
            borderColor: greyBack.withOpacity(.8),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparationRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${index + 1}-jarayon",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => _removePreparation(index),
              ),
            ],
          ),
          CustomTextField(
            readOnly: true,
            hintText: preparations[index]['name']!,
            borderColor: greyBack.withOpacity(.8),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            maxLines: 3,
            expands: false,
            noHeight: true,
            minLines: 3,
            readOnly: true,
            hintText: preparations[index]['process']!,
            borderColor: greyBack.withOpacity(.8),
          ),
        ],
      ),
    );
  }
}
