class UserBetRecord {
  int status;
  String response;
  String message;
  List<Records> records;

  UserBetRecord({this.status, this.response, this.message, this.records});

  UserBetRecord.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  int recordId;
  String userName;
  String userEmail;
  String userPhone;
  String userWhatsapp;
  String image;
  String coinsUsed;
  String betDate;

  Records(
      {this.recordId,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.userWhatsapp,
      this.image,
      this.coinsUsed,
      this.betDate});

  Records.fromJson(Map<String, dynamic> json) {
    recordId = json['record_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userWhatsapp = json['user_whatsapp'];
    image = json['image'];
    coinsUsed = json['coins_used'];
    betDate = json['bet_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['record_id'] = this.recordId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['user_whatsapp'] = this.userWhatsapp;
    data['image'] = this.image;
    data['coins_used'] = this.coinsUsed;
    data['bet_date'] = this.betDate;
    return data;
  }
}