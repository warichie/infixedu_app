import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:get/get.dart';

class InvoiceCard extends StatelessWidget {
  final String? feesType;
  final String? amount;
  final String? due;
  final Function()? onTap;

  const InvoiceCard({
    super.key,
    this.feesType,
    this.amount,
    this.due,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: const Color(0xFFEAE7F0)),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feesType ?? '_',
                  style: AppTextStyle.fontSize14Color862CFFWight600,
                ),
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      '${"Amount".tr}: $amount',
                      style: AppTextStyle.fontSize14Color635976Wight400,
                    )),
                    5.horizontalSpacing,
                    const CustomDivider(
                      width: 2,
                      height: 15,
                      color: Color(0xFF635976),
                    ),
                    5.horizontalSpacing,
                    Flexible(
                        child: Text(
                      '${"Due".tr}: $due',
                      style: AppTextStyle.fontSize14Color635976Wight400,
                    )),
                  ],
                ),
              ],
            ),
          ),
          PrimaryButton(
            text: "Pay Now".tr,
            width: 75.w,
            height: 26,
            borderRadius: 4.w,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
