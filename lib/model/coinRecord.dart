class CoinRecord {
  int status;
  String response;
  String message;
  List<CoinHistory> coinHistory;
  List<BetHistory> betHistory;

  CoinRecord(
      {this.status,
      this.response,
      this.message,
      this.coinHistory,
      this.betHistory});

  CoinRecord.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    if (json['coin_history'] != null) {
      coinHistory = new List<CoinHistory>();
      json['coin_history'].forEach((v) {
        coinHistory.add(new CoinHistory.fromJson(v));
      });
    }
    if (json['bet_history'] != null) {
      betHistory = new List<BetHistory>();
      json['bet_history'].forEach((v) {
        betHistory.add(new BetHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.coinHistory != null) {
      data['coin_history'] = this.coinHistory.map((v) => v.toJson()).toList();
    }
    if (this.betHistory != null) {
      data['bet_history'] = this.betHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoinHistory {
  int recordId;
  String userName;
  String userEmail;
  String userPhone;
  String userWhatsapp;
  String image;
  String transferredCoins;
  String transferDate;

  CoinHistory(
      {this.recordId,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.userWhatsapp,
      this.image,
      this.transferredCoins,
      this.transferDate});

  CoinHistory.fromJson(Map<String, dynamic> json) {
    recordId = json['record_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userWhatsapp = json['user_whatsapp'];
    image = json['image'];
    transferredCoins = json['transferred_coins'];
    transferDate = json['transfer_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['record_id'] = this.recordId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['user_whatsapp'] = this.userWhatsapp;
    data['image'] = this.image;
    data['transferred_coins'] = this.transferredCoins;
    data['transfer_date'] = this.transferDate;
    return data;
  }
}

class BetHistory {
  int recordId;
  String userName;
  String userEmail;
  String userPhone;
  String userWhatsapp;
  String image;
  String coinsUsed;
  String betDate;

  BetHistory(
      {this.recordId,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.userWhatsapp,
      this.image,
      this.coinsUsed,
      this.betDate});

  BetHistory.fromJson(Map<String, dynamic> json) {
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
