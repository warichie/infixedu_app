class TeClassRoutineListResponseModel {
  bool? success;
  Data? data;
  String? message;

  TeClassRoutineListResponseModel({this.success, this.data, this.message});

  TeClassRoutineListResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<TeacherClassRoutines>? classRoutines;

  Data({this.classRoutines});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['class_routines'] != null) {
      classRoutines = <TeacherClassRoutines>[];
      json['class_routines'].forEach((v) { classRoutines!.add(TeacherClassRoutines.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (classRoutines != null) {
      data['class_routines'] = classRoutines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherClassRoutines {
  int? id;
  String? day;
  String? room;
  String? subject;
  String? teacher;
  String? className;
  String? section;
  String? startTime;
  String? endTime;
  String? breakTime;

  TeacherClassRoutines({this.id, this.day, this.room, this.subject, this.teacher, this.className, this.section, this.startTime, this.endTime, this.breakTime,});

TeacherClassRoutines.fromJson(Map<String, dynamic> json) {
id = json['id'];
day = json['day'];
room = json['room'];
subject = json['subject'];
teacher = json['teacher'];
className = json['class'];
section = json['section'];
startTime = json['start_time'];
endTime = json['end_time'];
breakTime = json['break'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['id'] = id;
data['day'] = day;
data['room'] = room;
data['subject'] = subject;
data['teacher'] = teacher;
data['class'] = className;
data['section'] = section;
data['start_time'] = startTime;
data['end_time'] = endTime;
data['break'] = breakTime;
return data;
}
}
