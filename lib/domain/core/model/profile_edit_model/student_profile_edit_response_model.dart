class StudentProfileEditResponseModel {
  bool? success;
  Data? data;
  String? message;

  StudentProfileEditResponseModel({this.success, this.data, this.message});

  StudentProfileEditResponseModel.fromJson(Map<String, dynamic> json) {
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
  ProfilePersonal? profilePersonal;

  Data({this.profilePersonal});

  Data.fromJson(Map<String, dynamic> json) {
    profilePersonal = json['profilePersonal'] != null
        ? ProfilePersonal.fromJson(json['profilePersonal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profilePersonal != null) {
      data['profilePersonal'] = profilePersonal!.toJson();
    }
    return data;
  }
}

class ProfilePersonal {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? currentAddress;
  String? studentPhoto;
  String? mobile;

  ProfilePersonal(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.dateOfBirth,
        this.currentAddress,
        this.studentPhoto,
        this.mobile});

  ProfilePersonal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    email = json['email'] ?? '';
    dateOfBirth = json['date_of_birth'] ?? '';
    currentAddress = json['current_address'] ?? '';
    studentPhoto = json['student_photo'] ?? '';
    mobile = json['mobile'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['current_address'] = currentAddress;
    data['student_photo'] = studentPhoto;
    data['mobile'] = mobile;
    return data;
  }
}
