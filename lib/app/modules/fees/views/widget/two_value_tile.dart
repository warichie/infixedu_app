import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';

class TwoValueTile extends StatelessWidget {
  final String? title;
  final String? amount;
  final bool isDueBalance;

  const TwoValueTile({
    super.key,
    this.title,
    this.amount,
    this.isDueBalance = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: isDueBalance
                ? AppTextStyle.fontSize16lightBlackW500
                : AppTextStyle.fontSize13BlackW400,
          ),
          Text(
            amount.toString(),
            style: isDueBalance
                ? AppTextStyle.blackFontSize14W400
                : AppTextStyle.homeworkElements,
          ),
        ],
      ),
    );
  }
}
