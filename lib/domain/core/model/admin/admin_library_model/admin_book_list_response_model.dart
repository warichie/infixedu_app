class AdminBookListResponseModel {
  bool? success;
  List<AdminBookData>? data;
  String? message;

  AdminBookListResponseModel({this.success, this.data, this.message});

  AdminBookListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminBookData>[];
      json['data'].forEach((v) {
        data!.add(AdminBookData.fromJson(v));
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

class AdminBookData {
  int? id;
  String? bookTitle;
  String? subjectName;
  String? publisherName;
  String? authorName;
  String? bookNumber;
  int? quantity;
  num? bookPrice;
  String? rackNumber;

  AdminBookData(
      {this.id,
        this.bookTitle,
        this.subjectName,
        this.publisherName,
        this.authorName,
        this.bookNumber,
        this.quantity,
        this.bookPrice,
        this.rackNumber});

  AdminBookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookTitle = json['book_title'];
    subjectName = json['subject_name'];
    publisherName = json['publisher_name'];
    authorName = json['author_name'];
    bookNumber = json['book_number'];
    quantity = json['quantity'];
    bookPrice = json['book_price'];
    rackNumber = json['rack_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['book_title'] = bookTitle;
    data['subject_name'] = subjectName;
    data['publisher_name'] = publisherName;
    data['author_name'] = authorName;
    data['book_number'] = bookNumber;
    data['quantity'] = quantity;
    data['book_price'] = bookPrice;
    data['rack_number'] = rackNumber;
    return data;
  }
}
