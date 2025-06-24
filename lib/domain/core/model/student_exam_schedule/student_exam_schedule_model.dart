class StudentExamScheduleResponseModel {
  bool? success;
  List<ScheduleData>? data;
  String? message;

  StudentExamScheduleResponseModel({this.success, this.data, this.message});

  StudentExamScheduleResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ScheduleData>[];
      json['data'].forEach((v) {
        data!.add(ScheduleData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ScheduleData {
  int? id;
  String? dateAndDay;
  String? subject;
  String? classSection;
  String? teacher;
  String? startTime;
  String? endTime;
  String? duration;
  String? room;

  ScheduleData(
      {this.id,
        this.dateAndDay,
        this.subject,
        this.classSection,
        this.teacher,
        this.startTime,
        this.duration,
        this.room});

  ScheduleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateAndDay = json['date_and_day'];
    subject = json['subject'];
    classSection = json['subject_class_section'];
    teacher = json['teacher'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_and_day'] = dateAndDay;
    data['subject'] = subject;
    data['class_section'] = classSection;
    data['teacher'] = teacher;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['room'] = room;
    return data;
  }
}
