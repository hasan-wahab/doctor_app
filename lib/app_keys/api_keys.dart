class ApiKeys {
  ApiKeys._();
  // old static String baseUrl = 'https://alitherapy.neonweb.tech/api';
  static String baseUrl = 'http://cms.dralitherapy.com/api';

  /// Login Api Key
  static String loginKey = '$baseUrl/patient/login';

  /// Sign Up Api Key
  static String updateProfileKey = '$baseUrl/patient/update-profile';
}
