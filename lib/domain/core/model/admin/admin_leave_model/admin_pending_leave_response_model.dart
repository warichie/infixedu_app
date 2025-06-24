class AdminPendingLeaveResponseModel {
  bool? success;
  List<PendingLeaveData>? data;
  String? message;

  AdminPendingLeaveResponseModel({this.success, this.data, this.message});

  AdminPendingLeaveResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PendingLeaveData>[];
      json['data'].forEach((v) {
        data!.add(PendingLeaveData.fromJson(v));
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

class PendingLeaveData {
  int? id;
  String? fullName;
  String? applyDate;
  String? leaveFrom;
  String? leaveTo;
  String? reason;
  String? file;
  String? type;
  String? approveStatus;

  PendingLeaveData(
      {this.id,
        this.fullName,
        this.applyDate,
        this.leaveFrom,
        this.leaveTo,
        this.reason,
        this.file,
        this.type,
        this.approveStatus});

  PendingLeaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    applyDate = json['apply_date'];
    leaveFrom = json['leave_from'];
    leaveTo = json['leave_to'];
    reason = json['reason'];
    file = json['file'];
    type = json['type'];
    approveStatus = json['approve_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['apply_date'] = applyDate;
    data['leave_from'] = leaveFrom;
    data['leave_to'] = leaveTo;
    data['reason'] = reason;
    data['file'] = file;
    data['type'] = type;
    data['approve_status'] = approveStatus;
    return data;
  }
}
