import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/assets/icons.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              redOrange,
              Color.fromARGB(255, 253, 95, 97),
              Color.fromARGB(255, 242, 118, 118),
              Color.fromARGB(255, 239, 151, 151),
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
            transform: GradientRotation(0.5),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: AppIcons.recipe.svg(height: 180, color: white),
          ),
        ),
      ),
    );
  }
}
