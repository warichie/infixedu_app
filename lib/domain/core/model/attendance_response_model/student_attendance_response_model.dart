class StudentAttendanceResponseModel {
  bool? success;
  Data? data;
  String? message;

  StudentAttendanceResponseModel({this.success, this.data, this.message});

  StudentAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Attendances>? attendances;
  String? currentDay;
  String? status;
  int? present;
  int? late;
  int? absent;
  int? holidayDay;
  int? halfDay;

  Data(
      {this.attendances,
        this.currentDay,
        this.status,
        this.present,
        this.late,
        this.absent,
        this.holidayDay,
        this.halfDay});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['attendances'] != null) {
      attendances = <Attendances>[];
      json['attendances'].forEach((v) {
        attendances!.add(Attendances.fromJson(v));
      });
    }
    currentDay = json['current_day'];
    status = json['status'];
    present = json['P'];
    late = json['L'];
    absent = json['A'];
    holidayDay = json['H'];
    halfDay = json['F'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attendances != null) {
      data['attendances'] = attendances!.map((v) => v.toJson()).toList();
    }
    data['current_day'] = currentDay;
    data['status'] = status;
    data['P'] = present;
    data['L'] = late;
    data['A'] = absent;
    data['H'] = holidayDay;
    data['F'] = halfDay;
    return data;
  }
}

class Attendances {
  String? attendanceType;
  DateTime? attendanceDate;

  Attendances({this.attendanceType, this.attendanceDate});

  Attendances.fromJson(Map<String, dynamic> json) {
    attendanceType = json['attendance_type'];
    attendanceDate = DateTime.tryParse(json['attendance_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance_type'] = attendanceType;
    data['attendance_date'] = attendanceDate;
    return data;
  }
}
