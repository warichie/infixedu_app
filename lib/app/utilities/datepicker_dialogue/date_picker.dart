import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerUtils {
  Future<DateTime?> pickDate({
    int additionalYear = 50,
    bool canSelectPastDate = false,
    bool canSelectFutureDate = false,
  }) async {
    DateTime? dateTime = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: canSelectPastDate ? DateTime(DateTime.now().year - additionalYear) :DateTime.now(),
      lastDate:   canSelectFutureDate ? DateTime(DateTime.now().year + additionalYear) : DateTime.now(),
    );
    return dateTime;
  }
}
