import '../../config/app_config.dart';

class InfixApi {
  static String root = '${AppConfig.domainName}/';

  static String apiLevel = '${root}api/v2';

  static String baseApi = '$apiLevel/';

  static String uploadHomework = "${baseApi}save-homework-data";

  static String studentAllNotice = "${baseApi}student-noticeboard";

  static String uploadContent = "${baseApi}teacher-upload-content";
  static String currentPermission = "${baseApi}privacy-permission-status";
  static String createVirtualClass = "zoom/create-virtual-class";
  static String createVirtualClassUrl = "zoom-class-room";
  static String zoomMakeMeeting = "zoom-make-meeting";
  static String service = '${AppConfig.domainName}/api/service/check';
  static String zoomMakeMeetingUrl = "zoom-meeting-room";

  // static String login(String email, String password) {
  //   return '${baseApi}login?email=$email&password=$password';
  // }

  static String login() => '${baseApi}login';
  static String logout = '${baseApi}auth/logout';

  static String editProfile(int studentId) {
    return '${baseApi}student-profile-edit?student_id=$studentId';
  }

  static String updateProfile({required int studentId}) {
    return '${baseApi}student-profile-update?student_id=$studentId';
  }

  static String profilePersonal() {
    return '${baseApi}profile-personal';
  }

  static String profileParents() {
    return '${baseApi}profile-parents';
  }

  static String profileTransport() {
    return '${baseApi}profile-transport';
  }

  static String demoLogin(String role) {
    return '${baseApi}user-demo-login/$role';
  }

  static String readAllNotification = '${baseApi}view/all/notification';

  static String getStudentRecord({required int studentId}) {
    return "${baseApi}student-record?student_id=$studentId";
  }

  static String getSyllabusList(int studentRecordId) {
    return '${baseApi}student-syllabus?record_id=$studentRecordId';
  }

  static String syllabusDownloadUrl(int syllabusId) {
    return '${baseApi}student-assignment-file-download/$syllabusId';
  }

  static String getAssignmentList(int studentRecordId) {
    return '${baseApi}student-assignment?record_id=$studentRecordId';
  }

  static String getStudentOthersDownloadList(int studentRecordId) {
    return '${baseApi}student-others-download?record_id=$studentRecordId';
  }

  static String getStudentRoutineList(int studentRecordId) {
    return '${baseApi}student-class-routine?record_id=$studentRecordId';
  }

  static String getStudentExamResultList(
      {required int typeId, required int recordId}) {
    return '${baseApi}exam-result?exam_type_id=$typeId&record_id=$recordId';
  }

  static String getStudentExamList(int recordId) {
    return '${baseApi}student-exam-type?record_id=$recordId';
  }

  static String getStudentIssuedBookList({required int studentId}) {
    return '${baseApi}student-book-issue?student_id=$studentId';
  }

  static String getStudentExamSchedule(int examTypeId, int recordId) {
    return '${baseApi}student-exam-schedule?exam_type_id=$examTypeId&record_id=$recordId';
  }

  static String getStudentApplyLeaveType({required int roleId}) {
    return '${baseApi}leave-type?role_id=$roleId';
  }

  static String profileOthers() {
    return '${baseApi}profile-others';
  }

  static String getStudentTeacherList(int roleId) {
    return '${baseApi}student-teacher?record_id=$roleId';
  }

  static String getStudentLeaveList(int studentId) {
    return '${baseApi}apply-leave?student_id=$studentId';
  }

  static String getTeacherLeaveList = '${baseApi}teacher-leave-list';

  static String getStudentAttendance(
      {required int recordId, required int studentId}) {
    return '${baseApi}student-attendance?record_id=$recordId&student_id=$studentId';
  }

  static String getStudentSubjectSearchAttendance(
          {required int subjectId,
          required int recordId,
          required int studentId}) =>
      '${baseApi}subject-wise-attendance?subject_id=$subjectId&record_id=$recordId&student_id=$studentId';

  static String getStudentSubjectSearchAttendanceWithDate({
    required int subjectId,
    required int recordId,
    required int studentId,
    required int month,
    required int year,
  }) =>
      '${baseApi}subject-wise-attendance?subject_id=$subjectId&record_id=$recordId&student_id=$studentId&month=$month&year=$year';

  static String getStudentAttendanceWithDate({
    required int recordId,
    required int studentId,
    required int year,
    required int month,
  }) =>
      '${baseApi}student-attendance?year=$year&month=$month&record_id=$recordId&student_id=$studentId';

  static String getStudentOnlineExamResult({required int studentId}) {
    return "${baseApi}student-view-result?student_id=$studentId";
  }

  static String getStudentOnlineActiveExam({required int recordId}) {
    return "${baseApi}student-online-exam?record_id=$recordId";
  }

  static String getStudentDormitory({required int studentId}) {
    return "${baseApi}student-dormitory?student_id=$studentId";
  }

  static String studentProfilePhotoUpdate({required int studentId}) {
    return "${baseApi}student-profile-img-update?student_id=$studentId";
  }

  static String getStudentTransport({required int studentId}) {
    return "${baseApi}student-transport?student_id=$studentId";
  }

  static String bookList = "${baseApi}student-library";
  static String studentApplyLeave = "${baseApi}student-leave-store";
  static String studentUploadDocuments = "${baseApi}profile-documents-store";

  static String getStudentRemainingLeave(int studentId) {
    return "${baseApi}remaining-leave?student_id=$studentId";
  }

  static String getBookSearch({required String bookName}) {
    return "${baseApi}student-library?book_title=$bookName";
  }

  static String getChatUserSearch({required String keyword}) {
    return "${baseApi}admin-chat-user-search?keywords=$keyword";
  }

  static String getStudentSubjects(int recordId) {
    return "${baseApi}student-subject?record_id=$recordId";
  }

  static String getStudentFeesDetails({required int invoiceId}) {
    return "${baseApi}fees-invoice-view?fees_invoice_id=$invoiceId";
  }

