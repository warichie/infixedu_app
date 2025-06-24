class TeacherHomeworkListResponseModel {
  bool? success;
  List<TeacherHomeworkData>? data;
  String? message;

  TeacherHomeworkListResponseModel({this.success, this.data, this.message});

  TeacherHomeworkListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherHomeworkData>[];
      json['data'].forEach((v) {
        data!.add(TeacherHomeworkData.fromJson(v));
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

class TeacherHomeworkData {
  int? id;
  String? subjectName;
  String? assignDate;
  String? submissionDate;
  String? evaluation;
  int? marks;
  String? file;
  String? className;
  String? sectionName;
  int? classId;
  int? sectionId;

  TeacherHomeworkData({
    this.id,
    this.subjectName,
    this.assignDate,
    this.submissionDate,
    this.evaluation,
    this.marks,
    this.file,
    this.classId,
    this.sectionId,
    this.className,
    this.sectionName,
  });

  TeacherHomeworkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    assignDate = json['assign_date'];
    submissionDate = json['submission_date'];
    evaluation = json['evaluation'].toString();
    marks = json['marks'];
    file = json['file'];
    classId = json['class_id'];
    className = json['class_name'];
    sectionId = json['section_id'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['assign_date'] = assignDate;
    data['submission_date'] = submissionDate;
    data['evaluation'] = evaluation;
    data['marks'] = marks;
    data['file'] = file;
    data['class_id'] = classId;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['section_id'] = sectionId;
    return data;
  }
}
