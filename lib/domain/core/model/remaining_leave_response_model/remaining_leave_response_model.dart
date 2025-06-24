class RemainingLeaveResponseModel {
  bool? success;
  List<RemainingLeaveListData>? data;
  String? message;

  RemainingLeaveResponseModel({this.success, this.data, this.message});

  RemainingLeaveResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RemainingLeaveListData>[];
      json['data'].forEach((v) {
        data!.add(RemainingLeaveListData.fromJson(v));
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

class RemainingLeaveListData {
  int? id;
  String? leaveType;
  int? remainingDays;

  RemainingLeaveListData({this.id, this.leaveType, this.remainingDays});

  RemainingLeaveListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
    remainingDays = json['remaining_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_type'] = leaveType;
    data['remaining_days'] = remainingDays;
    return data;
  }
}