  static String getFeesInvoiceDetails({required int invoiceId}) {
    return "${baseApi}add-fees-payment?fees_invoice_id=$invoiceId";
  }

  static String bankPayment = "${baseApi}student-fees-payment-stores";

  static String getStudentFeesList(
          {required int studentId, required int recordId}) =>
      "${baseApi}student-fees?student_id=$studentId&record_id=$recordId";

  static String profileDocumentGet() {
    return '${baseApi}profile-documents';
  }

  static String profileDocumentDelete({required documentId}) {
    return '${baseApi}profile-documents-delete?document_id=$documentId';
  }

  static String getStudentLessonPlan(
          {required int studentId,
          required int recordId,
          required String date}) =>
      '${baseApi}student-lesson-plan?student_id=$studentId&record_id=$recordId&next_date=$date';

  // '${baseApi}student-lesson-plan?user_id=$userId&record_id=$recordId';

  static String getStudentLessonPlanDetails({
    required int subjectId,required int studentId, required String date,
  }) => '${baseApi}view-lesson-plan-lesson?subject_id=$subjectId&date=$date&student_id=$studentId';
  static String forgetPassword = "${baseApi}forget-password";

  //// Student Wallet
  static String getPaymentList = '${baseApi}my-wallet';
  static String getPaymentMethodList = '${baseApi}add-amount-methods';
  static String getBankList = '${baseApi}add-amount-banks';

  //// .....................................................For Admin Module.....................................................

  static String getAdminStaffRoleList = '${baseApi}role-list';
  static String getAdminPendingLeaveList = '${baseApi}pending-leave-list';
  static String getAdminApproveLeaveList = '${baseApi}approve-leave-list';
  static String getAdminRejectedLeaveList = '${baseApi}rejected-leave-list';
  static String getAdminDormitoryList = '${baseApi}dormitory-list';
  static String getAdminRoomType = '${baseApi}room-type';
  static String addDormitoryRoomFromAdin = '${baseApi}room-store';
  static String dormitoryRoomList = '${baseApi}room-list';
  static String getFeesGroupList = '${baseApi}fees-group';
  static String createFeesGroup = '${baseApi}fees-group-store';

  static String getBankPaymentList(
          {required String startDate,
          required String endDate,
          required int classId,
          required int sectionId}) =>
      '${baseApi}bank-payment-list?start_date=$startDate&end_date=$endDate&class_id=$classId&section_id=$sectionId';
  static String getBankPaymentStatusUpdate =
      '${baseApi}bank-payment-change-status';
  static String updateSingleFeesGroup = '${baseApi}fees-group-update';

  static String deleteSingleFeesGroup({required int feesId}) =>
      '${baseApi}fees-group-delete?fees_group_id=$feesId';

  static String getFeesTypeList = '${baseApi}fees-type';
  static String getAdminFeesInvoiceList = '${baseApi}fees-invoice';

  static String searchAdminFeesInvoice(
          {required int classId,
          required int sectionId,
          required String studentName}) =>
      '${baseApi}fees-invoice?class_id=$classId&section_id=$sectionId&name=$studentName';

  static String deleteFeesType({required feesTypeId}) =>
      '${baseApi}fees-type-delete?fees_type_id=$feesTypeId';

  /// Dormitory
  static String addDormitoryFromAdmin = '${baseApi}dormitory-store';

  /// Student Class List
  static String getAdminClassList = '${baseApi}class-list';
  static String getTeacherClassList = '${baseApi}teacher-attendance-classes';

  static String getAdminSectionList({required int classId}) =>
      '${baseApi}section-list?class_id=$classId';

  static String getTeacherSectionList({required int classId}) =>
      '${baseApi}teacher-attendance-sections?class_id=$classId';

  static String getAdminStudentSubjectList(
          {required int classId, required int sectionId}) =>
      '${baseApi}subject-list?class=$classId&section=$sectionId';

  static String getTeacherStudentSubjectList(
          {required int classId, required int sectionId}) =>
      '${baseApi}teacher-attendance-subjects?class=$classId&section=$sectionId';

  static String getAdminStudentSearchAttendanceList(
          {required int classId,
          required int sectionId,
          required String selectedDate}) =>
      '${baseApi}student-search?class_id=$classId&section_id=$sectionId&attendance_date=$selectedDate';

  static String getTeacherStudentSearchAttendanceList(
          {required int classId,
          required int sectionId,
          required String selectedDate}) =>
      '${baseApi}teacher-attendance-students?class=$classId&section=$sectionId&attendance_date=$selectedDate';

  /// Attendance
  static String adminSubmitStudentAttendance =
      '${baseApi}submit-student-class-attendance';
  static String teacherSubmitStudentAttendance =
      '${baseApi}teacher-class-attendance-store';
  static String adminSubmitSubjectWiseStudentAttendance =
      '${baseApi}subject-wise-attendance-submit';
  static String teacherSubmitSubjectWiseStudentAttendance =
      '${baseApi}teacher-subject-attendance-submit';
  static String adminAttendanceMarkUnMarkHolyDay =
      '${baseApi}student-attendance-holiday';
  static String teacherSubjectWiseAttendanceMarkUnMarkHolyDay =
      '${baseApi}teacher-subject-holiday';
  static String teacherAttendanceMarkUnMarkHolyDay =
      '${baseApi}teacher-class-attendance-holiday';

  static String getAdminStudentSearchList({
    required int classId,
    required int sectionId,
    required String rollNo,
    required String name,
  }) =>
      '${baseApi}student-list-search?class=$classId&section=$sectionId&name=$name&roll_no=$rollNo';

  static String getAdminSubAttenSearchList({
    required int classId,
    required int sectionId,
    required int subjectId,
    required String rollINo,
    required String name,
  }) =>
      '${baseApi}subject-wise-students?class_id=$classId&section_id=$sectionId&subject_id=$subjectId&name=$name&roll_no=$rollINo';

