import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/widgets/popup_item_tile/popup_item_tile.dart';
import 'package:get/get.dart';

class FeesPopupMenu extends StatelessWidget {
  final Function(int)? onTap;
  const FeesPopupMenu({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      color: Colors.white,
      iconColor: Colors.white,
      onSelected: onTap,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          height: 40.h,
          child: PopupItemTile(title: "View Invoice".tr),
        ),
        PopupMenuItem(
          value: 2,
          height: 40.h,
          child: PopupItemTile(title: "Add Payment".tr),
        ),
      ],
    );
  }
}
