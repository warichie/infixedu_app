class AdminSubSearchAttendanceResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminSubSearchAttendanceResponseModel(
      {this.success, this.data, this.message});

  AdminSubSearchAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? className;
  String? sectionName;
  String? subjectName;
  int? subjectId;
  int? classId;
  int? sectionId;
  bool? holiday;
  String? date;
  String? submittedMessage;
  List<AdminStudentsSubSearchData>? students;

  Data(
      {this.className,
      this.sectionName,
      this.subjectName,
      this.subjectId,
      this.classId,
      this.sectionId,
      this.date,
      this.students,
      this.submittedMessage});

  Data.fromJson(Map<String, dynamic> json) {
    submittedMessage = json['submitted_message'];
    className = json['class_name'];
    sectionName = json['section_name'];
    subjectName = json['subject_name'];
    subjectId = json['subject_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    holiday = json['holiday'];
    date = json['date'];
    if (json['students'] != null) {
      students = <AdminStudentsSubSearchData>[];
      json['students'].forEach((v) {
        students!.add(AdminStudentsSubSearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['submitted_messsage'] = submittedMessage;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['subject_name'] = subjectName;
    data['subject_id'] = subjectId;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['holiday'] = holiday;
    data['date'] = date;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdminStudentsSubSearchData {
  int? studentId;
  int? recordId;
  String? fullName;
  String? note;
  String? attendanceType;
  String? studentPhoto;
  String? className;
  String? section;

  AdminStudentsSubSearchData(
      {this.studentId,
      this.recordId,
      this.fullName,
      this.attendanceType,
      this.studentPhoto,
      this.className,
      this.section});

  AdminStudentsSubSearchData.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    recordId = json['record_id'];
    fullName = json['full_name'];
    note = json['note'];
    attendanceType = json['attendance_type'];
    studentPhoto = json['student_photo'];
    className = json['class'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['record_id'] = recordId;
    data['full_name'] = fullName;
    data['note'] = note;
    data['attendance_type'] = attendanceType;
    data['student_photo'] = studentPhoto;
    data['class'] = className;
    data['section'] = section;
    return data;
  }
}