  static String getTeacherSubAttenSearchList({
    required int classId,
    required int sectionId,
    required int subjectId,
    required String rollINo,
    required String name,
  }) =>
      '${baseApi}teacher-subject-wise-students?class_id=$classId&section_id=$sectionId&subject_id=$subjectId&name=$name&roll_no=$rollINo';

  static String getAdminSubAttenSearchIndividualList({
    required int classId,
    required int sectionId,
    required String rollINo,
    required String name,
  }) =>
      '${baseApi}student-search-attend?class=$classId&section=$sectionId &name=$name&roll_no=$rollINo';

  static String getTeacherSubAttenSearchIndividualList({
    required int classId,
    required int sectionId,
    required String rollINo,
    required String name,
  }) =>
      '${baseApi}teacher-search-student-attendance?class=$classId&section=$sectionId &name=$name&roll_no=$rollINo';

  static String getAdminSubAttenSearchDetailsList({
    required int recordId,
    required int subjectNameId,
  }) =>
      '${baseApi}student-subject-attendance?record_id=$recordId&subject_id=$subjectNameId';

  static String getTeacherSubAttenSearchDetailsList({
    required int recordId,
    required int subjectNameId,
  }) =>
      '${baseApi}teacher-subject-wise-students-attendance?record_id=$recordId&subject_id=$subjectNameId';

  static String getAdminStudentSearchDetailsList({
    required int studentAttendanceId,
  }) =>
      '${baseApi}student-attendance-report-search?student_attendance_id=$studentAttendanceId';

  static String getTeacherStudentSearchDetailsList({
    required int studentAttendanceId,
  }) =>
      '${baseApi}teacher-search-student-attendance-report?student_attendance_id=$studentAttendanceId';

  static String getAdminSubjectSearchAttendanceList({
    required int classId,
    required int sectionId,
    required int subjectId,
    required String attendanceDate,
  }) =>
      '${baseApi}subject-attendance-search?class=$classId&section=$sectionId&subject=$subjectId&attendance_date=$attendanceDate';

  // '${baseApi}subject-attendance-search?class_id=$classId&section_id=$sectionId&subject_id=$subjectId&attendance_date=$attendanceDate';

  static String getTeacherSubjectSearchAttendanceList({
    required int classId,
    required int sectionId,
    required int subjectId,
    required String attendanceDate,
  }) =>
      '${baseApi}teacher-subject-attendance-search?class=$classId&section=$sectionId&subject=$subjectId&attendance_date=$attendanceDate';

  static String getAdminStudentSearchDetailsListWithDate({
    required int studentAttendanceId,
    required int month,
    required int year,
  }) =>
      '${baseApi}student-attendance-report-search?student_attendance_id=$studentAttendanceId&month=$month&year=$year';

  static String getTeacherStudentSearchDetailsListWithDate({
    required int studentAttendanceId,
    required int month,
    required int year,
  }) =>
      '${baseApi}teacher-search-student-attendance-report?student_attendance_id=$studentAttendanceId&month=$month&year=$year';

  static String getAdminSubAttenSearchDetailsWithDateList({
    required int recordId,
    required int subjectNameId,
    required int month,
    required int year,
  }) =>
      '${baseApi}student-subject-attendance?record_id=$recordId&subject_id=$subjectNameId&month=$month&year=$year';

  static String getTeacherSubAttenSearchDetailsWithDateList({
    required int recordId,
    required int subjectNameId,
    required int month,
    required int year,
  }) =>
      '${baseApi}teacher-subject-wise-students-attendance?record_id=$recordId&subject_id=$subjectNameId&month=$month&year=$year';

  static String adminLeaveStatusUpdate({
    required int leaveId,
    required String statusType,
  }) =>
      '${baseApi}update-approve-leave?leave_id=$leaveId&approve_status=$statusType';

  static String getAdminRoleWiseStaff({required int staffRoleId}) =>
      '${baseApi}role-wise-staff-list?role_id=$staffRoleId';

  static String getAdminStaffIndividualData({required int staffIndividualId}) =>
      '${baseApi}individual-staff-details?staff_id=$staffIndividualId';

  static String getSingleStudentProfile({required int studentId}) =>
      '${baseApi}student-profile-personal?student_id=$studentId';

  static String getSingleParentProfile({required int studentId}) =>
      '${baseApi}student-profile-parents?student_id=$studentId';

  static String getSingleStudentTransportData({required int studentId}) =>
      '${baseApi}student-profile-transport?student_id=$studentId';

  static String getSingleStudentOthersData({required int studentId}) =>
      '${baseApi}student-profile-others?student_id=$studentId';

  static String getSingleStudentDocumentsData({required int studentId}) =>
      '${baseApi}student-profile-documents?student_id=$studentId';

  /// Admin Content Module
  static String getAdminContentList = '${baseApi}admin-upload-content-list';
  static String postAdminContent = '${baseApi}store-admin-content';

  static String adminContentDelete({required int contentId}) =>
      '${baseApi}delete-admin-content?content_id=$contentId';

  /// Admin Staff Notice
  static String getAdminStaffNoticeList = '${baseApi}admin-staff-notice-list';

  /// Admin Transport
  static String getAdminVehicleList = '${baseApi}admin-vehicle-list';
  static String adminAddVehicle = '${baseApi}admin-vehicle-store';
  static String getAdminTransportList = '${baseApi}assign-vehicle-list';
  static String getAdminTransportRouteList = '${baseApi}admin-route-list';
  static String getAdminDriverList = '${baseApi}admin-vehicle-drivers';
  static String postAdminTransportRoute = '${baseApi}admin-route-store';
  static String getAdminVehicleAssignRouteAndVehicleList =
      '${baseApi}assign-vehicle-to-route';
  static String postAdminVehicleAssignRouteAndVehicle =
      '${baseApi}store-assign-vehicle-to-route';
  static String postAdminRouteUpdate = '${baseApi}admin-route-update';

