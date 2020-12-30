class UserLogin {
  String accessToken;
  String tokenType;
  int expiresIn;
  String issued;
  String expires;

  UserLogin(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.issued,
      this.expires});

  UserLogin.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    issued = json['.issued'];
    expires = json['.expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['.issued'] = this.issued;
    data['.expires'] = this.expires;
    return data;
  }
}