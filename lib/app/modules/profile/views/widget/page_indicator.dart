import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return CustomDivider(
      width: 50,
      color: isActive ? AppColors.profileIndicatorColor : Colors.white,
    );
  }
}
