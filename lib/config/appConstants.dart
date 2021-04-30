class APIConstants {
  static final String baseUrl =
      "https://phpstack-526382-1675862.cloudwaysapps.com/api";

  static final String userLoginEndPoint = baseUrl + "/login?";
  static final String userSignUpEndPoint = baseUrl + "/register";
  static final String mainRoundEndPoint = baseUrl + "/mainRound";
  static final String mainRoundForAgentEndPoint = baseUrl + "/mainRoundForAgent";
  static final String submitbetEndPoint = baseUrl + "/submitBet";
  static final String submitMainRoundByAgentEndPoint = baseUrl + "/submitResultByAgent";
  static final String lastRoundResultEndPoint = baseUrl + "/lastResultsList";
  static final String leaderBoardEndPoint = baseUrl + "/leaderBoard";
  static final String leaguesEndPoint = baseUrl + "/leagues";
  static final String agentsEndPoint = baseUrl + "/agents";
  static final String createMyLeagueEndPoint = baseUrl + "/myleague";
  static final String userProfileUpdateEndPoint = "/updateProfile";
  static final String agentDashboardEndPoint = baseUrl + "/agentDashBoard";
  static final String validateUserToSendCoinEndPoint = baseUrl + "/userRecord";
  static final String sendCoinToUserEndPoint = baseUrl + "/sendCoins";
  static final String getSingleActiverLeagueEndPoint = baseUrl + "/activeLeague";
  static final String getClosedLeagueEndPoint = baseUrl + "/closedLeague";
  static final String getParticipatedLeaguesEndPoint = baseUrl + "/participatedleagues";
  static final String getParticipatedleagueDetailsEndPoint = baseUrl + "/leagueDetails";
  static final String feedBackEndPoint = baseUrl + "/feedback";
  static final String confirmEmailEndPoint = baseUrl + "/confirmEmail";
  static final String resendCodeEndPoint = baseUrl + "/resendCode";
  static final String resetPasswordCodeEndPoint = baseUrl + "/resetPasswordCode";
  static final String updatePasswordCodeEndPoint = baseUrl + "/updatePassword";
  static final String coinsRecordEndPoint = baseUrl + "/coins_record";
  static final String userCoinsRecordEndPoint = baseUrl + "/user_coins_record";
  static final String userDashboardEndPoint = baseUrl + "/userDashBoard";
  static final String roundDetailEndPoint = baseUrl + "/resultScreenDetails";
  static final String userBetsRecordEndPoint = baseUrl + "/user_bets_record";
  static final String coinSentTicketDetailEndPoint = baseUrl + "/coin_sent_ticket_detail";
  static final String betTicketDetailEndPoint = baseUrl + "/bet_ticket_detail";

// base url to load Game flags
  static final String baseUrlToloadGameFlags=
      "https://phpstack-526382-1675862.cloudwaysapps.com/";


  static final String userImagePlaceHolder =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/768px-Circle-icons-profile.svg.png";
}
