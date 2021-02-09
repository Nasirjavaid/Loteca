class AgentsToBuyCoins {
  int status;
  String response;
  String message;
  List<Agents> agents;

  AgentsToBuyCoins({this.status, this.response, this.message, this.agents});

  AgentsToBuyCoins.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    if (json['agents'] != null) {
      agents = new List<Agents>();
      json['agents'].forEach((v) {
        agents.add(new Agents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.agents != null) {
      data['agents'] = this.agents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agents {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String image;
  List<Images> images;
  List<Contacts> contacts;

  Agents(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.image,
      this.images,
      this.contacts});

  Agents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    image = json['image'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['contacts'] != null) {
      contacts = new List<Contacts>();
      json['contacts'].forEach((v) {
        contacts.add(new Contacts.fromJson(v));
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
    data['image'] = this.image;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts.map((v) => v.toJson()).toList();
    }
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