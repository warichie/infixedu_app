class NotificationModel {
  bool? success;
  Data? data;
  String? message;

  NotificationModel({this.success, this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<UnreadNotifications>? unreadNotifications;
  int? unreadNotificationsCount;

  Data({this.unreadNotifications, this.unreadNotificationsCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['unread_notifications'] != null) {
      unreadNotifications = <UnreadNotifications>[];
      json['unread_notifications'].forEach((v) {
        unreadNotifications!.add(UnreadNotifications.fromJson(v));
      });
    }
    unreadNotificationsCount = json['unread_notifications_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (unreadNotifications != null) {
      data['unread_notifications'] =
          unreadNotifications!.map((v) => v.toJson()).toList();
    }
    data['unread_notifications_count'] = unreadNotificationsCount;
    return data;
  }
}

class UnreadNotifications {
  String? message;
  String? createdAt;
  String? userPhoto;

  UnreadNotifications({this.message, this.createdAt, this.userPhoto,});

  UnreadNotifications.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['created_at'];
    userPhoto = json['user_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['created_at'] = createdAt;
    data['user_photo'] = userPhoto;
    return data;
  }
}
