import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/presentation/widgets/custom_botton.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Background.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(height: 400),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Let's Cooking",
                      style: TextStyle(
                          fontSize: 50,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 208,
                    child: Text(
                      "Find best recipes for cooking",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: white),
                    ),
                  ),
                  const SizedBox(height: 70),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomBotton()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
