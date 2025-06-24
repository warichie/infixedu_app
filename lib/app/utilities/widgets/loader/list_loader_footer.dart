import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';

class ListLoaderFooter extends StatelessWidget {
  final bool loading;
  final bool noMoreItem;
  final String noItemMessage;

  const ListLoaderFooter({
    required this.loading,
    required this.noMoreItem,
    this.noItemMessage = 'No item left!',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.primaryRadius * 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (loading == true)
            SizedBox(
              height: AppDimens.primaryRadius * 2,
              width: AppDimens.primaryRadius * 2,
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(
                      color: AppColors.primaryColor,
                      radius: 10,
                    )
                  : const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryColor,
                    ),
            ),
          if (noMoreItem == true)
            SizedBox(
              height: AppDimens.primaryRadius * 2,
              child: Center(
                child: Text(
                  noItemMessage,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          if (noMoreItem == loading) const SizedBox()
        ],
      ),
    );
  }
}
