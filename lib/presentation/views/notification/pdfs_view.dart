import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/utils/log_service.dart';

class PdfsView extends StatefulWidget {
  const PdfsView({super.key});

  @override
  State<PdfsView> createState() => _PdfsViewState();
}

class _PdfsViewState extends State<PdfsView> {
  // late PdfControllerPinch pdfControllerPinch;
  late PdfController pdfController;
  int totalPageCount = 0, currentPage = 1;

  @override
  void initState() {
    try {
      // pdfControllerPinch = PdfControllerPinch(
      //   document: PdfDocument.openAsset("assets/pdfs/11111.pdf"),
      // );   https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf
      pdfController = PdfController(
        document: PdfDocument.openAsset('assets/pdfs/22222.pdf'),
      );
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
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const Text("Books"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Total page: $totalPageCount"),
              IconButton(
                onPressed: () {
                  pdfController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              Text("$currentPage"),
              IconButton(
                onPressed: () {
                  pdfController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                ),
              ),
            ],
          ),
          pdfWidget()
        ],
      ),
    );
  }

  Widget pdfWidget() {
    return Expanded(
      child: PdfView(
        scrollDirection: Axis.horizontal,
        controller: pdfController,
        onDocumentLoaded: (document) {
          setState(() {
            totalPageCount = document.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}
