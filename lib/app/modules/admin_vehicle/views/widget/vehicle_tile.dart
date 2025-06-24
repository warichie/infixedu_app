import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:get/get.dart';

class VehicleTile extends StatelessWidget {
  final String? model;
  final String? madeYear;
  final String? number;
  final String? note;
  final Color? color;

  const VehicleTile({
    super.key,
    this.model,
    this.madeYear,
    this.number,
    this.note,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 10),
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnTile(
                title: "Model".tr,
                value: model,
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "Number".tr,
                value: number,
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "Made Year".tr,
                value: madeYear ?? '',
                width: Get.width * 0.2,
              ),
              ColumnTile(
                title: "Note".tr,
                value: note,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
