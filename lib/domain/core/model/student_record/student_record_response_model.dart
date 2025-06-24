import 'dart:convert';

StudentRecordResponseModel studentRecordResponseModelFromJson(String str) => StudentRecordResponseModel.fromJson(json.decode(str));

String studentRecordResponseModelToJson(StudentRecordResponseModel data) => json.encode(data.toJson());

class StudentRecordResponseModel {
  bool success;
  Data data;
  String message;

  StudentRecordResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory StudentRecordResponseModel.fromJson(Map<String, dynamic> json) => StudentRecordResponseModel(
    success: json["success"],
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
  List<StudentRecord> studentRecords;

  Data({
    required this.studentRecords,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    studentRecords: List<StudentRecord>.from(json["studentRecords"].map((x) => StudentRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "studentRecords": List<dynamic>.from(studentRecords.map((x) => x.toJson())),
  };
}

class StudentRecord {
  int id;
  String studentRecordClass;
  String section;

  StudentRecord({
    required this.id,
    required this.studentRecordClass,
    required this.section,
  });

  factory StudentRecord.fromJson(Map<String, dynamic> json) => StudentRecord(
    id: json["id"],
    studentRecordClass: json["class"] ?? '',
    section: json["section"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class": studentRecordClass,
    "section": section,
  };
}
