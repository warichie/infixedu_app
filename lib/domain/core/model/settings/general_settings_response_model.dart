class GeneralSettingsResponseModel {
  bool? success;
  Data? data;
  String? message;

  GeneralSettingsResponseModel({this.success, this.data, this.message});

  GeneralSettingsResponseModel.fromJson(Map<String, dynamic> json) {
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
  SystemSettings? systemSettings;

  Data({this.systemSettings});

  Data.fromJson(Map<String, dynamic> json) {
    systemSettings = json['system_settings'] != null
        ? SystemSettings.fromJson(json['system_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (systemSettings != null) {
      data['system_settings'] = systemSettings!.toJson();
    }
    return data;
  }
}

class SystemSettings {
  int? id;
  String? schoolName;
  String? siteTitle;
  String? schoolCode;
  String? address;
  String? phone;
  String? email;
  String? fileSize;
  String? currency;
  String? currencySymbol;
  String? currencyFormat;
  int? promotionSetting;
  String? logo;
  String? favicon;
  String? systemVersion;
  int? activeStatus;
  String? currencyCode;
  String? languageName;
  String? sessionYear;
  String? systemPurchaseCode;
  String? systemActivatedDate;
  String? lastUpdate;
  String? envatoUser;
  String? envatoItemId;
  String? systemDomain;
  String? copyrightText;
  int? apiUrl;
  int? websiteBtn;
  int? dashboardBtn;
  int? reportBtn;
  int? styleBtn;
  int? ltlRtlBtn;
  int? langBtn;
  String? websiteUrl;
  int? ttlRtl;
  int? phoneNumberPrivacy;
  DateTime? createdAt;
  String? updatedAt;
  int? weekStartId;
  int? timeZoneId;
  int? attendanceLayout;
  int? sessionId;
  int? languageId;
  int? dateFormatId;
  int? ssPageLoad;
  int? subTopicEnable;
  int? schoolId;
  String? softwareVersion;
  String? emailDriver;
  String? fcmKey;
  int? multipleRoll;
  int? lesson;
  int? chat;
  int? feesCollection;
  int? incomeHeadId;
  int? infixBiometrics;
  int? resultReports;
  int? templateSettings;
  int? menuManage;
  int? rolePermission;
  int? razorPay;
  int? saas;
  int? studentAbsentNotification;
  int? parentRegistration;
  int? zoom;
  int? bBB;
  int? videoWatch;
  int? jitsi;
  int? onlineExam;
  int? saasRolePermission;
  int? bulkPrint;
  int? himalayaSms;
  int? xenditPayment;
  int? wallet;
  int? lms;
  int? examPlan;
  int? university;
  int? gmeet;
  int? khaltiPayment;
  int? raudhahpay;
  int? appSlider;
  int? behaviourRecords;
  int? downloadCenter;
  int? aiContent;
  int? whatsappSupport;
  int? inAppLiveClass;
  int? feesStatus;
  int? lmsCheckout;
  int? academicId;
  int? isComment;
  int? autoApprove;
  int? blogSearch;
  int? recentBlog;
  int? unAcademicId;
  int? directFeesAssign;
  int? withGuardian;
  String? resultType;
  int? preloaderStatus;
  int? preloaderStyle;
  int? preloaderType;
  String? preloaderImage;
  int? dueFeesLogin;
  int? twoFactor;
  String? activeTheme;
  CurrencyDetail? currencyDetail;

  SystemSettings(
      {this.id,
      this.schoolName,
      this.siteTitle,
      this.schoolCode,
      this.address,
      this.phone,
      this.email,
      this.fileSize,
      this.currency,
      this.currencySymbol,
      this.currencyFormat,
      this.promotionSetting,
      this.logo,
      this.favicon,
      this.systemVersion,
      this.activeStatus,
      this.currencyCode,
      this.languageName,
      this.sessionYear,
      this.systemPurchaseCode,
      this.systemActivatedDate,
      this.lastUpdate,
      this.envatoUser,
      this.envatoItemId,
      this.systemDomain,
      this.copyrightText,
      this.apiUrl,
      this.websiteBtn,
      this.dashboardBtn,
      this.reportBtn,
      this.styleBtn,
      this.ltlRtlBtn,
      this.langBtn,
      this.websiteUrl,
      this.ttlRtl,
      this.phoneNumberPrivacy,
      this.createdAt,
      this.updatedAt,
      this.weekStartId,
      this.timeZoneId,
      this.attendanceLayout,
      this.sessionId,
      this.languageId,
      this.dateFormatId,
      this.ssPageLoad,
      this.subTopicEnable,
      this.schoolId,
      this.softwareVersion,
      this.emailDriver,
      this.fcmKey,
      this.multipleRoll,
      this.lesson,
      this.chat,
      this.feesCollection,
      this.incomeHeadId,
      this.infixBiometrics,
      this.resultReports,
      this.templateSettings,
      this.menuManage,
      this.rolePermission,
      this.razorPay,
      this.saas,
      this.studentAbsentNotification,
      this.parentRegistration,
      this.zoom,
      this.bBB,
      this.videoWatch,
      this.jitsi,
      this.onlineExam,
      this.saasRolePermission,
      this.bulkPrint,
      this.himalayaSms,
      this.xenditPayment,
      this.wallet,
      this.lms,
      this.examPlan,
      this.university,
      this.gmeet,
      this.khaltiPayment,
      this.raudhahpay,
      this.appSlider,
      this.behaviourRecords,
      this.downloadCenter,
      this.aiContent,
      this.whatsappSupport,
      this.inAppLiveClass,
      this.feesStatus,
      this.lmsCheckout,
      this.academicId,
      this.isComment,
      this.autoApprove,
      this.blogSearch,
      this.recentBlog,
      this.unAcademicId,
      this.directFeesAssign,
      this.withGuardian,
      this.resultType,
      this.preloaderStatus,
      this.preloaderStyle,
      this.preloaderType,
      this.preloaderImage,
      this.dueFeesLogin,
      this.twoFactor,
      this.activeTheme,
      this.currencyDetail});

  SystemSettings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolName = json['school_name'];
    siteTitle = json['site_title'];
    schoolCode = json['school_code'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    fileSize = json['file_size'];
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    currencyFormat = json['currency_format'];
    promotionSetting = json['promotionSetting'];
    logo = json['logo'];
    favicon = json['favicon'];
    systemVersion = json['system_version'];
    activeStatus = json['active_status'];
    currencyCode = json['currency_code'];
    languageName = json['language_name'];
    sessionYear = json['session_year'];
    systemPurchaseCode = json['system_purchase_code'];
    systemActivatedDate = json['system_activated_date'];
    lastUpdate = json['last_update'];
    envatoUser = json['envato_user'];
    envatoItemId = json['envato_item_id'];
    systemDomain = json['system_domain'];
    copyrightText = json['copyright_text'];
    apiUrl = json['api_url'];
    websiteBtn = json['website_btn'];
    dashboardBtn = json['dashboard_btn'];
    reportBtn = json['report_btn'];
    styleBtn = json['style_btn'];
    ltlRtlBtn = json['ltl_rtl_btn'];
    langBtn = json['lang_btn'];
    websiteUrl = json['website_url'];
    ttlRtl = json['ttl_rtl'];
    phoneNumberPrivacy = json['phone_number_privacy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    weekStartId = json['week_start_id'];
    timeZoneId = json['time_zone_id'];
    attendanceLayout = json['attendance_layout'];
    sessionId = json['session_id'];
    languageId = json['language_id'];
    dateFormatId = json['date_format_id'];
    ssPageLoad = json['ss_page_load'];
    subTopicEnable = json['sub_topic_enable'];
    schoolId = json['school_id'];
    softwareVersion = json['software_version'];
    emailDriver = json['email_driver'];
    fcmKey = json['fcm_key'];
    multipleRoll = json['multiple_roll'];
    lesson = json['Lesson'] == true ? 1 : 0;
    chat = json['Chat'] == true ? 1 : 0;
    feesCollection = json['FeesCollection'];
    incomeHeadId = json['income_head_id'];
    infixBiometrics = json['InfixBiometrics'];
    resultReports = json['ResultReports'];
    templateSettings = json['TemplateSettings'];
    menuManage = json['MenuManage'];
    rolePermission = json['RolePermission'];
    razorPay = json['RazorPay'] == true ? 1 : 0;
    saas = json['Saas'] == true ? 1 : 0;
    studentAbsentNotification = json['StudentAbsentNotification'];
    parentRegistration = json['ParentRegistration'];
    zoom = json['Zoom'] == true ? 1 : 0;
    bBB = json['BBB'] == true ? 1 : 0;
    videoWatch = json['VideoWatch'];
    jitsi = json['Jitsi'] == true ? 1 : 0;
    onlineExam = json['OnlineExam'] == true ? 1 : 0;
    saasRolePermission = json['SaasRolePermission'];
    bulkPrint = json['BulkPrint'];
    himalayaSms = json['HimalayaSms'];
    xenditPayment = json['XenditPayment'] == true ? 1 : 0;
    wallet = json['Wallet'] == true ? 1 : 0;
    lms = json['Lms'];
    examPlan = json['ExamPlan'];
    university = json['University'];
    gmeet = json['Gmeet'];
    khaltiPayment = json['KhaltiPayment'] == true ? 1 : 0;
    raudhahpay = json['Raudhahpay'] == true ? 1 : 0;
    appSlider = json['AppSlider'] == true ? 1 : 0;
    behaviourRecords = json['BehaviourRecords'];
    downloadCenter = json['DownloadCenter'];
    aiContent = json['AiContent'];
    whatsappSupport = json['WhatsappSupport'];
    inAppLiveClass = 1;
    feesStatus = json['fees_status'];
    lmsCheckout = json['lms_checkout'];
    academicId = json['academic_id'];
    isComment = json['is_comment'];
    autoApprove = json['auto_approve'];
    blogSearch = json['blog_search'];
    recentBlog = json['recent_blog'];
    unAcademicId = json['un_academic_id'];
    directFeesAssign = json['direct_fees_assign'];
    withGuardian = json['with_guardian'];
    resultType = json['result_type'];
    preloaderStatus = json['preloader_status'];
    preloaderStyle = json['preloader_style'];
    preloaderType = json['preloader_type'];
    preloaderImage = json['preloader_image'];
    dueFeesLogin = json['due_fees_login'];
    twoFactor = json['two_factor'];
    activeTheme = json['active_theme'];
    currencyDetail = json['currency_detail'] != null
        ? CurrencyDetail.fromJson(json['currency_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['school_name'] = schoolName;
    data['site_title'] = siteTitle;
    data['school_code'] = schoolCode;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['file_size'] = fileSize;
    data['currency'] = currency;
    data['currency_symbol'] = currencySymbol;
    data['currency_format'] = currencyFormat;
    data['promotionSetting'] = promotionSetting;
    data['logo'] = logo;
    data['favicon'] = favicon;
    data['system_version'] = systemVersion;
    data['active_status'] = activeStatus;
    data['currency_code'] = currencyCode;
    data['language_name'] = languageName;
    data['session_year'] = sessionYear;
    data['system_purchase_code'] = systemPurchaseCode;
    data['system_activated_date'] = systemActivatedDate;
    data['last_update'] = lastUpdate;
    data['envato_user'] = envatoUser;
    data['envato_item_id'] = envatoItemId;
    data['system_domain'] = systemDomain;
    data['copyright_text'] = copyrightText;
    data['api_url'] = apiUrl;
    data['website_btn'] = websiteBtn;
    data['dashboard_btn'] = dashboardBtn;
    data['report_btn'] = reportBtn;
    data['style_btn'] = styleBtn;
    data['ltl_rtl_btn'] = ltlRtlBtn;
    data['lang_btn'] = langBtn;
    data['website_url'] = websiteUrl;
    data['ttl_rtl'] = ttlRtl;
    data['phone_number_privacy'] = phoneNumberPrivacy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['week_start_id'] = weekStartId;
    data['time_zone_id'] = timeZoneId;
    data['attendance_layout'] = attendanceLayout;
    data['session_id'] = sessionId;
    data['language_id'] = languageId;
    data['date_format_id'] = dateFormatId;
    data['ss_page_load'] = ssPageLoad;
    data['sub_topic_enable'] = subTopicEnable;
    data['school_id'] = schoolId;
    data['software_version'] = softwareVersion;
    data['email_driver'] = emailDriver;
    data['fcm_key'] = fcmKey;
    data['multiple_roll'] = multipleRoll;
    data['Lesson'] = lesson;
    data['Chat'] = chat;
    data['FeesCollection'] = feesCollection;
    data['income_head_id'] = incomeHeadId;
    data['InfixBiometrics'] = infixBiometrics;
    data['ResultReports'] = resultReports;
    data['TemplateSettings'] = templateSettings;
    data['MenuManage'] = menuManage;
    data['RolePermission'] = rolePermission;
    data['RazorPay'] = razorPay;
    data['Saas'] = saas;
    data['StudentAbsentNotification'] = studentAbsentNotification;
    data['ParentRegistration'] = parentRegistration;
    data['Zoom'] = zoom;
    data['BBB'] = bBB;
    data['VideoWatch'] = videoWatch;
    data['Jitsi'] = jitsi;
    data['OnlineExam'] = onlineExam;
    data['SaasRolePermission'] = saasRolePermission;
    data['BulkPrint'] = bulkPrint;
    data['HimalayaSms'] = himalayaSms;
    data['XenditPayment'] = xenditPayment;
    data['Wallet'] = wallet;
    data['Lms'] = lms;
    data['ExamPlan'] = examPlan;
    data['University'] = university;
    data['Gmeet'] = gmeet;
    data['KhaltiPayment'] = khaltiPayment;
    data['Raudhahpay'] = raudhahpay;
    data['AppSlider'] = appSlider;
    data['BehaviourRecords'] = behaviourRecords;
    data['DownloadCenter'] = downloadCenter;
    data['AiContent'] = aiContent;
    data['WhatsappSupport'] = whatsappSupport;
    data['InAppLiveClass'] = inAppLiveClass;
    data['fees_status'] = feesStatus;
    data['lms_checkout'] = lmsCheckout;
    data['academic_id'] = academicId;
    data['is_comment'] = isComment;
    data['auto_approve'] = autoApprove;
    data['blog_search'] = blogSearch;
    data['recent_blog'] = recentBlog;
    data['un_academic_id'] = unAcademicId;
    data['direct_fees_assign'] = directFeesAssign;
    data['with_guardian'] = withGuardian;
    data['result_type'] = resultType;
    data['preloader_status'] = preloaderStatus;
    data['preloader_style'] = preloaderStyle;
    data['preloader_type'] = preloaderType;
    data['preloader_image'] = preloaderImage;
    data['due_fees_login'] = dueFeesLogin;
    data['two_factor'] = twoFactor;
    data['active_theme'] = activeTheme;
    if (currencyDetail != null) {
      data['currency_detail'] = currencyDetail!.toJson();
    }
    return data;
  }
}

class CurrencyDetail {
  int? id;
  String? name;
  String? code;
  String? symbol;
  String? createdAt;
  String? updatedAt;
  String? currencyType;
  String? currencyPosition;
  int? space;
  int? decimalDigit;
  String? decimalSeparator;
  String? thousandSeparator;
  int? schoolId;
  int? academicId;

  CurrencyDetail(
      {this.id,
      this.name,
      this.code,
      this.symbol,
      this.createdAt,
      this.updatedAt,
      this.currencyType,
      this.currencyPosition,
      this.space,
      this.decimalDigit,
      this.decimalSeparator,
      this.thousandSeparator,
      this.schoolId,
      this.academicId});

  CurrencyDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currencyType = json['currency_type'];
    currencyPosition = json['currency_position'];
    space = json['space'];
    decimalDigit = json['decimal_digit'];
    decimalSeparator = json['decimal_separator'];
    thousandSeparator = json['thousand_separator'];
    schoolId = json['school_id'];
    academicId = json['academic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['symbol'] = symbol;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['currency_type'] = currencyType;
    data['currency_position'] = currencyPosition;
    data['space'] = space;
    data['decimal_digit'] = decimalDigit;
    data['decimal_separator'] = decimalSeparator;
    data['thousand_separator'] = thousandSeparator;
    data['school_id'] = schoolId;
    data['academic_id'] = academicId;
    return data;
  }
}
