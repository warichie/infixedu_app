
class StudentIssuedBookListResponseModel {
  bool? success;
  List<StudentIssuedBookData>? data;
  String? message;

  StudentIssuedBookListResponseModel({this.success, this.data, this.message});

  StudentIssuedBookListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StudentIssuedBookData>[];
      json['data'].forEach((v) {
        data!.add(StudentIssuedBookData.fromJson(v));
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

class StudentIssuedBookData {
  int? id;
  String? bookTitle;
  String? bookNumber;
  String? authorName;
  String? subject;
  String? issueDate;
  String? returnDate;
  String? status;

  StudentIssuedBookData(
      {this.id,
        this.bookTitle,
        this.bookNumber,
        this.authorName,
        this.subject,
        this.issueDate,
        this.returnDate,
        this.status});

  StudentIssuedBookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookTitle = json['book_title'];
    bookNumber = json['book_number'];
    authorName = json['author_name'];
    subject = json['subject'];
    issueDate = json['issue_date'];
    returnDate = json['return_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['book_title'] = bookTitle;
    data['book_number'] = bookNumber;
    data['author_name'] = authorName;
    data['subject'] = subject;
    data['issue_date'] = issueDate;
    data['return_date'] = returnDate;
    data['status'] = status;
    return data;
  }
}