  static String deleteRoute({required int routeId}) =>
      '${baseApi}admin-route-delete?route_id=$routeId';

  /// Library
  static String getAdminBookCategoryAndSubjectList =
      '${baseApi}admin-add-book-dropdown-items';
  static String postAdminAddBook = '${baseApi}admin-book-store';
  static String createFeesType = '${baseApi}fees-type-store';
  static String updateSingleFeesType = '${baseApi}fees-type-update';

  /// Admin Library Module
  static String getAdminMemberRolesList = '${baseApi}admin-add-member-roles';
  static String postAdminLibraryAddMember =
      '${baseApi}store-admin-library-member';

  static String getAdminMemberUserNameList({required int roleId}) =>
      '${baseApi}admin-add-member-user-names?role_id=$roleId';

  static String getAdminMemberClassList({required int roleId}) =>
      '${baseApi}admin-add-member-classes?role_id=$roleId';

  static String getAdminMemberSectionList({required int classId}) =>
      '${baseApi}admin-add-member-sections?class_id=$classId';

  static String getAdminMemberStudentList(
          {required int classId, required int sectionId}) =>
      '${baseApi}admin-add-member-students?class=$classId&section=$sectionId';

  static String getAdminMemberParentList(
          {required int classId, required int sectionId}) =>
      '${baseApi}admin-add-member-parents?class=$classId&section=$sectionId';

  /// Admin Book Module
  static String getAdminBookList = '${baseApi}admin-book-list';

  /// Teacher academic module
  static String getTeacherSubjectList = '${baseApi}subjects';

  static String getTeacherMyRoutineList({required int userId}) =>
      '${baseApi}teacher-class-routine?user_id=$userId';

  static String getTeacherClassRoutineList(
          {required int classId, required int sectionId}) =>
      '${baseApi}class-routine?class_id=$classId&section_id=$sectionId';

  ///// ..............>>>>>>>>>>>>>>> Teacher Teacher Teacher Teacher ...................>>>>>>>>>>>>>>>>>>

  /// Teacher Homework
  static String getTeacherHomeworkList = '${baseApi}teacher-homework-list';
  static String submitEvaluation =
      '${baseApi}teacher-store-homework-evaluation';
  static String teacherAddHomework = '${baseApi}teacher-add-homework';
  static String getTeacherAddHomeworkClassList =
      '${baseApi}teacher-add-homework-for-class';

  static String getTeacherAddHomeworkSubjectList({required int classId}) =>
      '${baseApi}teacher-add-homework-for-subject?class_id=$classId';

  static String getTeacherAddHomeworkSectionList(
          {required int classId, required int subjectId}) =>
      '${baseApi}teacher-add-homework-for-section?class_id=$classId&subject_id=$subjectId';

  static String getTeacherHomeworkEvaluationList(
          {required int classId,
          required int sectionId,
          required int homeworkId,
          required String searchKey}) =>
      '${baseApi}teacher-homework-evaluation-list?class_id=$classId&section_id=$sectionId&homework_id=$homeworkId&search=$searchKey';

  static String getTeacherHomeworkSearch({
    required int classId,
    int? subjectId,
    int? sectionId,
  }) {
    String url = '${baseApi}teacher-homework-search?class_id=$classId';

    if (subjectId != null) {
      url += '&subject_id=$subjectId';
    }

    if (sectionId != null) {
      url += '&section_id=$sectionId';
    }

    return url;
  }

  /// Teacher Content
  static String getTeacherContentList = '${baseApi}teacher-content-list';
  static String postTeacherContent = '${baseApi}teacher-create-content';

  static String teacherContentDelete({required contentId}) =>
      '${baseApi}teacher-delete-content?content_id=$contentId';

  /// Teacher Notice
  static String getTeacherNoticeList = '${baseApi}teacher-notice-list';

  /// Teacher Notice
  static String getTeacherBookList = '${baseApi}teacher-book-list';

  /// Teacher Leave
  static String getTeacherLeaveType = '${baseApi}teacher-leave-types';
  static String teacherApplyLeave = '${baseApi}teacher-leave-store';

  /// .......................................... Parent Module .....................................................
  static String getParentsChildData({required int parentId}) =>
      '${baseApi}parent-childrens?parent_id=$parentId';

  /// About

  static String getTeacherAbout = '${baseApi}teacher-about';

  /// ..............................................................................................................
  /// ........................................... Chat Module ......................................................
  /// ..............................................................................................................
  static String getSingleChatUserList = '${baseApi}admin-chat-users';
  static String getGroupChatUserList = '${baseApi}admin-chat-groups';
  static String sendSingleChat = '${baseApi}admin-chat-send';
  static String sendGroupChat = '${baseApi}admin-group-chat-send';

  static String getSingleChatList({required int userId}) =>
      '${baseApi}admin-chat-list?to_user_id=$userId';

  static String getGroupChatList({required String groupId}) =>
      '${baseApi}admin-group-chats?group_id=$groupId';

  static String getSingleChatFileList({required int userID}) =>
      '${baseApi}admin-single-chat-files?user_id=$userID';

  static String getGroupChatFileList({required String groupId}) =>
      '${baseApi}admin-group-chat-files?group_id=$groupId';

  static String getGroupChatMemberList({required String groupId}) =>
      '${baseApi}admin-group-members?group_id=$groupId';

  static String groupLeaveMember({required String groupId}) =>
      '${baseApi}admin-group-leave?group_id=$groupId';

  static String groupDelete({required String groupId}) =>
      '${baseApi}admin-group-delete?group_id=$groupId';

  static String groupDeleteSingleChat({required int threadId}) =>
      '${baseApi}admin-group-chat-remove?thread_id=$threadId';

  static String deleteSingleChat({required int messageId}) =>
      '${baseApi}delete-admin-chat-single-message?message_id=$messageId';
  static String groupAddMember = '${baseApi}admin-add-group-member';

