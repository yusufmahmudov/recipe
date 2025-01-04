import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:recipe/utils/log_service.dart';

class PdfsView extends StatefulWidget {
  const PdfsView({super.key});

  @override
  State<PdfsView> createState() => _PdfsViewState();
}

class _PdfsViewState extends State<PdfsView> {
  late PdfControllerPinch pdfControllerPinch;
  late PdfController pdfController;

  @override
  void initState() {
    Log.i("pdfController.document");

    try {
      pdfControllerPinch = PdfControllerPinch(
        document: PdfDocument.openAsset("assets/pdfs/11111.pdf"),
      );
      pdfController = PdfController(
        document: PdfDocument.openAsset('assets/pdfs/11111.pdf'),
      );
      Log.i(pdfController.document);
    } catch (e) {
      Log.e(e);
    }
    super.initState();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: Column(
        children: [
          const Row(
            children: [],
          ),
          pdfWidget()
        ],
      ),
    );
  }

  Widget pdfWidget() {
    return Expanded(
      child: PdfView(
        scrollDirection: Axis.vertical,
        controller: pdfController,
      ),
    );
  }
}
