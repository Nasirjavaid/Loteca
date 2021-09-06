class PasswordRecovery {
  int status;
  String response;
  String message;
  String code;

  PasswordRecovery({this.status, this.response, this.message, this.code});

  PasswordRecovery.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    code = json['code'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    data['code'] = this.code;
   
    return data;
  }
}