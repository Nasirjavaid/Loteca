

class AgentDashboardModel {
  int status;
  String response;
  String message;
  Data data;

  AgentDashboardModel({this.status, this.response, this.message, this.data});

  AgentDashboardModel.fromJson(Map<String, dynamic> json) {
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
  DailyData dailyData;
  DailyData weeklyData;
  DailyData monthlyData;
  DailyData allTimeData;
  User user;
  int availableForWithdraw;

  Data(
      {this.dailyData,
      this.weeklyData,
      this.monthlyData,
      this.allTimeData,
      this.user,
      this.availableForWithdraw});

  Data.fromJson(Map<String, dynamic> json) {
    dailyData = json['daily_data'] != null
        ? new DailyData.fromJson(json['daily_data'])
        : null;
    weeklyData = json['weekly_data'] != null
        ? new DailyData.fromJson(json['weekly_data'])
        : null;
    monthlyData = json['monthly_data'] != null
        ? new DailyData.fromJson(json['monthly_data'])
        : null;
    allTimeData = json['all_time_data'] != null
        ? new DailyData.fromJson(json['all_time_data'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    availableForWithdraw = json['available_for_withdraw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dailyData != null) {
      data['daily_data'] = this.dailyData.toJson();
    }
    if (this.weeklyData != null) {
      data['weekly_data'] = this.weeklyData.toJson();
    }
    if (this.monthlyData != null) {
      data['monthly_data'] = this.monthlyData.toJson();
    }
    if (this.allTimeData != null) {
      data['all_time_data'] = this.allTimeData.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['available_for_withdraw'] = this.availableForWithdraw;
    return data;
  }
}

class DailyData {
  int sales;
  int comission;

  DailyData({this.sales, this.comission});

  DailyData.fromJson(Map<String, dynamic> json) {
    sales = json['sales'];
    comission = json['comission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales'] = this.sales;
    data['comission'] = this.comission;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String authCode;
  Comissions comissions;
  List<Contacts> contacts;
  List<Images> images;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.authCode,
      this.comissions,
      this.contacts,
      this.images});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    authCode = json['auth_code'];
    comissions = json['comissions'] != null
        ? new Comissions.fromJson(json['comissions'])
        : null;
    if (json['contacts'] != null) {
      contacts = new List<Contacts>();
      json['contacts'].forEach((v) {
        contacts.add(new Contacts.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
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
    data['auth_code'] = this.authCode;
    if (this.comissions != null) {
      data['comissions'] = this.comissions.toJson();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comissions {
  int id;
  String comissionPercentage;
  int userId;
  String createdAt;
  String updatedAt;

  Comissions(
      {this.id,
      this.comissionPercentage,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Comissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comissionPercentage = json['comission_percentage'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comission_percentage'] = this.comissionPercentage;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Contacts {
  int id;
  String phone;
  String whatsapp;
  String email;
  int userId;
  String createdAt;
  String updatedAt;

  Contacts(
      {this.id,
      this.phone,
      this.whatsapp,
      this.email,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Images {
  int id;
  String url;
  int userId;
  String createdAt;
  String updatedAt;

  Images({this.id, this.url, this.userId, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

