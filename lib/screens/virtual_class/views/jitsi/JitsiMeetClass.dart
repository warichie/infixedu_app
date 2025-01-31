// Dart imports:
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiMeetClass extends StatefulWidget {
  final String? meetingId;
  final String? meetingSubject;
  final String? userName;
  final String? userEmail;
  final String? jitsiServerUrl;

  JitsiMeetClass(
      {this.meetingId,
      this.meetingSubject,
      this.userEmail,
      this.userName,
      this.jitsiServerUrl});

  @override
  _JitsiMeetClassState createState() => _JitsiMeetClassState();
}

class _JitsiMeetClassState extends State<JitsiMeetClass> {
  final JitsiMeet jitsiMeet = JitsiMeet();
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  final nameText = TextEditingController();
  final emailText = TextEditingController();
  bool isAudioOnly = true;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();

    roomText.text = widget.meetingId ?? '';
    subjectText.text = widget.meetingSubject ?? '';
    nameText.text = widget.userName ?? '';
    emailText.text = widget.userEmail ?? '';
  }

  @override
  void dispose() {
    roomText.dispose();
    subjectText.dispose();
    nameText.dispose();
    emailText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.jitsiServerUrl);
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Join",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: meetConfig(context),
      ),
    );
  }

  Widget meetConfig(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 14.0),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
            title: Text("Audio Only"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          SizedBox(height: 14.0),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
            title: Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          SizedBox(height: 14.0),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
            title: Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          Divider(height: 48.0, thickness: 2.0),
          SizedBox(
            height: 45.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: _joinMeeting,
              child: Text("Watch now", style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
            ),
          ),
          SizedBox(height: 48.0),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value!;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

  _joinMeeting() async {
    var options = JitsiMeetConferenceOptions(
      serverURL: widget.jitsiServerUrl ?? "https://meet.jit.si",
      room: roomText.text,
      configOverrides: {
        "startWithAudioMuted": isAudioMuted,
        "startWithVideoMuted": isVideoMuted,
        "subject": subjectText.text,
      },
      userInfo: JitsiMeetUserInfo(
        displayName: nameText.text,
        email: emailText.text,
      ),
      featureFlags: {
        "unsafedialin.enabled": false,
        "security-options.enabled": false,
      },
    );

    try {
      await jitsiMeet.join(options);
    } catch (error) {
      debugPrint("Error joining meeting: $error");
    }
  }
}
