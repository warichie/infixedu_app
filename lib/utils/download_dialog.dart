// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:infixedu/utils/file_download_utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:infixedu/screens/student/studyMaterials/StudyMaterialViewer.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

class DownloadDialog extends StatefulWidget {
  const DownloadDialog({Key? key, this.file, this.title}) : super(key: key);

  final String? file;
  final String? title;

  @override
  _DownloadDialogState createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  var progress = "Download";
// ignore: prefer_typing_uninitialized_variables
  var received;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Download",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: const Text("Would you like to download the file?"),
      actions: [
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
        ),
        TextButton(
          child: const Text("Download"),
          onPressed: () {
            widget.file != null
                ? FileDownloadUtils().downloadFiles(
                    url: widget.file ?? "", title: widget.title ?? '')
                : Utils.showToast('no file found');
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
        ),
      ],
    );
  }
}