  static String forwardSingleChat(
          {required int userId, required int messageId}) =>
      '${baseApi}forward-admin-chat-single-message?to_user_id=$userId&message_id=$messageId';
  static String forwardGroupChat = '${baseApi}admin-group-chat-forward';

  static String blockSingleUser({required String type, required int userId}) =>
      '${baseApi}chat-user-block-action?type=$type&user_id=$userId';

  static String changeActiveStatus({required int statusKey}) =>
      '${baseApi}change-admin-chat-user-status?status=$statusKey';

  static String chatSetting =
      '${AppConfig.domainName}/api/chat/settings/permission';
  static String chatStatus = '${baseApi}single-user-chat-status';
  static String blockedChatUser = '${baseApi}blocked-chat-users';

  /// Payment Gateway Handler
  static String paymentHandler = '${baseApi}handle-payment-request';

  /// Language API
  static String languageList = '${baseApi}language-list';
  static String activeUserLanguageList = '${baseApi}user-language-list';

  static String updateLanguage({required langId}) =>
      '${baseApi}language-list?lang_id=$langId';

  /// Class & Language API
  static String zoomClassList = '${baseApi}zoom-class-meeting-list';
  static String zoomMeetingList = '${baseApi}zoom-meeting-list';
  static String jitsiClassList = '${baseApi}jitsi/virtual-class';
  static String jitsiMeetingList = '${baseApi}jitsi/meetings';
  static String jitsiSettings = '${baseApi}jitsi/settings';

  static String bigBlueButtonClassList = '${baseApi}bbb/virtual-class';
  static String bigBlueButtonMeetingList = '${baseApi}bbb/meetings';
  static String googleMeetClassList = '${baseApi}g-meet/virtual-class';
  static String googleMeetMeetingList = '${baseApi}g-meet/virtual-meeting';

  static String getJoinMeetingUrlApp({required String meetingID}) =>
      'zoomus://zoom.us/join?confno=$meetingID'; // android

  static String getJoinMeetingUrlWeb({required String meetingID}) =>
      'https://zoom.us/wc/$meetingID/join?prefer=1';

  /// Account Related api
  static String changePassword = '${baseApi}change-password';
  static String accountDelete = '${baseApi}user-delete';
  static String generalSettings = '${baseApi}general-settings';

  //////////////////////////.......................................///////////////////////////////////
  //////////////////////////.......................................///////////////////////////////////
  //////////////////////////..........PREVIOUS APP URLS................///////////////////////////////////
  //////////////////////////.......................................///////////////////////////////////
  //////////////////////////.......................................///////////////////////////////////
  //////////////////////////.......................................///////////////////////////////////
  static String getFeesUrl(dynamic id) {
    return '${baseApi}fees-collect-student-wise/$id';
  }

  static String getRoutineUrl(dynamic id) {
    return "${baseApi}student-class-routine/$id";
  }

  static String driverList = "${baseApi}driver-list";
  static String studentTransportList = "${baseApi}student-transport-report";

  static String getTeacherPhonePermission(dynamic mPerm) {
    return "${baseApi}privacy-permission/$mPerm";
  }

  static String getStudentIssuedBook(dynamic id) {
    return "${baseApi}student-library/$id";
  }

  static String getNoticeUrl(dynamic id) {
    return "${baseApi}student-noticeboard/$id";
  }

  static String getStudentTimeline(dynamic id) {
    return "${baseApi}student-timeline/$id";
  }

  static String getStudentClassExamName(var id) {
    return "${baseApi}exam-list/$id";
  }

  static String getStudentClsExamSchedule(var id, dynamic code) {
    return "${baseApi}exam-schedule/$id/$code";
  }

  static String getTeacherAttendance(dynamic id, dynamic month, dynamic year) {
    return "${baseApi}my-attendance/$id?month=$month&year=$year";
  }

  static String getStudentOnlineResult(dynamic typeId, dynamic recordId) {
    return "${baseApi}exam-result?exam_type_id=$typeId&record_id=$recordId";
  }

  static String getStudentByClass(dynamic mClass) {
    return "${baseApi}search-student?class=$mClass";
  }

  static String getStudentByName(
      String name, dynamic mClass, dynamic mSection) {
    return "${baseApi}search-student?name=$name&section=$mSection&class=$mClass";
  }

  static String getStudentByRoll(
      String roll, dynamic mClass, dynamic mSection) {
    return "${baseApi}search-student?roll_no=$roll&section=$mSection&class=$mClass";
  }

  static String getStudentByClassAndSection(dynamic mClass, dynamic mSection) {
    return "${baseApi}search-student?section=$mSection&class=$mClass";
  }

  static String getStudentBySubject(
      dynamic mClass, dynamic mSection, dynamic subject) {
    return "${baseApi}search-student?section=$mSection&class=$mClass&subject=$subject";
  }

  static String getAllStaff(dynamic id) {
    return "${baseApi}staff-list/$id";
  }

  static String getSectionById(dynamic id, dynamic classId) {
    return "${baseApi}teacher-section-list?id=$id&class=$classId";
  }

  static String getSubjectById(dynamic classId, dynamic sectionId) {
    return "${baseApi}class-section-subjectList?class=$classId&section=$sectionId";
  }

  static String getClassById(dynamic id) {
    return "${baseApi}teacher-class-list?id=$id";
  }

  static String getChildren(String id) {
    return "${baseApi}childInfo/$id";
  }

  static String getTeacherSubject(dynamic id) {
    return "${baseApi}subject/$id";
  }

  static String getTeacherMyRoutine(dynamic id) {
    return "${baseApi}my-routine/$id";
  }

  static String getRoutineByClassAndSection(
      dynamic id, dynamic mClass, dynamic mSection) {
    return "${baseApi}section-routine/$id/$mClass/$mSection";
  }

  static String getAllContent() {
    return "${baseApi}content-list";
  }

