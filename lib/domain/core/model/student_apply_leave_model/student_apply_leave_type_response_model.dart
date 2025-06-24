class StudentApplyLeaveTypeResponseModel {
  bool? success;
  ApplyLeaveTypeData? data;
  String? message;

  StudentApplyLeaveTypeResponseModel({this.success, this.data, this.message});

  StudentApplyLeaveTypeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ApplyLeaveTypeData.fromJson(json['data']) : null;
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

class ApplyLeaveTypeData {
  List<LeaveType>? leaveType;

  ApplyLeaveTypeData({this.leaveType});

  ApplyLeaveTypeData.fromJson(Map<String, dynamic> json) {
    if (json['leave_type'] != null) {
      leaveType = <LeaveType>[];
      json['leave_type'].forEach((v) {
        leaveType!.add(LeaveType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaveType != null) {
      data['leave_type'] = leaveType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveType {
  int? id;
  String? name;  ///  leave_type => name

  LeaveType({this.id, this.name});

  LeaveType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['leave_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_type'] = name;
    return data;
  }
}
