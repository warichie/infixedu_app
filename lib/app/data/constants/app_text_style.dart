import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class AppTextStyle {
  static TextStyle textStyle12WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 12),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle11WhiteW300 = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 11),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
  );

  static TextStyle textStyle10WhiteW400 = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 10),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle10WhiteW300 = TextStyle(
    color: Colors.white,
    fontSize:setTextSize(size:  10),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
  );

  static TextStyle textStyle16WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 16),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyle7WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 7),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static TextStyle cardTextStyle14PurpleW500 = TextStyle(
    color: AppColors.primaryColor,
    fontSize: setTextSize(size: 11),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle cardTextStyle14WhiteW500 = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 11),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle appBarTitleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 15),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  /// Profile
  static TextStyle fontSize14LightPinkW400 = TextStyle(
      color: AppColors.profileCardTextColor,
      fontSize: setTextSize(size: 14),
      fontWeight: FontWeight.w400);

  static TextStyle fontSize12LightPinkW400 = TextStyle(
      color: AppColors.profileCardTextColor,
      fontSize: setTextSize(size: 12),
      fontWeight: FontWeight.w400);

  static TextStyle fontSize18WhiteW700 =
      TextStyle(color: Colors.white, fontSize: setTextSize(size: 18), fontWeight: FontWeight.w700);

  /// Syllabus
  static TextStyle fontSize14BlackW500 = TextStyle(
    color: AppColors.syllabusTextColorBlack,
    fontSize: setTextSize(size: 14),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static TextStyle fontSize14BlackW400 = TextStyle(
    color: AppColors.syllabusTextColor635976,
    fontSize: setTextSize(size: 14),
    fontWeight: FontWeight.w400,
  );

  static TextStyle fontSize13BlackW400 = TextStyle(
      color: AppColors.syllabusTextColorBlack,
      fontSize: setTextSize(size: 13),
      fontWeight: FontWeight.w400);

  static TextStyle fontSize11BlackW400 = TextStyle(
      color: AppColors.syllabusTextColorBlack,
      fontSize:setTextSize(size:  11),
      fontWeight: FontWeight.w400);

  static TextStyle fontSize13BlackW500 = TextStyle(
    color: AppColors.syllabusTextColorBlack,
    fontSize: setTextSize(size: 13),
    fontWeight: FontWeight.w500,
  );

  static TextStyle blackFontSize14W400 =
      TextStyle(color: Colors.black, fontSize: setTextSize(size: 14), fontWeight: FontWeight.w400);

  static TextStyle syllabusFontSize16W500 = TextStyle(
      color: AppColors.syllabusTextColorBlack,
      fontSize: setTextSize(size: 16),
      fontWeight: FontWeight.w500);

  static TextStyle notificationText = TextStyle(
      color: AppColors.syllabusTextColorBlack,
      fontSize: setTextSize(size: 10),
      fontWeight: FontWeight.w400);

  static TextStyle labelText = TextStyle(
      color: AppColors.editProfileTextFieldLabelColor,
      fontSize: setTextSize(size: 12),
      fontWeight: FontWeight.w400);

  static TextStyle homeworkTitle = TextStyle(
      color: AppColors.editProfileTextFieldLabelColor,
      fontSize:setTextSize(size:  11),
      fontWeight: FontWeight.w300);

  ///Homework
  static TextStyle homeworkSubject = TextStyle(
      color: AppColors.homeworkSubjectColor,
      fontSize: setTextSize(size: 14),
      fontWeight: FontWeight.w500);

  static TextStyle homeworkElements = TextStyle(
      color: AppColors.editProfileTextFieldLabelColor,
      fontSize: setTextSize(size: 11),
      fontWeight: FontWeight.w400);

  static TextStyle homeworkView = TextStyle(
      color: AppColors.homeworkViewColor,
      fontSize: setTextSize(size: 14),
      // decoration: TextDecoration.underline,
      fontWeight: FontWeight.w500);

  static TextStyle fontSize14VioletW600 = TextStyle(
    color: AppColors.parentsIconCardBackgroundColor,
    fontSize: setTextSize(size: 14),
    fontWeight: FontWeight.w600,
  );

  static TextStyle fontSize12GreyW400 = TextStyle(
    color: AppColors.profileTitleColor,
    fontSize: setTextSize(size: 12),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle fontSize10Color8489ABW400 = TextStyle(
    color: Color(0xFF8489AB),
    fontSize: setTextSize(size: 10),
    fontWeight: FontWeight.w400,
  );

  static TextStyle fontSize10GreyW400 = TextStyle(
    color: AppColors.profileTitleColor,
    fontSize: setTextSize(size: 10),
    fontWeight: FontWeight.w400,
  );
  static TextStyle fontSize10GreyW500 = TextStyle(
    color: AppColors.profileValueColor,
    fontSize: setTextSize(size: 10),
    fontWeight: FontWeight.w500,
  );

  static TextStyle fontSize12GreyW600 = TextStyle(
    color: Color(0xFF412C56),
    fontSize: setTextSize(size: 12),
    fontWeight: FontWeight.w500,
  );

  static TextStyle fontSize10W500 = TextStyle(
      color: Color(0xFF7E7987), fontSize: setTextSize(size: 10), fontWeight: FontWeight.w500);

  static TextStyle fontSize12lightViolateW400 = TextStyle(
    color: AppColors.profileValueColor,
    fontSize: setTextSize(size: 12),
    fontWeight: FontWeight.w400,
  );

  static TextStyle fontSize14lightBlackW400 = TextStyle(
      color: AppColors.profileValueColor,
      fontSize:setTextSize(size:  14),
      fontWeight: FontWeight.w400);

  static TextStyle dropdownText = TextStyle(
    color: Color(0xFF6B7280),
    fontSize: setTextSize(size: 12),
    fontWeight: FontWeight.w400,
  );

  static TextStyle fontSize16lightBlackW500 = TextStyle(
    color: AppColors.profileValueColor,
    fontSize: setTextSize(size: 16),
    fontWeight: FontWeight.w500,
  );

  static TextStyle cardTextStyle12PurpleW400 = TextStyle(
    color: AppColors.primaryColor,
    fontSize: setTextSize(size: 12),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
  static TextStyle fontSize14GreyW400 = TextStyle(
      color: AppColors.profileTitleColor,
      fontSize: setTextSize(size: 14),
      fontWeight: FontWeight.w400);
  static TextStyle fontSize12LightViolateW500 = TextStyle(
      color: AppColors.homeworkViewColor,
      fontSize: setTextSize(size: 12),
      // decoration: TextDecoration.underline,
      fontWeight: FontWeight.w500);

  static TextStyle fontSize12LightGreyW500 = TextStyle(
      color: AppColors.loginIconColor,
      fontSize: setTextSize(size: 12),
      // decoration: TextDecoration.underline,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300);

  static TextStyle fontSize13GreyW500 = TextStyle(
      color: AppColors.teacherTextColor,
      fontSize: setTextSize(size: 13),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500);
  static TextStyle fontSize13GreyW300 = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize:setTextSize(size:  13),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300);
  static TextStyle blackFontSize12W400 = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize: setTextSize(size: 12),
      fontWeight: FontWeight.w400);
  static TextStyle bottomSheetTitleColor = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize: setTextSize(size: 13),
      fontWeight: FontWeight.w700);
  static TextStyle teacherColor = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize: setTextSize(size: 13),
      fontWeight: FontWeight.w500);
  static TextStyle blackFontSize12W300 = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize: setTextSize(size: 12),
      fontWeight: FontWeight.w300);
  static TextStyle customTextFieldTextStyle = TextStyle(
    color: AppColors.teacherTextColor,
    fontSize: setTextSize(size: 12),
    fontWeight: FontWeight.w400,
  );
  static TextStyle blackFontSize10W400 = TextStyle(
      color: AppColors.syllabusTextColor635976,
      fontSize: setTextSize(size: 10),
      fontWeight: FontWeight.w400);
  static TextStyle textStyle12WhiteW400 = TextStyle(
    color: Colors.white,
    fontSize: setTextSize(size: 12),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static final chatTextStyle12WhiteW400 = TextStyle(
    color: Colors.white.withOpacity(0.7),
    fontSize: setTextSize(size: 12),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle chatTextStyle14ColorC81E1EW400 = TextStyle(
    color: Color(0xFFC81E1E),
    fontSize: setTextSize(size: 14),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle chatTextStyle16ColorC81E1EW600 = TextStyle(
    color: Color(0xFFC81E1E),
    fontSize: setTextSize(size: 16),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  static TextStyle fontSize10GreenW700 = TextStyle(
    color: Color(0xFF03B53E),
    fontSize: setTextSize(size: 10),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static TextStyle fontSize12W400ReceivedText = TextStyle(
    color: AppColors.teacherTextColor,
    fontSize: setTextSize(size: 12),
    fontWeight: FontWeight.w400,
  );
  static TextStyle primaryFont14 = TextStyle(
      color: AppColors.primaryColor, fontSize: setTextSize(size: 14), fontWeight: FontWeight.w500);

  static TextStyle inter(
      {Color? color,
      double fontSize = 16,
      FontWeight? fontWeight,
      double? height,
      TextDecoration? decoration,
      double? decorationThickness,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle}) {
    return TextStyle(
      fontFamily: "Inter",
      fontSize: setTextSize(size: fontSize),
      fontWeight: fontWeight,
      height: height,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      // optional
      decorationThickness: decorationThickness,
      // optional
      decorationStyle: decorationStyle,
    );
  }

  /// Add Payment
  static TextStyle fontSize13WhiteWight700 = TextStyle(
    fontSize: setTextSize(size: 13),
    color: Colors.white,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  static TextStyle fontSize13BlackWight700 = TextStyle(
    fontSize: setTextSize(size: 13),
    color: AppColors.hintTextColor,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  static TextStyle fontSize13WhiteWight500 = TextStyle(
    fontSize: setTextSize(size: 13),
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static TextStyle fontSize14Color862CFFWight600 = TextStyle(
    fontSize: setTextSize(size: 14),
    fontFamily: 'Popins',
    color: Color(0xFF862CFF),
    fontWeight: FontWeight.w600,
  );

  static TextStyle fontSize14Color635976Wight400 = TextStyle(
    fontSize: setTextSize(size: 14),
    fontFamily: 'Popins',
    color: Color(0xFF635976),
    fontWeight: FontWeight.w400,
  );

  static TextStyle fontSize12WhiteWight500 = TextStyle(
    fontSize: setTextSize(size: 12),
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static TextStyle hintTextStyle = TextStyle(
      color: AppColors.hintTextColor,
      fontSize: setTextSize(size: 12),
      fontWeight: FontWeight.w400);
  static TextStyle roomListColumnTitleTextStyle = TextStyle(
      color: AppColors.editProfileTextFieldLabelColor,
      fontSize: setTextSize(size: 11),
      fontWeight: FontWeight.bold);

  static final TextStyle roomListColumnSubTitleTextStyle = TextStyle(
      color: Colors.grey, fontSize: setTextSize(size:11), fontWeight: FontWeight.w300);
}

double setTextSize({required double size}){

  if(ScreenUtil().deviceType(Get.context!) == DeviceType.mobile){
    return (size+2).sp;
  }
  return (size).sp;
}