  static String deleteContent(dynamic id) {
    return "${baseApi}delete-content/$id";
  }

  static String about = "${baseApi}parent-about";

  static String getHomeWorkListUrl(dynamic id) {
    return "${baseApi}homework-list/$id";
  }

  static String getLeaveList(dynamic id) {
    return "${baseApi}staff-apply-list/$id";
  }

  static String getParentChildList(String id) {
    return "${baseApi}child-list/$id";
  }

  static String getMeeting({uid, param}) {
    return "$baseApi$param/user_id/$uid";
  }

  static String getMeetingUrl({mid, uid, param}) {
    return "$baseApi$param/meeting_id/$mid/user_id/$uid";
  }

  static String feesDataSend(String name, String description) {
    return "${baseApi}fees-group-store?name=$name&description=$description";
  }

  static String feesDataUpdate(String name, String description, dynamic id) {
    return "${baseApi}fees-group-update?name=$name&description=$description&id=$id";
  }

  static String addBook(
      String title,
      String categoryId,
      String bookNo,
      String isbn,
      String publisherName,
      String authorName,
      String subjectId,
      String reckNo,
      String quantity,
      String price,
      String details,
      String date,
      String userId,
      String schoolId) {
    return "${baseApi}save-book-data?book_title=$title&book_category_id=$categoryId&book_number=$bookNo&isbn_no=$isbn&publisher_name=$publisherName&author_name=$authorName&subject_id=$subjectId&rack_number=$reckNo&quantity=$quantity&book_price=$price&details=$details&post_date=$date&user_id=$userId&school_id=$schoolId";
  }

  static String adminAddBook = "${baseApi}save-book-data";

  static String addLibraryMember(
    String memberType,
    String memberUdId,
    String clsId,
    String secId,
    String studentId,
    String stuffId,
    String createdBy,
  ) {
    return "${baseApi}add-library-member?member_type=$memberType&member_ud_id=$memberUdId&class=$clsId&section=$secId&student=$studentId&staff=$stuffId&created_by=$createdBy";
  }

  static String addRoute(String title, String fare, String uid) {
    return "${baseApi}transport-route?title=$title&far=$fare&user_id=$uid";
  }

  static String transportRoute = '${baseApi}transport-route';

  static String addVehicle(String vehicleNo, String model, String driverId,
      String note, String year) {
    return "${baseApi}vehicle?vehicle_number=$vehicleNo&vehicle_model=$model&driver_id=$driverId&note=$note&year_made=$year";
  }

  static String vehicles = "${baseApi}vehicle";

  static String addDormitory(String name, String type, String dynamicake,
      String address, String description) {
    return "${baseApi}add-dormitory?dormitory_name=$name&type=$type&dynamicake=$dynamicake&address=$address&description=$description";
  }

  static String adminAddDormitory = "${baseApi}add-dormitory";

  static String notificationList = "${baseApi}all-notification-list";
  static String setToken(String id, String token) {
    return "${baseApi}set-fcm-token?id=$id&token=$token";
  }

  static String sentNotificationForAll(
      dynamic role, String title, String body) {
    return "${baseApi}flutter-group-token?id=$role&body=$body&title=$title";
  }

  static String sentNotificationByToken(String title, String body, String id) {
    return "${baseApi}flutter-notification-api?id=$id&body=$body&title=$title";
  }

  static String sentNotificationToSection(
      String title, String body, String classId, String sectionId) {
    return "${baseApi}homework-notification-api?body=$body&title=$title&class_id=$classId&section_id=$sectionId";
  }

  static String sendLeaveData(String applyDate, String leaveType,
      String leaveForm, String leaveTo, String id, String reason, String path) {
    return "${baseApi}staff-apply-leave?teacher_id=$id&reason=$reason&leave_type=$leaveType&leave_from=$leaveForm&leave_to=$leaveTo&apply_date=$applyDate&attach_file=$path";
  }

  static String setLeaveStatus(dynamic id, String status) {
    return "${baseApi}update-leave?id=$id&status=$status";
  }

  static String bookCategory = "${baseApi}book-category";
  static String subjectList = "${baseApi}library-subject";
  static String leaveType = "${baseApi}staff-leave-type";
  static String applyLeave = "${baseApi}staff-apply-leave";
  static String getEmail = "${baseApi}user-demo";
  static String getLibraryMemberCategory = "${baseApi}library-member-role";
  static String getStuffCategory = "${baseApi}staff-roles";

  // static String DRIVER_LIST = baseApi+"driver-list";
  // static String dormitoryRoomList = "${baseApi}room-list";
  static String dormitoryList = "${baseApi}dormitory-list";
  static String roomTypeList = "${baseApi}room-type-list";
  static String pendingLeave = "${baseApi}pending-leave";
  static String approvedLeave = "${baseApi}approved-leave";
  static String rejectedLeave = "${baseApi}reject-leave";

  //NEW APIs

  static String getMyNotifications(dynamic id) {
    return "${baseApi}myNotification/$id";
  }

  static String readMyNotifications(dynamic userID, notificationID) {
    return "${baseApi}viewNotification/$userID/$notificationID";
  }

  // static String readAllNotification(dynamic userID) {
  //   return "${baseApi}viewAllNotification/$userID";
  // }

  // static String changePassword(String currentPassword, String newPassword,
  //     String confirmPassword, String userID) {
  //   return "${baseApi}change-password?current_password=$currentPassword&new_password=$newPassword&confirm_password=$confirmPassword&id=$userID";
  // }

  static String childFeeBankPayment(
      String amount,
      dynamic classID,
      dynamic sectionID,
      String userID,
      dynamic feeTypeID,
      String paymentMode,
      String paymentDate,
      dynamic bankID) {
    return "${baseApi}child-bank-slip-store?amount=$amount&class_id=$classID&section_id=$sectionID&user_id=$userID&fees_type_id=$feeTypeID&payment_mode=$paymentMode&date=$paymentDate&bank_id=$bankID";
  }

