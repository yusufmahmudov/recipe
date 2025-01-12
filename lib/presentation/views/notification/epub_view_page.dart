import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';

class EpubViewPage extends StatefulWidget {
  const EpubViewPage({super.key});

  @override
  State<EpubViewPage> createState() => _EpubViewPageState();
}

class _EpubViewPageState extends State<EpubViewPage> {
  late EpubController _epubReaderController;

  @override
  void initState() {
    _epubReaderController = EpubController(
      document: EpubDocument.openAsset('assets/pdfs/bbbbb.epub'),
    );
    super.initState();
  }

  @override
  void dispose() {
    _epubReaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubReaderController,
          builder: (chapterValue) => Text(
            chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
            textAlign: TextAlign.start,
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: white,
        child: EpubViewTableOfContents(controller: _epubReaderController),
      ),
      body: EpubView(
        builders: EpubViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          chapterDividerBuilder: (_) => const Divider(),
        ),
        controller: _epubReaderController,
      ),
    );
  }
}
