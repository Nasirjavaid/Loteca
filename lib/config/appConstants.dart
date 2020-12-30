class APIConstants {
  static final String baseUrl = "http://192.168.0.81/AuthWebApi/";
  static final String sendMessageToPatientWithFnameLnameAndDOB =
      baseUrl + "CheckPatient?";
  static final String verifyMessageAndGetPatientRecordsEndPoint =
      baseUrl + "Results/";
  static final String userLoginEndPoint = baseUrl + "Token";
  static final String userTokenValidationEndPoint =
      baseUrl + "AuthWebApi/api/Values/5";
}
