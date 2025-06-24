import 'package:flutter/material.dart';

import '../../data/constants/app_dimens.dart';

ShapeBorder defaultBottomSheetShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        AppDimens.radius8,
      ),
      topRight: Radius.circular(
        AppDimens.radius8,
      ),
    ),
  );
}