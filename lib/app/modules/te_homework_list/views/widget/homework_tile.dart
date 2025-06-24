import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class HomeworkTile extends StatelessWidget {
  final String? createDate;
  final String? submissionDate;
  final String? evaluation;
  final String? marks;
  final String? subject;
  final Function()? onDetailsTap;
  final Function()? onEvaluationTap;
  final Function()? onDownloadTap;
  final bool isEvaluation;
  final String? studentClass;
  final String? studentSection;
  final String? studentName;
  final double? widthOfFirstContainer;
  final double? widthOfSecondContainer;
  final double? widthOfThirdContainer;
  final Color? downloadContainerColor;
  final Color? evaluateContainerColor;
  final String? admissionNo;

  const HomeworkTile({
    super.key,
    this.createDate,
    this.submissionDate,
    this.evaluation,
    this.marks,
    this.subject,
    this.onDetailsTap,
    this.onEvaluationTap,
    this.isEvaluation = false,
    this.studentClass,
    this.studentSection,
    this.studentName,
    this.widthOfFirstContainer,
    this.widthOfSecondContainer,
    this.widthOfThirdContainer,
    this.downloadContainerColor,
    this.evaluateContainerColor,
    this.onDownloadTap,
    this.admissionNo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            children: [
              Container(
                width: widthOfFirstContainer,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.homeworkWidgetColor),
                child: Center(
                  child: Text(
                    isEvaluation ? admissionNo ?? "" : studentClass.toString(),
                    style: AppTextStyle.notificationText,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
                child: const VerticalDivider(
                  color: AppColors.transportDividerColor,
                  thickness: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                width: widthOfSecondContainer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.homeworkWidgetColor),
                child: Center(
                  child: Text(
                    isEvaluation ? studentName ?? "N/A" : studentSection ?? "_",
                    style: AppTextStyle.notificationText,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
                child: const VerticalDivider(
                  color: AppColors.transportDividerColor,
                  thickness: 1,
                ),
              ),
              isEvaluation
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.all(6),
                      width: widthOfThirdContainer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: AppColors.activeStatusGreenColor),
                      child: Center(
                        child: Text(
                          subject.toString(),
                          style: AppTextStyle.textStyle10WhiteW400,
                        ),
                      ),
                    ),
              isEvaluation
                  ? const SizedBox()
                  : SizedBox(
                      height: Get.height * 0.04,
                      child: const VerticalDivider(
                        color: AppColors.transportDividerColor,
                        thickness: 1,
                      ),
                    ),
              Expanded(
                child: Row(
                  mainAxisAlignment: isEvaluation
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    isEvaluation
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: onDownloadTap,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: downloadContainerColor),
                                child: Image.asset(
                                  ImagePath.download,
                                  color: Colors.white,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: onDetailsTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: AppColors.profileValueColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Details".tr,
                                  style: AppTextStyle.textStyle10WhiteW400,
                                ),
                              ),
                            ),
                          ),
                    5.horizontalSpace,
                    Flexible(
                      child: InkWell(
                        onTap: onEvaluationTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: evaluateContainerColor,
                          ),
                          child: Center(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              isEvaluation ? "Evaluate".tr : "Evaluation".tr,
                              style: AppTextStyle.textStyle10WhiteW400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.transportDividerColor,
        )
      ],
    );
  }
}
