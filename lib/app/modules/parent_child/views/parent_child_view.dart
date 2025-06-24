import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/student_list_tile/student_list_tile.dart';

import 'package:get/get.dart';

import '../controllers/parent_child_controller.dart';

class ParentChildView extends GetView<ParentChildController> {
  const ParentChildView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Students List".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            Obx(
              () => Expanded(
                  child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async {
                  controller.getParentsChildData(
                      parentId: controller
                          .globalRxVariableController.parentId.value!);
                },
                child: controller.isLoading.value
                    ? const SecondaryLoadingWidget()
                    : controller.parentChildList.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.parentChildList.length,
                            itemBuilder: (context, index) {
                              return StudentListTile(
                                onTap: () {
                                  controller.globalRxVariableController
                                          .studentId.value =
                                      controller
                                          .parentChildList[index].studentId;
                                  Get.toNamed(Routes.DASHBOARD, arguments: {
                                    "homeListTile": studentList,
                                  });
                                },
                                studentName:
                                    controller.parentChildList[index].fullName,
                                imageURL:
                                    controller.parentChildList[index].imageUrl,
                                // isMultipleSectionAvailable: true,
                                classSection:
                                    "${"Class".tr}: ${controller.parentChildList[index].className ?? "-"} | ${"Section".tr}: ${controller.parentChildList[index].section ?? "-"}",
                                //studentClass: controller.parentChildList[index].className,
                                classSectionList: const [],
                                textStyle: TextStyle(
                                    color: AppColors.profileValueColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          )
                        : const NoDataAvailableWidget(),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
