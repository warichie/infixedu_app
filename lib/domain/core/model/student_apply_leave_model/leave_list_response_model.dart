class LeaveListResponseModel {
  bool? success;
  LeaveListData? data;
  String? message;

  LeaveListResponseModel({this.success, this.data, this.message});

  LeaveListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? LeaveListData.fromJson(json['data']) : null;
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

class LeaveListData {
  List<LeaveListPending>? pending;
  List<LeaveListApproved>? approved;
  List<LeaveListCancelled>? rejected;

  LeaveListData({this.pending, this.approved, this.rejected});

  LeaveListData.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      pending = <LeaveListPending>[];
      json['pending'].forEach((v) {
        pending!.add(LeaveListPending.fromJson(v));
      });
    }
    if (json['approved'] != null) {
      approved = <LeaveListApproved>[];
      json['approved'].forEach((v) {
        approved!.add(LeaveListApproved.fromJson(v));
      });
    }
    if (json['rejected'] != null) {
      rejected = <LeaveListCancelled>[];
      json['rejected'].forEach((v) {
        rejected!.add(LeaveListCancelled.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pending != null) {
      data['pending'] = pending!.map((v) => v.toJson()).toList();
    }
    if (approved != null) {
      data['approved'] = approved!.map((v) => v.toJson()).toList();
    }
    if (rejected != null) {
      data['rejected'] = rejected!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveListPending {
  int? id;
  String? leaveType;
  String? from;
  String? to;
  String? applyDate;
  String? status;
  String? reason;

  LeaveListPending(
      {this.id,
        this.leaveType,
        this.from,
        this.to,
        this.applyDate,
        this.status,
        this.reason});

  LeaveListPending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
    from = json['from'];
    to = json['to'];
    applyDate = json['apply_date'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_type'] = leaveType;
    data['from'] = from;
    data['to'] = to;
    data['apply_date'] = applyDate;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}

class LeaveListCancelled {
  int? id;
  String? leaveType;
  String? from;
  String? to;
  String? applyDate;
  String? status;
  String? reason;

  LeaveListCancelled(
      {this.id,
        this.leaveType,
        this.from,
        this.to,
        this.applyDate,
        this.status,
        this.reason});

  LeaveListCancelled.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
    from = json['from'];
    to = json['to'];
    applyDate = json['apply_date'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_type'] = leaveType;
    data['from'] = from;
    data['to'] = to;
    data['apply_date'] = applyDate;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}

class LeaveListApproved {
  int? id;
  String? leaveType;
  String? from;
  String? to;
  String? applyDate;
  String? status;
  String? reason;

  LeaveListApproved(
      {this.id,
        this.leaveType,
        this.from,
        this.to,
        this.applyDate,
        this.status,
        this.reason});

  LeaveListApproved.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
    from = json['from'];
    to = json['to'];
    applyDate = json['apply_date'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_type'] = leaveType;
    data['from'] = from;
    data['to'] = to;
    data['apply_date'] = applyDate;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}
