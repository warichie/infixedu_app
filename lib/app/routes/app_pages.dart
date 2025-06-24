import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/active_exam/bindings/active_exam_binding.dart';
import '../modules/active_exam/views/active_exam_view.dart';
import '../modules/add_payment/bindings/add_payment_binding.dart';
import '../modules/add_payment/views/add_payment_view.dart';
import '../modules/admin_add_book/bindings/admin_add_book_binding.dart';
import '../modules/admin_add_book/views/admin_add_book_view.dart';
import '../modules/admin_add_content/bindings/admin_add_content_binding.dart';
import '../modules/admin_add_content/views/admin_add_content_view.dart';
import '../modules/admin_add_dormitory/bindings/admin_add_dormitory_binding.dart';
import '../modules/admin_add_dormitory/views/admin_add_dormitory_view.dart';
import '../modules/admin_add_member/bindings/admin_add_member_binding.dart';
import '../modules/admin_add_member/views/admin_add_member_view.dart';
import '../modules/admin_add_room/bindings/admin_add_room_binding.dart';
import '../modules/admin_add_room/views/admin_add_room_view.dart';
import '../modules/admin_assign_vehicle/bindings/admin_assign_vehicle_binding.dart';
import '../modules/admin_assign_vehicle/views/admin_assign_vehicle_view.dart';
import '../modules/admin_attendance/bindings/admin_attendance_binding.dart';
import '../modules/admin_attendance/views/admin_attendance_view.dart';
import '../modules/admin_book_list/bindings/admin_book_list_binding.dart';
import '../modules/admin_book_list/views/admin_book_list_view.dart';
import '../modules/admin_class_attendance_individual_details/bindings/admin_class_attendance_individual_details_binding.dart';
import '../modules/admin_class_attendance_individual_details/views/admin_class_attendance_individual_details_view.dart';
import '../modules/admin_class_attendance_search/bindings/admin_class_attendance_search_binding.dart';
import '../modules/admin_class_attendance_search/views/admin_class_attendance_search_view.dart';
import '../modules/admin_class_attendance_search_individual/bindings/admin_class_attendance_search_individual_binding.dart';
import '../modules/admin_class_attendance_search_individual/views/admin_class_attendance_search_individual_view.dart';
import '../modules/admin_class_attendance_search_individual_list/bindings/admin_class_attendance_search_individual_list_binding.dart';
import '../modules/admin_class_attendance_search_individual_list/views/admin_class_attendance_search_individual_list_view.dart';
import '../modules/admin_class_set_attendance/bindings/admin_class_set_attendance_binding.dart';
import '../modules/admin_class_set_attendance/views/admin_class_set_attendance_view.dart';
import '../modules/admin_content/bindings/admin_content_binding.dart';
import '../modules/admin_content/views/admin_content_view.dart';
import '../modules/admin_content_list/bindings/admin_content_list_binding.dart';
import '../modules/admin_content_list/views/admin_content_list_view.dart';
import '../modules/admin_dormitory/bindings/admin_dormitory_binding.dart';
import '../modules/admin_dormitory/views/admin_dormitory_view.dart';
import '../modules/admin_fees/bindings/admin_fees_binding.dart';
import '../modules/admin_fees/views/admin_fees_view.dart';
import '../modules/admin_fees_group/bindings/admin_fees_group_binding.dart';
import '../modules/admin_fees_group/views/admin_fees_group_view.dart';
import '../modules/admin_fees_invoice/bindings/admin_fees_invoice_binding.dart';
import '../modules/admin_fees_invoice/views/admin_fees_invoice_view.dart';
import '../modules/admin_fees_invoice_list/bindings/admin_fees_invoice_list_binding.dart';
import '../modules/admin_fees_invoice_list/views/admin_fees_invoice_list_view.dart';
import '../modules/admin_fees_type/bindings/admin_fees_type_binding.dart';
import '../modules/admin_fees_type/views/admin_fees_type_view.dart';
import '../modules/admin_leave/bindings/admin_leave_binding.dart';
import '../modules/admin_leave/views/admin_leave_view.dart';
import '../modules/admin_library/bindings/admin_library_binding.dart';
import '../modules/admin_library/views/admin_library_view.dart';
import '../modules/admin_notice/bindings/admin_notice_binding.dart';
import '../modules/admin_notice/views/admin_notice_view.dart';
import '../modules/admin_room_list/bindings/admin_room_list_binding.dart';
import '../modules/admin_room_list/views/admin_room_list_view.dart';
import '../modules/admin_route/bindings/admin_route_binding.dart';
import '../modules/admin_route/views/admin_route_view.dart';
import '../modules/admin_settings/bindings/admin_settings_binding.dart';
import '../modules/admin_settings/views/admin_settings_view.dart';
import '../modules/admin_students_search/bindings/admin_students_search_binding.dart';
import '../modules/admin_students_search/views/admin_students_search_view.dart';
import '../modules/admin_students_search_list/bindings/admin_students_search_list_binding.dart';
import '../modules/admin_students_search_list/views/admin_students_search_list_view.dart';
import '../modules/admin_subject_attendance_search/bindings/admin_subject_attendance_search_binding.dart';
import '../modules/admin_subject_attendance_search/views/admin_subject_attendance_search_view.dart';
import '../modules/admin_subject_attendance_search_individual/bindings/admin_subject_attendance_search_individual_binding.dart';
import '../modules/admin_subject_attendance_search_individual/views/admin_subject_attendance_search_individual_view.dart';
import '../modules/admin_subject_attendance_search_individual_details/bindings/admin_subject_attendance_search_individual_details_binding.dart';
import '../modules/admin_subject_attendance_search_individual_details/views/admin_subject_attendance_search_individual_details_view.dart';
import '../modules/admin_subject_attendance_search_individual_list/bindings/admin_subject_attendance_search_individual_list_binding.dart';
import '../modules/admin_subject_attendance_search_individual_list/views/admin_subject_attendance_search_individual_list_view.dart';
import '../modules/admin_subject_attendance_search_list/bindings/admin_subject_attendance_search_list_binding.dart';
import '../modules/admin_subject_attendance_search_list/views/admin_subject_attendance_search_list_view.dart';
import '../modules/admin_transport/bindings/admin_transport_binding.dart';
import '../modules/admin_transport/views/admin_transport_view.dart';
import '../modules/admin_transport_details/bindings/admin_transport_details_binding.dart';
import '../modules/admin_transport_details/views/admin_transport_details_view.dart';
import '../modules/admin_vehicle/bindings/admin_vehicle_binding.dart';
import '../modules/admin_vehicle/views/admin_vehicle_view.dart';
import '../modules/apply_leave/bindings/apply_leave_binding.dart';
import '../modules/apply_leave/views/apply_leave_view.dart';
import '../modules/assignment/bindings/assignment_binding.dart';
import '../modules/assignment/views/assignment_view.dart';
import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/bank_payment_list/bindings/bank_payment_list_binding.dart';
import '../modules/bank_payment_list/views/bank_payment_list_view.dart';
import '../modules/blocked_users/bindings/blocked_users_binding.dart';
import '../modules/blocked_users/views/blocked_users_view.dart';
import '../modules/book_issued/bindings/book_issued_binding.dart';
import '../modules/book_issued/views/book_issued_view.dart';
import '../modules/book_list/bindings/book_list_binding.dart';
import '../modules/book_list/views/book_list_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chat_search/bindings/chat_search_binding.dart';
import '../modules/chat_search/views/chat_search_view.dart';
import '../modules/child_home/bindings/child_home_binding.dart';
import '../modules/child_home/views/child_home_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dormitory/bindings/dormitory_binding.dart';
import '../modules/dormitory/views/dormitory_view.dart';
import '../modules/exam_result/bindings/exam_result_binding.dart';
import '../modules/exam_result/views/exam_result_view.dart';
import '../modules/examination/bindings/examination_binding.dart';
import '../modules/examination/views/examination_view.dart';
import '../modules/fees/bindings/fees_binding.dart';
import '../modules/fees/views/fees_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/group_chat/bindings/group_chat_binding.dart';
import '../modules/group_chat/views/group_chat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/launch_webview/bindings/launch_webview_binding.dart';
import '../modules/launch_webview/views/launch_webview_view.dart';
import '../modules/leave/bindings/leave_binding.dart';
import '../modules/leave/views/leave_view.dart';
import '../modules/leave_list/bindings/leave_list_binding.dart';
import '../modules/leave_list/views/leave_list_view.dart';
import '../modules/library/bindings/library_binding.dart';
import '../modules/library/views/library_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notice/bindings/notice_binding.dart';
import '../modules/notice/views/notice_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/view/notification_view.dart';
import '../modules/online_exam/bindings/online_exam_binding.dart';
import '../modules/online_exam/views/online_exam_view.dart';
import '../modules/other_downloads/bindings/other_downloads_binding.dart';
import '../modules/other_downloads/views/other_downloads_view.dart';
import '../modules/parent_child/bindings/parent_child_binding.dart';
import '../modules/parent_child/views/parent_child_view.dart';
import '../modules/profile/bindings/profile_bindings.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_edit/bindings/profile_edit_binding.dart';
import '../modules/profile_edit/views/profile_edit_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/result/views/result_view.dart';
import '../modules/routine/bindings/routine_binding.dart';
import '../modules/routine/views/routine_view.dart';
import '../modules/schedule/bindings/schedule_binding.dart';
import '../modules/schedule/views/schedule_view.dart';
import '../modules/secondary_splash/bindings/secondary_splash_binding.dart';
import '../modules/secondary_splash/views/secondary_splash_view.dart';
import '../modules/service_error/bindings/service_error_binding.dart';
import '../modules/service_error/views/service_error_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/single_chat/bindings/single_chat_binding.dart';
import '../modules/single_chat/views/single_chat_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/staff/bindings/staff_binding.dart';
import '../modules/staff/views/staff_view.dart';
import '../modules/staff_individual_details/bindings/staff_individual_details_binding.dart';
import '../modules/staff_individual_details/views/staff_individual_details_view.dart';
import '../modules/staff_list/bindings/staff_list_binding.dart';
import '../modules/staff_list/views/staff_list_view.dart';
import '../modules/student_class/bindings/student_class_binding.dart';
import '../modules/student_class/views/student_class_view.dart';
import '../modules/student_homework/bindings/student_homework_binding.dart';
import '../modules/student_homework/views/student_homework_view.dart';
import '../modules/student_lesson_plan/bindings/student_lesson_plan_binding.dart';
import '../modules/student_lesson_plan/views/student_lesson_plan_view.dart';
import '../modules/student_search_attendance/bindings/student_search_attendance_binding.dart';
import '../modules/student_search_attendance/views/student_search_attendance_view.dart';
import '../modules/student_search_subject_attendance/bindings/student_search_subject_attendance_binding.dart';
import '../modules/student_search_subject_attendance/views/student_search_subject_attendance_view.dart';
import '../modules/student_wallet/bindings/student_wallet_binding.dart';
import '../modules/student_wallet/views/student_wallet_view.dart';
import '../modules/study_materials/bindings/study_materials_binding.dart';
import '../modules/study_materials/views/study_materials_view.dart';
import '../modules/subjects/bindings/subjects_binding.dart';
import '../modules/subjects/views/subjects_view.dart';
import '../modules/syllabus/bindings/syllabus_bindings.dart';
import '../modules/syllabus/views/syllabus_views.dart';
import '../modules/te_academic/bindings/te_academic_binding.dart';
import '../modules/te_academic/views/te_academic_view.dart';
import '../modules/te_add_homework/bindings/te_add_homework_binding.dart';
import '../modules/te_add_homework/views/te_add_homework_view.dart';
import '../modules/te_apply_leave/bindings/te_apply_leave_binding.dart';
import '../modules/te_apply_leave/views/te_apply_leave_view.dart';
import '../modules/te_homework/bindings/te_homework_binding.dart';
import '../modules/te_homework/views/te_homework_view.dart';
import '../modules/te_homework_evaluation/bindings/te_homework_evaluation_binding.dart';
import '../modules/te_homework_evaluation/views/te_homework_evaluation_view.dart';
import '../modules/te_homework_list/bindings/te_homework_list_binding.dart';
import '../modules/te_homework_list/views/te_homework_list_view.dart';
import '../modules/te_leave/bindings/te_leave_binding.dart';
import '../modules/te_leave/views/te_leave_view.dart';
import '../modules/te_leave_list/bindings/te_leave_list_binding.dart';
import '../modules/te_leave_list/views/te_leave_list_view.dart';
import '../modules/te_search_class_routine/bindings/te_search_class_routine_binding.dart';
import '../modules/te_search_class_routine/views/te_search_class_routine_view.dart';
import '../modules/te_search_class_routine_list/bindings/te_search_class_routine_list_binding.dart';
import '../modules/te_search_class_routine_list/views/te_search_class_routine_list_view.dart';
import '../modules/te_subjects/bindings/te_subjects_binding.dart';
import '../modules/te_subjects/views/te_subjects_view.dart';
import '../modules/teacher/bindings/teacher_binding.dart';
import '../modules/teacher/views/teacher_view.dart';
import '../modules/transport/bindings/transport_binding.dart';
import '../modules/transport/views/transport_view.dart';
import '../modules/virtual_class_list/bindings/virtual_class_list_binding.dart';
import '../modules/virtual_class_list/views/virtual_class_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SECONDARY_SPLASH;
  // static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SECONDARY_SPLASH,
      page: () => const SecondarySplashView(),
      binding: SecondarySplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SYLLABUS,
      page: () => const SyllabusView(),
      binding: SyllabusBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      bindings: [
        DashboardBinding(),
        ProfileBinding(),
        HomeBinding(),
        NotificationBinding(),
        RoutineBinding(),
        FeesBinding(),
        AdminAttendanceBinding(),
        TeAcademicBinding(),
        TeHomeworkBinding(),
        ChildHomeBinding(),
      ],
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => const ProfileEditView(),
      binding: ProfileEditBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.STUDENT_HOMEWORK,
      page: () => const StudentHomeworkView(),
      binding: StudentHomeworkBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(microseconds: 500),
    ),
    GetPage(
      name: _Paths.ROUTINE,
      page: () => const RoutineView(),
      binding: RoutineBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDY_MATERIALS,
      page: () => const StudyMaterialsView(),
      binding: StudyMaterialsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ASSIGNMENT,
      page: () => const AssignmentView(),
      binding: AssignmentBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
      transition: Transition.fade,
    ),
    GetPage(
        name: _Paths.RESULT,
        page: () => const ResultView(),
        binding: ResultBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: _Paths.ACTIVE_EXAM,
        page: () => const ActiveExamView(),
        binding: ActiveExamBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: _Paths.EXAMINATION,
      page: () => const ExaminationView(),
      binding: ExaminationBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ONLINE_EXAM,
      page: () => const OnlineExamView(),
      binding: OnlineExamBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.EXAM_RESULT,
      page: () => const ExamResultView(),
      binding: ExamResultBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.OTHER_DOWNLOADS,
      page: () => const OtherDownloadsView(),
      binding: OtherDownloadsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.DORMITORY,
      page: () => const DormitoryView(),
      binding: DormitoryBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.APPLY_LEAVE,
      page: () => const ApplyLeaveView(),
      binding: ApplyLeaveBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.LEAVE_LIST,
      page: () => const LeaveListView(),
      binding: LeaveListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.LEAVE,
      page: () => const LeaveView(),
      binding: LeaveBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ATTENDANCE,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NOTICE,
      page: () => const NoticeView(),
      binding: NoticeBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.SUBJECTS,
      page: () => const SubjectsView(),
      binding: SubjectsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TEACHER,
      page: () => const TeacherView(),
      binding: TeacherBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.LIBRARY,
      page: () => const LibraryView(),
      binding: LibraryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.BOOK_LIST,
      page: () => const BookListView(),
      binding: BookListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.BOOK_ISSUED,
      page: () => const BookIssuedView(),
      binding: BookIssuedBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TRANSPORT,
      page: () => const TransportView(),
      binding: TransportBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FEES,
      page: () => const FeesView(),
      binding: FeesBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: _Paths.CHAT_SEARCH,
      page: () => const ChatSearchView(),
      binding: ChatSearchBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STUDENT_SEARCH_ATTENDANCE,
      page: () => const StudentSearchAttendanceView(),
      binding: StudentSearchAttendanceBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STUDENT_LESSON_PLAN,
      page: () => const StudentLessonPlanView(),
      binding: StudentLessonPlanBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STUDENT_SEARCH_SUBJECT_ATTENDANCE,
      page: () => const StudentSearchSubjectAttendanceView(),
      binding: StudentSearchSubjectAttendanceBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STUDENT_WALLET,
      page: () => const StudentWalletView(),
      binding: StudentWalletBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.BLOCKED_USERS,
      page: () => const BlockedUsersView(),
      binding: BlockedUsersBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STAFF,
      page: () => const StaffView(),
      binding: StaffBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STAFF_LIST,
      page: () => const StaffListView(),
      binding: StaffListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STAFF_INDIVIDUAL_DETAILS,
      page: () => const StaffIndividualDetailsView(),
      binding: StaffIndividualDetailsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.SINGLE_CHAT,
      page: () => const SingleChatView(),
      binding: SingleChatBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STUDENT_CLASS,
      page: () => const StudentClassView(),
      binding: StudentClassBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_LEAVE,
      page: () => const AdminLeaveView(),
      binding: AdminLeaveBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_DORMITORY,
      page: () => const AdminDormitoryView(),
      binding: AdminDormitoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_ADD_DORMITORY,
      page: () => const AdminAddDormitoryView(),
      binding: AdminAddDormitoryBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_ADD_ROOM,
      page: () => const AdminAddRoomView(),
      binding: AdminAddRoomBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_ROOM_LIST,
      page: () => const AdminRoomListView(),
      binding: AdminRoomListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_FEES,
      page: () => const AdminFeesView(),
      binding: AdminFeesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_FEES_GROUP,
      page: () => const AdminFeesGroupView(),
      binding: AdminFeesGroupBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_FEES_TYPE,
      page: () => const AdminFeesTypeView(),
      binding: AdminFeesTypeBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_FEES_INVOICE,
      page: () => const AdminFeesInvoiceView(),
      binding: AdminFeesInvoiceBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_ATTENDANCE,
      page: () => const AdminAttendanceView(),
      binding: AdminAttendanceBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_CLASS_ATTENDANCE_SEARCH,
      page: () => const AdminClassAttendanceSearchView(),
      binding: AdminClassAttendanceSearchBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_SUBJECT_ATTENDANCE_SEARCH,
      page: () => const AdminSubjectAttendanceSearchView(),
      binding: AdminSubjectAttendanceSearchBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL,
      page: () => const AdminSubjectAttendanceSearchIndividualView(),
      binding: AdminSubjectAttendanceSearchIndividualBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_CLASS_ATTENDANCE_SEARCH_INDIVIDUAL,
      page: () => const AdminClassAttendanceSearchIndividualView(),
      binding: AdminClassAttendanceSearchIndividualBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_CLASS_SET_ATTENDANCE,
      page: () => const AdminClassSetAttendanceView(),
      binding: AdminClassSetAttendanceBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_FEES_INVOICE_LIST,
      page: () => const AdminFeesInvoiceListView(),
      binding: AdminFeesInvoiceListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_STUDENTS_SEARCH,
      page: () => const AdminStudentsSearchView(),
      binding: AdminStudentsSearchBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_STUDENTS_SEARCH_LIST,
      page: () => const AdminStudentsSearchListView(),
      binding: AdminStudentsSearchListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_CONTENT,
      page: () => const AdminContentView(),
      binding: AdminContentBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_CONTENT_LIST,
      page: () => const AdminContentListView(),
      binding: AdminContentListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_ADD_CONTENT,
      page: () => const AdminAddContentView(),
      binding: AdminAddContentBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_LIBRARY,
      page: () => const AdminLibraryView(),
      binding: AdminLibraryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_ADD_BOOK,
      page: () => const AdminAddBookView(),
      binding: AdminAddBookBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_BOOK_LIST,
      page: () => const AdminBookListView(),
      binding: AdminBookListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_ADD_MEMBER,
      page: () => const AdminAddMemberView(),
      binding: AdminAddMemberBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_CLASS_ATTENDANCE_SEARCH_INDIVIDUAL_LIST,
      page: () => const AdminClassAttendanceSearchIndividualListView(),
      binding: AdminClassAttendanceSearchIndividualListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_CLASS_ATTENDANCE_INDIVIDUAL_DETAILS,
      page: () => const AdminClassAttendanceIndividualDetailsView(),
      binding: AdminClassAttendanceIndividualDetailsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL_LIST,
      page: () => const AdminSubjectAttendanceSearchIndividualListView(),
      binding: AdminSubjectAttendanceSearchIndividualListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_SUBJECT_ATTENDANCE_SEARCH_LIST,
      page: () => const AdminSubjectAttendanceSearchListView(),
      binding: AdminSubjectAttendanceSearchListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_TRANSPORT,
      page: () => const AdminTransportView(),
      binding: AdminTransportBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL_DETAILS,
      page: () => const AdminSubjectAttendanceSearchIndividualDetailsView(),
      binding: AdminSubjectAttendanceSearchIndividualDetailsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_NOTICE,
      page: () => const AdminNoticeView(),
      binding: AdminNoticeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN_ROUTE,
      page: () => const AdminRouteView(),
      binding: AdminRouteBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_VEHICLE,
      page: () => const AdminVehicleView(),
      binding: AdminVehicleBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_ASSIGN_VEHICLE,
      page: () => const AdminAssignVehicleView(),
      binding: AdminAssignVehicleBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_TRANSPORT_DETAILS,
      page: () => const AdminTransportDetailsView(),
      binding: AdminTransportDetailsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ADMIN_SETTINGS,
      page: () => const AdminSettingsView(),
      binding: AdminSettingsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TE_HOMEWORK,
      page: () => const TeHomeworkView(),
      binding: TeHomeworkBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TE_ADD_HOMEWORK,
      page: () => const TeAddHomeworkView(),
      binding: TeAddHomeworkBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TE_HOMEWORK_LIST,
      page: () => const TeHomeworkListView(),
      binding: TeHomeworkListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TE_HOMEWORK_EVALUATION,
      page: () => const TeHomeworkEvaluationView(),
      binding: TeHomeworkEvaluationBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TE_ACADEMIC,
      page: () => const TeAcademicView(),
      binding: TeAcademicBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TE_LEAVE,
      page: () => const TeLeaveView(),
      binding: TeLeaveBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TE_APPLY_LEAVE,
      page: () => const TeApplyLeaveView(),
      binding: TeApplyLeaveBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TE_LEAVE_LIST,
      page: () => const TeLeaveListView(),
      binding: TeLeaveListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TE_SEARCH_CLASS_ROUTINE,
      page: () => const TeSearchClassRoutineView(),
      binding: TeSearchClassRoutineBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TE_SEARCH_CLASS_ROUTINE_LIST,
      page: () => const TeSearchClassRoutineListView(),
      binding: TeSearchClassRoutineListBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TE_SUBJECTS,
      page: () => const TeSubjectsView(),
      binding: TeSubjectsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_CHILD,
      page: () => const ParentChildView(),
      binding: ParentChildBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.CHILD_HOME,
      page: () => const ChildHomeView(),
      binding: ChildHomeBinding(),
    ),
    GetPage(
      name: _Paths.GROUP_CHAT,
      page: () => const GroupChatView(),
      binding: GroupChatBinding(),
    ),
    GetPage(
      name: _Paths.VIRTUAL_CLASS_LIST,
      page: () => const VirtualClassListView(),
      binding: VirtualClassListBinding(),
    ),
    GetPage(
      name: _Paths.LAUNCH_WEBVIEW,
      page: () => const LaunchWebviewView(),
      binding: LaunchWebviewBinding(),
    ),
    GetPage(
      name: _Paths.BANK_PAYMENT_LIST,
      page: () => const BankPaymentListView(),
      binding: BankPaymentListBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_ERROR,
      page: () => const ServiceErrorView(),
      binding: ServiceErrorBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PAYMENT,
      page: () => const AddPaymentView(),
      binding: AddPaymentBinding(),
    ),
  ];
}
