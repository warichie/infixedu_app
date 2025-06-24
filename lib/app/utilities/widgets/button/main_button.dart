import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';
import '../../style/main_button_style/main_button_style.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool loading;
  final Color backgroundColor;
  final double? borderRadius;
  final double? buttonHeight;

  const MainButton({
    required this.title,
    this.onTap,
    this.loading = false,
    this.backgroundColor = AppColors.primaryColor,
    this.borderRadius,
    super.key, this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loading ? null : onTap,
      style: mainButtonStyle(
        mainColor: backgroundColor,
        borderRadius: borderRadius ?? AppDimens.radius12,


      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppDimens.padding12),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: loading ? Colors.transparent : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
            ),
            Visibility(
              visible: loading,
              child: const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
