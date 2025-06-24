class AdminStudentSearchResponseModel {
  bool? success;
  List<StudentSearchData>? data;
  String? message;

  AdminStudentSearchResponseModel({this.success, this.data, this.message});

  AdminStudentSearchResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StudentSearchData>[];
      json['data'].forEach((v) {
        data!.add(StudentSearchData.fromJson(v));
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

class StudentSearchData {
  int? id;
  String? fullName;
  String? studentPhoto;
  List<ClassSection>? classSection;

  StudentSearchData({this.id, this.fullName, this.studentPhoto, this.classSection});

  StudentSearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    studentPhoto = json['student_photo'];
    if (json['class_section'] != null) {
      classSection = <ClassSection>[];
      json['class_section'].forEach((v) {
        classSection!.add(ClassSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['student_photo'] = studentPhoto;
    if (classSection != null) {
      data['class_section'] =
          classSection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassSection {
  String? classSection;

  ClassSection({this.classSection});

  ClassSection.fromJson(Map<String, dynamic> json) {
    classSection = json['class_section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_section'] = classSection;
    return data;
  }
}
