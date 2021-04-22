class UserDashboard {
  int status;
  String response;
  String message;
  Data data;

  UserDashboard({this.status, this.response, this.message, this.data});

  UserDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  dynamic totalBetsPlaced;
  dynamic totalActiveBetsPlaced;
  dynamic totalClosedBetsPlaced;
  dynamic totalPointsBettedFor;
  dynamic pointsEarned;
  dynamic totalCoinsWon;
  User user;

  Data(
      {this.totalBetsPlaced,
      this.totalActiveBetsPlaced,
      this.totalClosedBetsPlaced,
      this.totalPointsBettedFor,
      this.pointsEarned,
      this.totalCoinsWon,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    totalBetsPlaced = json['totalBetsPlaced'];
    totalActiveBetsPlaced = json['totalActiveBetsPlaced'];
    totalClosedBetsPlaced = json['totalClosedBetsPlaced'];
    totalPointsBettedFor = json['totalPointsBettedFor'];
    pointsEarned = json['pointsEarned'];
    totalCoinsWon = json['totalCoinsWon'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalBetsPlaced'] = this.totalBetsPlaced;
    data['totalActiveBetsPlaced'] = this.totalActiveBetsPlaced;
    data['totalClosedBetsPlaced'] = this.totalClosedBetsPlaced;
    data['totalPointsBettedFor'] = this.totalPointsBettedFor;
    data['pointsEarned'] = this.pointsEarned;
    data['totalCoinsWon'] = this.totalCoinsWon;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  bool verified;
  String role;
  dynamic coinsAvailable;
  String phone;
  String whatsapp;
  String images;

  User(
      {this.id,
      this.name,
      this.email,
      this.verified,
      this.role,
      this.coinsAvailable,
      this.phone,
      this.whatsapp,
      this.images});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    role = json['role'];
    coinsAvailable = json['coins_available'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['role'] = this.role;
    data['coins_available'] = this.coinsAvailable;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['images'] = this.images;
    return data;
  }
}