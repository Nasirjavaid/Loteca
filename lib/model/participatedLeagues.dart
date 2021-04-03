class ParticipatedLeague {
  int status;
  String response;
  String message;
  List<ParticipatedLeagues> participatedLeagues;

  ParticipatedLeague(
      {this.status, this.response, this.message, this.participatedLeagues});

  ParticipatedLeague.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
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
    if (this.participatedLeagues != null) {
      data['participatedLeagues'] =
          this.participatedLeagues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParticipatedLeagues {
  int id;
  String name;
  String startingDate;
  String endingDate;
  String bettingDate;
  String createdAt;
  String updatedAt;
  String status;
  String tag;
  int creatorId;
  int joiningId;

  ParticipatedLeagues(
      {this.id,
      this.name,
      this.startingDate,
      this.endingDate,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.tag,
      this.creatorId,
      this.joiningId});

  ParticipatedLeagues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    bettingDate = json['betting_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    tag = json['tag'];
    creatorId = json['creator_id'];
    joiningId = json['joining_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['betting_date'] = this.bettingDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['tag'] = this.tag;
    data['creator_id'] = this.creatorId;
    data['joining_id'] = this.joiningId;
    return data;
  }
}