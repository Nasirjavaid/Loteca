class SendCoin {
  int status;
  String response;
  String message;

  SendCoin({this.status, this.response, this.message});

  SendCoin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    return data;
  }
}