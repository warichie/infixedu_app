import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/image_path.dart';

class StudentInfoPersonalModelClass {
  final String? icon;
  final String? title;
  final String? value;

  StudentInfoPersonalModelClass({this.icon, this.title, this.value});
}

List<StudentInfoPersonalModelClass> studentInfo = [
  StudentInfoPersonalModelClass(
      icon: ImagePath.calender,
      title: "Date of birth",
      value: AppText.dateOfBirth),
  StudentInfoPersonalModelClass(
      icon: ImagePath.age, title: "Age", value: AppText.age),
  StudentInfoPersonalModelClass(
      icon: ImagePath.mail, title: "Phone number", value: AppText.phoneNumber),
  StudentInfoPersonalModelClass(
      icon: ImagePath.phone, title: "Email address", value: AppText.email),
  StudentInfoPersonalModelClass(
      icon: ImagePath.address,
      title: "Present address",
      value: AppText.presentAddress),
];
