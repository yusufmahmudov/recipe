import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:recipe/assets/colors/colors.dart';

void showCustomToast(
    {required BuildContext context,
    required String message,
    int time = 3,
    Color color = red}) {
  DelightToastBar(
    builder: (context) => ToastCard(
      title: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: color,
        ),
      ),
    ),
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
    snackbarDuration: Duration(seconds: time),
  ).show(context);
}
