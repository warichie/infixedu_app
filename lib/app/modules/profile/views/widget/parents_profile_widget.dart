import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/profile/views/widget/parents_info.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import 'guardian_info.dart';

class ProfileParentsWidget extends StatelessWidget {
  const ProfileParentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ParentsInfo(
            designation: AppText.profileFather.tr,
            icon: ImagePath.parentsProfile,
            name: 'Md. Rofiku islam',
            phone: '+8845215555',
            occupation: 'Farmer'),
        20.verticalSpacing,
        ParentsInfo(
            designation: AppText.profileMother.tr,
            icon: ImagePath.parentsProfile,
            name: 'Mst. Fatema Khatun',
            phone: '+8845215555',
            occupation: 'Housewife'),
        20.verticalSpacing,
        GuardianInfo(
          designation: AppText.profileGuardian.tr,
          icon: ImagePath.parentsProfile,
          name: 'Salam molla',
          email: 'salam@gmail.com',
          phone: '0464794664',
          occupation: 'Farmer',
          relation: 'Brother',
          other: 'Other',
        )
      ],
    );
  }
}
