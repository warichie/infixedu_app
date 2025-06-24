// AttendanceStudentData
// StudentsListData

class AdminStudentSearchAttendanceResponseModel {
  bool? success;
  AttendanceStudentData? data;
  String? message;

  AdminStudentSearchAttendanceResponseModel(
      {this.success, this.data, this.message});

  AdminStudentSearchAttendanceResponseModel.fromJson(
      Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? AttendanceStudentData.fromJson(json['data'])
        : null;
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

class AttendanceStudentData {
  String? submittedMessage;
  String? className;
  String? sectionName;
  String? date;
  int? classId;
  int? sectionId;
  bool? holiday;
  List<StudentsListData>? students;
  String? status;

  AttendanceStudentData(
      {this.className,
      this.sectionName,
      this.date,
      this.students,
      this.status,
      this.classId,
      this.sectionId,
      this.holiday,
      this.submittedMessage});

  AttendanceStudentData.fromJson(Map<String, dynamic> json) {
    submittedMessage = json["submitted_message"];
    className = json['class_name'];
    sectionName = json['section_name'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    holiday = json['holiday'];
    date = json['date'];
    if (json['students'] != null) {
      students = <StudentsListData>[];
      json['students'].forEach((v) {
        students!.add(StudentsListData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['submitted_message'] = submittedMessage;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['holiday'] = holiday;
    data['date'] = date;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class StudentsListData {
  int? studentId;
  int? recordId;
  String? fullName;
  String? note;
  String? attendanceType;
  String? studentPhoto;
  String? className;
  String? section;

  StudentsListData(
      {this.studentId,
      this.recordId,
      this.fullName,
      this.note,
      this.attendanceType,
      this.studentPhoto,
      this.className,
      this.section});

  StudentsListData.fromJson(Map<String, dynamic> json) {
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
