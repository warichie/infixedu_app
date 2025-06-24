import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String schoolName;
  final bool? centerTitle;
  final Function() messengerOnTap;
  final Function() logoutOnTap;

  const CustomAppBar({
    super.key,
    required this.schoolName,
    this.centerTitle,
    required this.messengerOnTap,
    required this.logoutOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ?? false,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    10.verticalSpacing,
                    Flexible(
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        height: 30,
                      ),
                    ),
                    10.verticalSpacing,
                    Text(
                      "Welcome $schoolName",
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white, fontSize: 15),
                    ),
                    20.verticalSpacing,
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: messengerOnTap,
              icon: const Icon(
                Iconsax.messages,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: logoutOnTap,
              icon: const Icon(
                Icons.exit_to_app,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
