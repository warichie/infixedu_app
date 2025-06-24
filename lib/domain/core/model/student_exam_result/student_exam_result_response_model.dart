class StudentExamResultResponseModel {
  bool? success;
  Data? data;
  String? message;

  StudentExamResultResponseModel({this.success, this.data, this.message});

  StudentExamResultResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<ExamResult>? examResult;

  Data({this.examResult});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['exam_result'] != null) {
      examResult = <ExamResult>[];
      json['exam_result'].forEach((v) {
        examResult!.add(ExamResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examResult != null) {
      data['exam_result'] = examResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamResult {
  int? id;
  String? examName;
  String? subjectName;
  int? obtainedMarks;
  int? totalMarks;
  String? grade;

  ExamResult(
      {this.id,
        this.examName,
        this.subjectName,
        this.obtainedMarks,
        this.totalMarks,
        this.grade});

  ExamResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examName = json['exam_name'];
    subjectName = json['subject_name'];
    obtainedMarks = json['obtained_marks'];
    totalMarks = json['total_marks'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exam_name'] = examName;
    data['subject_name'] = subjectName;
    data['obtained_marks'] = obtainedMarks;
    data['total_marks'] = totalMarks;
    data['grade'] = grade;
    return data;
  }
}
