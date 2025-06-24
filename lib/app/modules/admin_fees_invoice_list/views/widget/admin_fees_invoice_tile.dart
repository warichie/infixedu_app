import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/popup_item_tile/popup_item_tile.dart';
import 'package:get/get.dart';

class AdminFeesInvoiceTile extends StatelessWidget {
  final String? studentName;
  final String? studentClass;
  final String? studentSection;
  final String? date;
  final String? amount;
  final String? paid;
  final String? balance;
  final String? status;
  final Color? statusColor;
  final Function()? onTapView;
  final Function()? onTapViewTransaction;
  final Function()? onTapDelete;

  const AdminFeesInvoiceTile({
    super.key,
    this.studentName,
    this.studentClass,
    this.studentSection,
    this.date,
    this.amount,
    this.paid,
    this.balance,
    this.status,
    this.statusColor,
    this.onTapView,
    this.onTapViewTransaction,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${studentName ?? ""} (${studentClass ?? ""} - ${studentSection ?? ""})",
                style: AppTextStyle.homeworkSubject,
              ),
              Row(
                children: [
                  Text(
                    date ?? "",
                    style: AppTextStyle.homeworkSubject,
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    iconColor: AppColors.homeworkSubjectColor,
                    iconSize: 20,
                    color: Colors.white,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: onTapView,
                        height: 40.h,
                        child: PopupItemTile(title: "View".tr),
                      ),
                    ],
                  ),
                ],
              ),
              5.verticalSpacing,
              Row(
                children: [
                  ColumnTile(
                    title: "Amount",
                    value: amount ?? "",
                  ),
                  ColumnTile(
                    title: "Paid",
                    value: paid ?? "",
                    width: Get.width * 0.2,
                  ),
                  ColumnTile(
                    title: "Balance",
                    value: balance ?? "",
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status",
                        style: AppTextStyle.fontSize13BlackW400,
                      ),
                      5.verticalSpacing,
                      Container(
                        width: Get.width * 0.2,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: statusColor),
                        child: Center(
                          child: Text(
                            status ?? "",
                            style: AppTextStyle.textStyle12WhiteW400,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.customDividerColor,
        ),
      ],
    );
  }
}
