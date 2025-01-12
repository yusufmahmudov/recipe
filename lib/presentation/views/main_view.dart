import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/assets/colors/colors.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        selectedItemColor: redOrange,
        unselectedItemColor: redOrange20,
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          _onTap(context, value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_rounded),
            label: 'Recipe',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications_rounded),
          //   label: 'Notfication',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
