class AdminStaffRoleWiseListResponseModel {
  bool? success;
  List<RoleWiseStaffListData>? data;
  String? message;

  AdminStaffRoleWiseListResponseModel({this.success, this.data, this.message});

  AdminStaffRoleWiseListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RoleWiseStaffListData>[];
      json['data'].forEach((v) {
        data!.add(RoleWiseStaffListData.fromJson(v));
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

class RoleWiseStaffListData {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? currentAddress;
  String? permanentAddress;
  String? staffPhoto;

  RoleWiseStaffListData(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobile,
        this.currentAddress,
        this.permanentAddress,
        this.staffPhoto});

  RoleWiseStaffListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    staffPhoto = json['staff_photo'];
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
    return data;
  }
}
