import 'package:flutter/material.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';

ButtonStyle mainButtonStyle({
  required Color mainColor,
  double borderRadius = AppDimens.radius12,
}) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all(
      mainColor,
    ),
    overlayColor: WidgetStateColor.resolveWith(
      (states) => AppColors.primaryColor,
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
    ),
  );
}
