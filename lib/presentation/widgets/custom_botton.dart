import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/assets/colors/colors.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go("/home");
      },
      child: Container(
        height: 56,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 100),
        decoration: BoxDecoration(
          color: redOrange,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