  static String childFeeChequePayment(
    String amount,
    dynamic classID,
    dynamic sectionID,
    String userID,
    dynamic feeTypeID,
    String paymentMode,
    String paymentDate,
  ) {
    return "${baseApi}child-bank-slip-store?amount=$amount&class_id=$classID&section_id=$sectionID&user_id=$userID&fees_type_id=$feeTypeID&payment_mode=$paymentMode&date=$paymentDate";
  }

  static String bankList = "${baseApi}banks";

  static String userLeaveType(id) {
    return "${baseApi}my-leave-type/$id";
  }

  static String userApplyLeaveStore = '${baseApi}student-apply-leave-store';

  static String approvedLeaves(id) {
    return "${baseApi}approve-leave/$id";
  }

  static String pendingLeaves(id, purpose) {
    return "${baseApi}pending-leave/$id?purpose=$purpose";
  }

  static String rejectedLeaves(id) {
    return "${baseApi}reject-leave/$id";
  }

  static String homeworkEvaluationList(classId, sectionId, homeworkId) {
    return "${baseApi}evaluation-homework/$classId/$sectionId/$homeworkId";
  }

  static String evaluateHomework = "${baseApi}evaluate-homework";

  static String assignVehicle = "${baseApi}assign-vehicle";

  static String paymentMethods(schoolId) {
    return "${baseApi}school/$schoolId/payment-method";
  }

  static String feePayment = "${baseApi}student-fees-payment";

  static String studentFeePayment(String stuId, dynamic feesType, String amount,
      String paidBy, String paymentMethod) {
    return "${baseApi}student-fees-payment?student_id=$stuId&fees_type_id=$feesType&amount=$amount&paid_by=$paidBy&payment_mode=$paymentMethod";
  }

  static String paymentDataSave = "${baseApi}payment-data-save";

  // static String paymentSuccessCallback = baseApi + "payment-success-callback";

  static String paymentSuccessCallback(status, paymentRef, amount) {
    return "${baseApi}payment-success-callback?status=$status&payment_ref=$paymentRef&amount=$amount";
  }

  static String updateStudent = "${baseApi}update-student";

  static String notice(var schoolId) {
    return "${baseApi}school/$schoolId/notice-list";
  }

  static String getStudentRoutineReport = "${baseApi}exam-routine-report";

  static String getDayWiseRoutine = "${baseApi}day-wise-class-routine";

  //* Chats /

  static String getChatOpen = "${baseApi}chat/open";

  static String chatInvitaionOpen = "${baseApi}chat/invitation/user/open";

  static String searchChatUser = "${baseApi}chat/user/search";

  static String getChatStatus = "${baseApi}chat/user/show";

  static String changeChatStatus = "${baseApi}chat/user/status";

  static String submitChatText = "${baseApi}chat/send/user";

  static String newChatMsgCheck = "${baseApi}chat/message/check";

  static String chatMsgLoadMore = "${baseApi}chat/message/load/more";

  static String chatSingleMsgDelete = "${baseApi}chat/delete";

  static String chatSingleForwardMessage = "${baseApi}chat/send/forward";

  static String chatFiles = "${baseApi}chat/files";

  static String chatPermissionGet = "${baseApi}chat/settings/permission";

  static String chatGroupCreate = "${baseApi}chat/group/create";

  static String chatGroupDelete = "${baseApi}chat/group/delete";

  static String chatGroupOpen = "${baseApi}chat/group/open";

  static String chatGroupMsgLoadMore = "${baseApi}chat/group/message/load/more";

  static String chatGroupMsgCheck = "${baseApi}chat/group/message/check";

  static String chatGroupSetReadOnly = "${baseApi}chat/group/read-only";

  static String chatGroupAssignRole = "${baseApi}chat/group/assign";

  static String groupFileDownload = "${baseApi}chat/group/file/download";

  static String groupRemovePeople = "${baseApi}chat/group/remove/people";

  static String groupAddPeople = "${baseApi}chat/group/add/people";

  static String submitChatGroupText = "${baseApi}chat/group/open/send";

  static String chatGroupLeave = "${baseApi}chat/group/leave";

  static String chatGroupMessageDelete = "${baseApi}chat/group/message/delete";

  static String chatGroupForwardMessage = "${baseApi}chat/send/group/forward";

  static String chatUserBlockAction = "${baseApi}chat/user/action";

  static String chatGetBlockedUsers = "${baseApi}chat/users/blocked";

  static String getStudentHomeWork(int recordId) {
    return "${baseApi}student-homework?record_id=$recordId";
  }

  static String getStudentHomeWorkUploadFiles =
      "${baseApi}upload-homework-content";

  static String studentUploadHomework = '${baseApi}student-upload-homework';

  static String getStudentAssignment(dynamic userId, int recordId) {
    return "${baseApi}studentAssignment/$userId/$recordId";
  }

  static String getStudentSyllabus(dynamic id, int recordId) {
    return "${baseApi}studentSyllabus/$id/$recordId";
  }

  static String getSubjectsUrl(dynamic userId, int recordId) {
    return "${baseApi}studentSubject/$userId/$recordId";
  }

  static String getStudentTeacherUrl(
      dynamic schoolId, dynamic id, int recordId) {
    return "${baseApi}school/$schoolId/studentTeacher/$id/$recordId";
  }

  static String getStudentClassExamResult(
      var id, dynamic examId, int recordId) {
    return "${baseApi}exam-result/$id/$examId/$recordId";
  }

  static String getStudentOnlineActiveExamName(var id, int recordId) {
    return "${baseApi}choose-exam/$id/$recordId";
  }

  static String getStudentOnlineActiveExamResult(
      var id, var examId, int recordId) {
    return "${baseApi}online-exam-result/$id/$examId/$recordId";
  }

  static String getStudentAttendence(
      var id, int recordId, dynamic month, dynamic year) {
    return "${baseApi}student-my-attendance/$id/$recordId?month=$month&year=$year";
  }

