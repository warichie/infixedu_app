// Dart imports:
import 'dart:io';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/file_download_utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:infixedu/screens/student/studyMaterials/StudyMaterialViewer.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/model/Content.dart';
import 'package:infixedu/utils/permission_check.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

// ignore: must_be_immutable
class ContentRow extends StatefulWidget {
  Content content;
  Animation animation;
  final VoidCallback? onPressed;
  String? token;
  dynamic index;

  ContentRow(this.content, this.animation,
      {Key? key, this.onPressed, this.token, this.index})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ContentRowState createState() => _ContentRowState(token);
}

class _ContentRowState extends State<ContentRow> {
  var progress = "Download";
  // ignore: prefer_typing_uninitialized_variables
  var received;
  // ignore: prefer_typing_uninitialized_variables
  final _token;

  _ContentRowState(this._token);

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      // sizeFactor: widget.animation,
      sizeFactor: widget.animation as Animation<double>,

      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 20.0, right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      widget.content.contentTitle ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        widget.content.description ?? "N/A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize:
                                                    ScreenUtil().setSp(12)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.content.contentTitle ?? 'NA',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: ScreenUtil().setSp(12)),
                      maxLines: 1,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        PermissionCheck().checkPermissions(context);
                        showDownloadAlertDialog(
                            context, widget.content.contentTitle);
                      },
                      child: widget.content.uploadFile!.isNotEmpty
                          ? Icon(
                              FontAwesomeIcons.download,
                              size: ScreenUtil().setSp(15),
                              color: Colors.deepPurpleAccent,
                            )
                          : Container()),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDeleteAlertDialog(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.trash,
                      size: ScreenUtil().setSp(15),
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Type',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.content.contentType ?? "N/A",
                            // : AppFunction.getContentType(content.type),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Date',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.content.uploadDate ?? 'N/A',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Available for',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.content.availableFor ?? '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.5,
                margin: const EdgeInsets.only(top: 10.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Colors.purple, Colors.deepPurple]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDeleteAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget yesButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        setState(() {
          deleteContent(widget.content.id);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: const Text("Would you like to delete the file?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDownloadAlertDialog(BuildContext context, title) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget yesButton = TextButton(
      child: const Text("Download"),
      onPressed: () {
        widget.content.uploadFile != null
            ? FileDownloadUtils().downloadFiles(
                url: widget.content.uploadFile ?? '', title: title)
            : Utils.showToast('no file found');
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Download",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: const Text("Would you like to download the file?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> deleteContent(dynamic cid) async {
    final response = await http.get(Uri.parse(InfixApi.deleteContent(cid)),
        headers: Utils.setHeader(_token));

    if (response.statusCode == 200) {
      widget.onPressed!();
      Utils.showToast('Content deleted');
    } else {
      throw Exception('failed to load');
    }
  }

  getContentType(String contentType) {
    if (contentType == "as") {
      return "Assignment";
    } else if (contentType == "st") {
      return "Study Material";
    } else if (contentType == "sy") {
      return "Syllabus";
    } else if (contentType == "ot") {
      return "Other Download";
    }
  }
}
