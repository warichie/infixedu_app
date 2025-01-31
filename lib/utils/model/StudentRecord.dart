// To parse this JSON data, do
//
//     final studentRecords = studentRecordsFromJson(jsonString);

import 'dart:convert';

import 'package:infixedu/utils/value_checker/value_checker.dart';

StudentRecords studentRecordsFromJson(String str) =>
    StudentRecords.fromJson(json.decode(str));

String studentRecordsToJson(StudentRecords data) => json.encode(data.toJson());

class StudentRecords {
  StudentRecords({
    this.records,
  });

  List<Record>? records;

  factory StudentRecords.fromJson(Map<String, dynamic> json) => StudentRecords(
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "records": List<dynamic>.from(records?.map((x) => x.toJson()) ?? []),
      };
}

class Record {
  Record({
    this.id,
    this.studentId,
    this.fullName,
    this.className,
    this.sectionName,
    this.classId,
    this.sectionId,
    this.isDefault,
    this.isPromote,
    this.rollNo,
    this.sessionId,
    this.academicId,
    this.schoolId,
  });

  int? id;
  int? studentId;
  String? fullName;
  String? className;
  String? sectionName;
  int? classId;
  int? sectionId;
  int? isDefault;
  int? isPromote;
  String? rollNo;
  int? sessionId;
  int? academicId;
  int? schoolId;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: ValueChecker.checkInt(json["id"]),
        studentId: ValueChecker.checkInt(json["student_id"]),
        fullName: json["full_name"],
        className: json["class"],
        sectionName: json["section"],
        classId: ValueChecker.checkInt(json["class_id"]),
        sectionId: ValueChecker.checkInt(json["section_id"]),
        isDefault: ValueChecker.checkInt(json["is_default"]),
        isPromote: ValueChecker.checkInt(json["is_promote"]),
        rollNo: json["roll_no"].toString(),
        sessionId: ValueChecker.checkInt(json["session_id"]),
        academicId: ValueChecker.checkInt(json["academic_id"]),
        schoolId: ValueChecker.checkInt(json["school_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "full_name": fullName,
        "class": className,
        "section": sectionName,
        "class_id": classId,
        "section_id": sectionId,
        "is_default": isDefault,
        "is_promote": isPromote,
        "roll_no": rollNo,
        "session_id": sessionId,
        "academic_id": academicId,
        "school_id": schoolId,
      };
}