  static String getSubjectAttendence(
      var id, int recordId, dynamic month, dynamic year, dynamic subject) {
    return "${baseApi}student-my-subject-attendance/$id/$recordId?month=$month&year=$year&subject=$subject";
  }

  static String attendanceCheck(String date, dynamic mClass, dynamic mSection) {
    return "${baseApi}student-attendance-check?date=$date&class=$mClass&section=$mSection";
  }

  static String subjectattendanceCheck(
      String date, dynamic mClass, dynamic mSection, dynamic mSubject) {
    return "${baseApi}student-subject-attendance-check?date=$date&class=$mClass&section=$mSection&subject=$mSubject";
  }

  static String attendanceDefaultSent =
      '${baseApi}student-attendance-store-all';

  static String subjectattendanceDefaultSent =
      '${baseApi}student-subject-attendance-store';

  static String attendanceDataSend(String id, String atten, String date,
      dynamic mClass, dynamic mSection, int recordId) {
    return "${baseApi}student-attendance-store-second?id=$id&attendance=$atten&date=$date&class=$mClass&section=$mSection&record_id=$recordId";
  }

  static String routineView(userId, role, {bool? mine, int? recordId}) {
    if (role == "student") {
      return "${baseApi}class-routine-view/$userId/$recordId";
    } else {
      if (mine!) {
        return "${baseApi}teacher-routine-view/$userId";
      } else {
        return "${baseApi}student-routine-view/$userId";
      }
    }
  }

  // static String generalSettings = "${baseApi}general-settings";

  static String feesRecordList = "${baseApi}student-record-fees-list";

  static String studentFeesAddPayment(int invoiceId) {
    return "${baseApi}student-fees-payment/$invoiceId";
  }

  static String studentPaymentStore = "${baseApi}student-fees-payment-store";

  static String studentPaymentSuccessCallback =
      "${baseApi}online-payment-sucess";

  static String adminFeeList = "${baseApi}fees-group";

  static String adminFeesTypeList = "${baseApi}fees-type";

  static String adminFeesGroupUpdate = "${baseApi}fees-group-update";
  static String adminFeesGroupStore = "${baseApi}fees-group-store";
  static String adminFeesGroupDelete = "${baseApi}fees-group-delete";

  static String adminFeesTypeUpdate = "${baseApi}fees-type-update";
  static String adminFeesTypeStore = "${baseApi}fees-type-store";
  static String adminFeesTypeDelete = "${baseApi}fees-type-delete";

  static String adminFeesInvoiceList = "${baseApi}fees-invoice-list";

  static String feesInvoiceView(int invoiceId) {
    return "${baseApi}fees-invoice-view/$invoiceId/view";
  }

  static String adminFeesBankPaymentList = "${baseApi}bank-payment";
  static String adminFeesBankPaymentSearch = "${baseApi}search-bank-payment";

  static String adminFeesInvoiceDelete = "${baseApi}fees-invoice-delete";

  static String adminApproveBankPayment = "${baseApi}approve-bank-payment";
  static String adminRejectBankPayment = "${baseApi}reject-bank-payment";

  static String adminFeesViewPayment = "${baseApi}fees-view-payment";

  //Fees Reports
  static String adminFeesDueSearch = "${baseApi}search-due-fees";

  static String adminFeesFineSearch = "${baseApi}fine-search";

  static String adminFeesPaymentSearch = "${baseApi}payment-search";

  static String adminFeesBalanceSearch = "${baseApi}balance-search";

  static String adminFeesWaiverSearch = "${baseApi}waiver-search";

  static String adminFeesAddPayment = "${baseApi}add-fees-payment";

  static String adminFeesAddPaymentStore = "${baseApi}fees-payment-store";
  static String studentFeesAddPaymentStore =
      "${baseApi}student-fees-payment-stores";
  static String studentAddWallet = "${baseApi}add-wallet-amount";

  //EXAM MODULE

  static String getOnlineExamModule(var id, int recordId, schoolId) {
    return "${baseApi}onlineexam/student-online-exam/$id/$recordId/$schoolId";
  }

  static String takeOnlineExamModule(
      int onlineExamId, int recordId, int schoolId) {
    return "${baseApi}onlineexam/take-online-exam/$onlineExamId/$recordId/$schoolId";
  }

  static String studentSubmitAnswerMulti =
      "${baseApi}onlineexam/student-submit-answer";

  static String studentSubmitAnswerSubjective =
      "${baseApi}onlineexam/student-done-online-exam-fill_in_blanks";

  static String studentSubmitAnswerFinal =
      "${baseApi}onlineexam/student-done-online-exam";

  static String getOnlineExamResultModule(dynamic studentId, int recordId) {
    return "${baseApi}onlineexam/online-exam-result/$studentId/$recordId";
  }

  static String chatBroadCastAuth = "${baseApi}broadcasting/auth";

  // static String chatBroadCastAuth = "${baseApi}broadcasting/auth";

  //Lesson Plan
  static String studentLessonPlan = "${baseApi}student-lesson-plan";

  static String studentLessonPlanByDate =
      "${baseApi}student-lesson-plan-by-date";

  static String studentLessonPreviousWeek =
      "${baseApi}student-lesson-plan-previous-week";

  static String studentLessonNextWeek =
      "${baseApi}student-lesson-plan-next-week";

  //Wallet
  static String studentWallet = "${baseApi}my-wallet";
  static String addToWallet = "${baseApi}add-wallet";
  static String confirmWalletPayment = "${baseApi}confirm-wallet-payment";

  // Virtual Class
  static String getVirtualClass(int recordId, String method) {
    return "$baseApi$method/virtual-class/$recordId";
  }

  static String getVirtualMeeting(String method) {
    return "$baseApi$method/meetings";
  }

  static String bbbMeetingJoin(String meetingId, String method) {
    return "$baseApi$method/meeting-join/$meetingId";
  }
}
