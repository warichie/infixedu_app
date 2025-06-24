import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/config/global_variable/app_settings_controller.dart';
import 'package:get/get.dart';

class HomeTileModelClass {
  final String icon;
  final String title;
  final String value;

  HomeTileModelClass({
    required this.icon,
    required this.title,
    required this.value,
  });
}

List<HomeTileModelClass> studentList = [
  HomeTileModelClass(
      icon: ImagePath.studentHomeWork, title: 'Homework', value: 'Homework'),
  HomeTileModelClass(
      icon: ImagePath.studentStudyMaterials,
      title: 'Study Materials',
      value: 'Study Materials'),
  HomeTileModelClass(
      icon: ImagePath.studentAttendance,
      title: 'Attendance',
      value: 'Attendance'),
  HomeTileModelClass(
      icon: ImagePath.studentWallet, title: 'Wallet', value: 'Wallet'),
  HomeTileModelClass(
      icon: ImagePath.studentExamination,
      title: 'Examination',
      value: 'Examination'),
  HomeTileModelClass(
      icon: ImagePath.studentOnlineExam,
      title: 'Online Exam',
      value: 'Online Exam'),
  HomeTileModelClass(
      icon: ImagePath.studentLesson, title: 'Lesson', value: 'Lesson'),
  HomeTileModelClass(
      icon: ImagePath.studentLeave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(
      icon: ImagePath.studentNotice, title: 'Notice', value: 'Notice'),
  HomeTileModelClass(
      icon: ImagePath.studentSubjects, title: 'Subjects', value: 'Subjects'),
  HomeTileModelClass(
      icon: ImagePath.studentTeacher, title: 'Teacher', value: 'Teacher'),
  HomeTileModelClass(
      icon: ImagePath.studentLibrary, title: 'Library', value: 'Library'),
  HomeTileModelClass(
      icon: ImagePath.studentTransport, title: 'Transport', value: 'Transport'),
  HomeTileModelClass(
      icon: ImagePath.studentDormitory, title: 'Dormitory', value: 'Dormitory'),
  HomeTileModelClass(
      icon: ImagePath.studentClass, title: 'Class', value: 'Class'),
  HomeTileModelClass(
      icon: ImagePath.studentSettings, title: 'Settings', value: 'Settings'),
];

List<HomeTileModelClass> parentList = [
  HomeTileModelClass(
      icon: ImagePath.parentsChild, title: 'Child', value: 'Child'),
  HomeTileModelClass(
      icon: ImagePath.parentsAbout, title: 'About', value: 'About'),
  HomeTileModelClass(
      icon: ImagePath.parentsSettings, title: 'Settings', value: 'Settings'),
];

List<HomeTileModelClass> teacherList = [
  HomeTileModelClass(
      icon: ImagePath.teacherStudents, title: 'Students', value: 'Students'),
  HomeTileModelClass(
      icon: ImagePath.teacherLeave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(
      icon: ImagePath.teacherContents, title: 'Content', value: 'Content'),
  HomeTileModelClass(
      icon: ImagePath.teacherNotice, title: 'Notice', value: 'Notice'),
  HomeTileModelClass(
      icon: ImagePath.teacherLibrary, title: 'Library', value: 'Library'),
  HomeTileModelClass(
      icon: ImagePath.teacherAbout, title: 'About', value: 'About'),
  HomeTileModelClass(
      icon: ImagePath.teacherClass, title: 'Class', value: 'Class'),
  HomeTileModelClass(
      icon: ImagePath.teacherSettings, title: 'Settings', value: 'Settings'),
];

List<HomeTileModelClass> adminList = [
  HomeTileModelClass(
      icon: ImagePath.adminStudents, title: 'Students', value: 'Students'),
  HomeTileModelClass(
      icon: ImagePath.adminLeave, title: 'Leave', value: 'Leave'),
  HomeTileModelClass(
      icon: ImagePath.adminStaff, title: 'Staff', value: 'Staff'),
  HomeTileModelClass(
      icon: ImagePath.adminDormitory, title: 'Dormitory', value: 'Dormitory'),
  HomeTileModelClass(
      icon: ImagePath.adminClassAttendance,
      title: 'Attendance',
      value: 'Attendance'),
  if (Get.find<AppSettingsController>()
          .systemSettings
          .value
          .data
          ?.systemSettings
          ?.feesStatus ==
      1)
    HomeTileModelClass(icon: ImagePath.adminFees, title: 'Fees', value: 'Fees'),
  HomeTileModelClass(
      icon: ImagePath.adminContent, title: 'Content', value: 'Content'),
  HomeTileModelClass(
      icon: ImagePath.adminNotice, title: 'Notice', value: 'Notice'),
  HomeTileModelClass(
      icon: ImagePath.adminLibrary, title: 'Library', value: 'Library'),
  HomeTileModelClass(
      icon: ImagePath.adminTransport, title: 'Transport', value: 'Transport'),
  HomeTileModelClass(
      icon: ImagePath.adminClass, title: 'Class', value: 'Class'),
  HomeTileModelClass(
      icon: ImagePath.adminSettings, title: 'Settings', value: 'Settings'),
];
