import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/presentation/views/notification/epub_view_page.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  void navigateToBooksItemPage(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const PdfsView(),
    //   ),
    // );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EpubViewPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          "Books",
        ),
      ),
      body: GridView.builder(
        itemCount: 3,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 196,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToBooksItemPage(context),
            child: const BookItems(),
          );
        },
      ),
    );
  }
}

class BookItems extends StatelessWidget {
  const BookItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                height: 138,
                width: 138,
                "assets/images/book.png",
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text(
                "Book",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: black,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
