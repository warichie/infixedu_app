import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';

class RecentSearchTile extends StatelessWidget {
  final String? profileImage;
  final String? name;
  final Function()? onTap;

  const RecentSearchTile({
    super.key,
    this.profileImage,
    this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(profileImage ?? ""),
          ),
          10.verticalSpacing,
          SizedBox(
            width: 70,
            child: Text(
              name ?? "",
              style: AppTextStyle.textStyle12WhiteW500,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
