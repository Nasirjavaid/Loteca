class APIConstants {
  static final String baseUrl =
      "http://phpstack-526382-1675862.cloudwaysapps.com/api";

  static final String userLoginEndPoint = baseUrl + "/login?";
  static final String userSignUpEndPoint = baseUrl + "/register";
  static final String mainRoundEndPoint = baseUrl + "/mainRound";
  static final String submitMainRoundEndPoint = baseUrl + "/submitResult";
  static final String lastRoundResultEndPoint = baseUrl + "/lastRoundResult";
  static final String leaderBoardEndPoint = baseUrl + "/leaderBoard";
  static final String leaguesEndPoint = baseUrl + "/leagues";
  static final String agentsEndPoint = baseUrl + "/agents";
  static final String createMyLeagueEndPoint = baseUrl + "/myleague";
  static final String userProfileUpdateEndPoint = baseUrl + "/updateProfile";
  static final String agentDashboardEndPoint = baseUrl + "/agentDashBoard";
  static final String validateUserToSendCoinEndPoint = baseUrl + "/userRecord";
  static final String sendCoinToUserEndPoint = baseUrl + "/sendCoins";
  static final String getSingleActiverLeagueEndPoint = baseUrl + "/activeLeague";




  static final String userImagePlaceHolder =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/768px-Circle-icons-profile.svg.png";
}
