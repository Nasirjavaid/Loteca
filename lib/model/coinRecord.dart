class CoinRecord {
  int status;
  String response;
  String message;
  List<Records> records;

  CoinRecord({this.status, this.response, this.message, this.records});

  CoinRecord.fromJson(Map<String, dynamic> json) {
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
  String userName;
  String userEmail;
  String userPhone;
  String userWhatsapp;
  String image;
  String transferredCoins;
  String transferDate;
  int type;

  Records(
      {this.userName,
      this.userEmail,
      this.userPhone,
      this.userWhatsapp,
      this.image,
      this.transferredCoins,
      this.transferDate,
      this.type});

  Records.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userWhatsapp = json['user_whatsapp'];
    image = json['image'];
    transferredCoins = json['transferred_coins'];
    transferDate = json['transfer_date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['user_whatsapp'] = this.userWhatsapp;
    data['image'] = this.image;
    data['transferred_coins'] = this.transferredCoins;
    data['transfer_date'] = this.transferDate;
    data['type'] = this.type;
    return data;
  }
}



