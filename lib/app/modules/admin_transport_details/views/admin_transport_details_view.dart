import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/admin_transport_details/views/widget/transport_details_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_transport_details_controller.dart';

class AdminTransportDetailsView
    extends GetView<AdminTransportDetailsController> {
  const AdminTransportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Transport Details".tr,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getAdminTransportList();
        },
        color: AppColors.primaryColor,
        child: CustomBackground(
          customWidget: Column(
            children: [
              Obx(
                () => Expanded(
                  child: controller.loadingController.isLoading
                      ? const LoadingWidget()
                      : controller.adminTransportList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.adminTransportList.length,
                              itemBuilder: (context, index) {
                                return TransportDetailsTile(
                                  route: controller
                                      .adminTransportList[index].routeName,
                                  vehicleNo: controller
                                      .adminTransportList[index].vehicleNo,
                                  onTap: () =>
                                      controller.showBookListDetailsBottomSheet(
                                          index: index,
                                          bottomSheetBackgroundColor:
                                              Colors.white),
                                );
                              },
                            )
                          : const NoDataAvailableWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
