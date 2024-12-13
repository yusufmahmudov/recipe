import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const orders = "assets/icons/orders.svg";
  static const home = "assets/icons/home.svg";
  static const employs = "assets/icons/employs.svg";
  static const carbonDashboard = "assets/icons/carbon_dashboard.svg";
  static const tablerEdit = "assets/icons/tabler_edit.svg";
  static const sklad = "assets/icons/sklad.svg";
  static const user = "assets/icons/user.svg";

  static const recipe = "assets/icons/recipe.svg";
}

extension SvgExt on String {
  SvgPicture svg({
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      this,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      width: width,
      height: height,
    );
  }
}
