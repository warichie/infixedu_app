class AdminIndividualStaffDetailsResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminIndividualStaffDetailsResponseModel(
      {this.success, this.data, this.message});

  AdminIndividualStaffDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? currentAddress;
  String? permanentAddress;
  String? staffPhoto;
  String? qualification;
  String? maritalStatus;
  String? dateOfJoining;
  String? designation;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobile,
        this.currentAddress,
        this.permanentAddress,
        this.staffPhoto,
        this.qualification,
        this.maritalStatus,
        this.dateOfJoining,
        this.designation});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    staffPhoto = json['staff_photo'];
    qualification = json['qualification'];
    maritalStatus = json['marital_status'];
    dateOfJoining = json['date_of_joining'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['current_address'] = currentAddress;
    data['permanent_address'] = permanentAddress;
    data['staff_photo'] = staffPhoto;
    data['qualification'] = qualification;
    data['marital_status'] = maritalStatus;
    data['date_of_joining'] = dateOfJoining;
    data['designation'] = designation;
    return data;
  }
}
