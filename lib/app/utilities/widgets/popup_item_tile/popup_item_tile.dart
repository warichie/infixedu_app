import 'package:flutter/material.dart';

import '../../../data/constants/app_text_style.dart';

class PopupItemTile extends StatelessWidget {
  const PopupItemTile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.fontSize12GreyW400,
    );
  }
}
