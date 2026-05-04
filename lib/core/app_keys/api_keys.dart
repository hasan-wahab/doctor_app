class ApiKeys {
  ApiKeys._();
  // old for testing
  static String baseUrl = 'https://alitherapy.neonweb.tech/api';
  // new url
  // static String baseUrl = 'http://cms.dralitherapy.com/api';

  /// Login Api Key
  static String loginKey = '$baseUrl/patient/login';

  /// Sign Up Api Key
  static String updateProfileKey =
      '$baseUrl/patient/update-profile/?t=${DateTime.now().millisecondsSinceEpoch}';

  /// Get Patient Api Key
  static String getPatientKey = '$baseUrl/patient/apipatients';

  /// Logout Api Key
  static String logoutKey = '$baseUrl/patient/logout';

  /// Update Profile Api Key
  static String updateProfileImageKey = "$baseUrl/patient/profile-picture";

  /// History Tracker Key
  static String historyTrackerKey = "$baseUrl/patient/history";

  /// Consultant Assessment Key
  static String consultantAssessmentKey = "$baseUrl/patient/consultant";

  /// Session detail key
  static String sessionDetailKey = "$baseUrl/patient/therapist";

  /// All visits key
  static String allVisitsKey = "$baseUrl/patient/visits/all";

  /// All Consultant key

  static String allConsultantKey = "$baseUrl/patient/consultant/all";

  /// All Therapist key

  static String allTherapistKey = "$baseUrl/patient/therapist/all";

  /// All HistoryTaker key

  static String allHistoryTakerKey = "$baseUrl/patient/histrytaker/all";
}
