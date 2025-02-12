import 'package:flutter/material.dart';

import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/presentation/widgets/w_button.dart';

class ServesView extends StatefulWidget {
  final List<Map<String, String>> preparations;

  const ServesView({super.key, required this.preparations});

  @override
  State<ServesView> createState() => _ServesViewState();
}

class _ServesViewState extends State<ServesView> {
  final TextEditingController controllerProcessName = TextEditingController();
  final TextEditingController controllerProcess = TextEditingController();

  void _addPreparation() {
    if (controllerProcessName.text.isNotEmpty &&
        controllerProcess.text.isNotEmpty) {
      setState(() {
        widget.preparations.add({
          'name': controllerProcessName.text,
          'body': controllerProcess.text,
        });
        controllerProcessName.clear();
        controllerProcess.clear();
      });
    }
  }

  void _removePreparation(int index) {
    setState(() {
      widget.preparations.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          "Tayyorlash jarayonlari",
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: WButton(
          color: redOrange,
          height: 54,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          text: "Saqlash",
          onTap: () {
            if (controllerProcessName.text.isNotEmpty &&
                controllerProcess.text.isNotEmpty) {
              setState(
                () {
                  widget.preparations.add(
                    {
                      'name': controllerProcessName.text,
                      'body': controllerProcess.text,
                    },
                  );
                  controllerProcessName.clear();
                  controllerProcess.clear();
                },
              );
            }
            Navigator.pop(context, widget.preparations);
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
                itemCount: widget.preparations.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.preparations.length) {
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
                "${widget.preparations.length + 1}-jarayon",
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
            hintText: widget.preparations[index]['name']!,
            borderColor: greyBack.withOpacity(.8),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            maxLines: 3,
            expands: false,
            noHeight: true,
            minLines: 3,
            readOnly: true,
            hintText: widget.preparations[index]['body']!,
            borderColor: greyBack.withOpacity(.8),
          ),
        ],
      ),
    );
  }
}
