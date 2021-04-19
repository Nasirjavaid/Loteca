class UserCoinRecord {
  int status;
  String response;
  String message;
  List<Records> records;

  UserCoinRecord({this.status, this.response, this.message, this.records});

  UserCoinRecord.fromJson(Map<String, dynamic> json) {
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
  String senderName;
  String senderEmail;
  String senderPhone;
  String senderWhatsapp;
  String senderImage;
  String receivedCoins;
  String receivingDate;
  int type;

  Records(
      {this.senderName,
      this.senderEmail,
      this.senderPhone,
      this.senderWhatsapp,
      this.senderImage,
      this.receivedCoins,
      this.receivingDate,
      this.type});

  Records.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    senderEmail = json['sender_email'];
    senderPhone = json['sender_phone'];
    senderWhatsapp = json['sender_whatsapp'];
    senderImage = json['sender_image'];
    receivedCoins = json['received_coins'];
    receivingDate = json['receiving_date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_name'] = this.senderName;
    data['sender_email'] = this.senderEmail;
    data['sender_phone'] = this.senderPhone;
    data['sender_whatsapp'] = this.senderWhatsapp;
    data['sender_image'] = this.senderImage;
    data['received_coins'] = this.receivedCoins;
    data['receiving_date'] = this.receivingDate;
    data['type'] = this.type;
    return data;
  }
}
