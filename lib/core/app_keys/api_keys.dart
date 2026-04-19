class ApiKeys {
  ApiKeys._();
  // old for testing
  static String baseUrl = 'https://alitherapy.neonweb.tech/api';
  // new url
  // static String baseUrl = 'http://cms.dralitherapy.com/api';

  /// Login Api Key
  static String loginKey = '$baseUrl/patient/login';

  /// Sign Up Api Key
  static String updateProfileKey = '$baseUrl/patient/update-profile';

  /// Get Patient Api Key
 static String getPatientKey = '$baseUrl/patient/apipatients';

 /// Logout Api Key
 static String logoutKey = '$baseUrl/patient/logout';
}
