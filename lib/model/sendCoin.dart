class SendCoin {
  int status;
  String response;
  String message;
  Agent agent;
  Agent user;
  String coinsTransferred;
  String coinsTransferDate;

  SendCoin(
      {this.status,
      this.response,
      this.message,
      this.agent,
      this.user,
      this.coinsTransferred,this.coinsTransferDate});

  SendCoin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    user = json['user'] != null ? new Agent.fromJson(json['user']) : null;
    coinsTransferred = json['coins_transferred'];
    coinsTransferDate = json['transfer_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.agent != null) {
      data['agent'] = this.agent.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['coins_transferred'] = this.coinsTransferred;
    data['transfer_date'] = this.coinsTransferDate;
    return data;
  }
}

class Agent {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  String phone;
  int coins;

  Agent(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,this.phone});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['roles'] = this.roles;
    data['coins'] = this.coins;
    data['phone'] = this.phone;
    return data;
  }
}


