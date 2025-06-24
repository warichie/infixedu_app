import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:get/get.dart';

class CreditCard extends StatelessWidget {
  final String? bankName;
  final String? accountName;
  final String? type;
  final String? accountNumber;

  const CreditCard({
    super.key,
    this.bankName,
    this.accountName,
    this.type,
    this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bankName ?? "",
            style: AppTextStyle.blackFontSize14W400,
          ),
          10.verticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnTile(
                title: "Account Name".tr,
                value: accountName,
              ),
              ColumnTile(
                width: Get.width * 0.25,
                title: "Account Number".tr,
                value: accountNumber.toString(),
              ),
              ColumnTile(
                title: "Type".tr,
                value: type,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
