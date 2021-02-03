class LeaguesModel {
  int status;
  String response;
  String message;
  List<ActiveLeagues> activeLeagues;
  List<ClosedLeagues> closedLeagues;
  List<ParticipatedLeagues> participatedLeagues;

  LeaguesModel(
      {this.status,
      this.response,
      this.message,
      this.activeLeagues,
      this.closedLeagues,
      this.participatedLeagues});

  LeaguesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    if (json['activeLeagues'] != null) {
      activeLeagues = new List<ActiveLeagues>();
      json['activeLeagues'].forEach((v) {
        activeLeagues.add(new ActiveLeagues.fromJson(v));
      });
    }
    if (json['closedLeagues'] != null) {
      closedLeagues = new List<ClosedLeagues>();
      json['closedLeagues'].forEach((v) {
        closedLeagues.add(new ClosedLeagues.fromJson(v));
      });
    }
    if (json['participatedLeagues'] != null) {
      participatedLeagues = new List<ParticipatedLeagues>();
      json['participatedLeagues'].forEach((v) {
        participatedLeagues.add(new ParticipatedLeagues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.activeLeagues != null) {
      data['activeLeagues'] =
          this.activeLeagues.map((v) => v.toJson()).toList();
    }
    if (this.closedLeagues != null) {
      data['closedLeagues'] =
          this.closedLeagues.map((v) => v.toJson()).toList();
    }
    if (this.participatedLeagues != null) {
      data['participatedLeagues'] =
          this.participatedLeagues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActiveLeagues {
  int id;
  String name;
  String startingDate;
  String endingDate;
  String createdAt;
  String updatedAt;

  ActiveLeagues(
      {this.id,
      this.name,
      this.startingDate,
      this.endingDate,
      this.createdAt,
      this.updatedAt});

  ActiveLeagues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class ClosedLeagues {
  int id;
  String name;
  String startingDate;
  String endingDate;
  String createdAt;
  String updatedAt;

  ClosedLeagues(
      {this.id,
      this.name,
      this.startingDate,
      this.endingDate,
      this.createdAt,
      this.updatedAt});

  ClosedLeagues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class ParticipatedLeagues {
  int id;
  String name;
  String startingDate;
  String endingDate;
  String createdAt;
  String updatedAt;

  ParticipatedLeagues(
      {this.id,
      this.name,
      this.startingDate,
      this.endingDate,
      this.createdAt,
      this.updatedAt});

  ParticipatedLeagues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}