
import 'dart:convert';

StudentRoutineResponseModel studentRoutineResponseModelFromJson(String str) => StudentRoutineResponseModel.fromJson(json.decode(str));

String studentRoutineResponseModelToJson(StudentRoutineResponseModel data) => json.encode(data.toJson());

class StudentRoutineResponseModel {
  bool success;
  Data data;
  String message;

  StudentRoutineResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory StudentRoutineResponseModel.fromJson(Map<String, dynamic> json) => StudentRoutineResponseModel(
    success: json["success"]??false,
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  List<ClassRoutine> classRoutines;

  Data({
    required this.classRoutines,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    classRoutines: List<ClassRoutine>.from(json["class_routines"].map((x) => ClassRoutine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "class_routines": List<dynamic>.from(classRoutines.map((x) => x.toJson())),
  };
}

class ClassRoutine {
  int? id;
  String? day;
  String? room;
  String? subject;
  String? teacher;
  String? classRoutineClass;
  String? section;
  String? startTime;
  String? endTime;
  String? classRoutineBreak;

  ClassRoutine({
    this.id,
    this.day,
    this.room,
    this.subject,
    this.teacher,
    this.classRoutineClass,
    this.section,
    this.startTime,
    this.endTime,
    this.classRoutineBreak,
  });

  factory ClassRoutine.fromJson(Map<String, dynamic> json) => ClassRoutine(
    id: json["id"],
    day: json["day"],
    room: json["room"],
    subject: json["subject"],
    teacher: json["teacher"],
    classRoutineClass: json["class"],
    section: json["section"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    classRoutineBreak: json["break"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "room": room,
    "subject": subject,
    "teacher": teacher,
    "class": classRoutineClass,
    "section": section,
    "start_time": startTime,
    "end_time": endTime,
    "break": classRoutineBreak,
  };
}
