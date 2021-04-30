class LastRoundResult {
  int status;
  String response;
  String message;
  List<LastClosedRounds> lastClosedRounds;

  LastRoundResult(
      {this.status, this.response, this.message, this.lastClosedRounds});

  LastRoundResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    if (json['lastClosedRounds'] != null) {
      lastClosedRounds = new List<LastClosedRounds>();
      json['lastClosedRounds'].forEach((v) {
        lastClosedRounds.add(new LastClosedRounds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.lastClosedRounds != null) {
      data['lastClosedRounds'] =
          this.lastClosedRounds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastClosedRounds {
  int id;
  String name;
  String startingDate;
  String endingDate;

  LastClosedRounds({this.id, this.name, this.startingDate, this.endingDate});

  LastClosedRounds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    return data;
  }
}