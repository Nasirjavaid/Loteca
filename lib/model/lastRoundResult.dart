class LastRoundResult {
  int status;
  String response;
  String message;
  List<Answers> answers;
  Round round;

  LastRoundResult(
      {this.status, this.response, this.message, this.answers, this.round});

  LastRoundResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    round = json['round'] != null ? new Round.fromJson(json['round']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    if (this.round != null) {
      data['round'] = this.round.toJson();
    }
    return data;
  }
}

class Answers {
  int id;
  String teamA;
  String teamB;
  String winner;

  Answers({this.id, this.teamA, this.teamB, this.winner});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamA = json['team_a'];
    teamB = json['team_b'];
    winner = json['winner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_a'] = this.teamA;
    data['team_b'] = this.teamB;
    data['winner'] = this.winner;
    return data;
  }
}

class Round {
  int id;
  String name;
  String startingDate;
  String endingDate;
  String createdAt;
  String updatedAt;
  String status;
  String tag;
  int creatorId;
  int joiningId;
  List<Games> games;

  Round(
      {this.id,
      this.name,
      this.startingDate,
      this.endingDate,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.tag,
      this.creatorId,
      this.joiningId,
      this.games});

  Round.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    tag = json['tag'];
    creatorId = json['creator_id'];
    joiningId = json['joining_id'];
    if (json['games'] != null) {
      games = new List<Games>();
      json['games'].forEach((v) {
        games.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['tag'] = this.tag;
    data['creator_id'] = this.creatorId;
    data['joining_id'] = this.joiningId;
    if (this.games != null) {
      data['games'] = this.games.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Games {
  int id;
  String name;
  String teamA;
  String teamB;
  String happeningDate;
  String createdAt;
  String updatedAt;
  String flagA;
  String flagB;
  Pivot pivot;
  Results results;

  Games(
      {this.id,
      this.name,
      this.teamA,
      this.teamB,
      this.happeningDate,
      this.createdAt,
      this.updatedAt,
      this.flagA,
      this.flagB,
      this.pivot,
      this.results});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    teamA = json['team_a'];
    teamB = json['team_b'];
    happeningDate = json['happening_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flagA = json['flag_a'];
    flagB = json['flag_b'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['team_a'] = this.teamA;
    data['team_b'] = this.teamB;
    data['happening_date'] = this.happeningDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['flag_a'] = this.flagA;
    data['flag_b'] = this.flagB;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    return data;
  }
}

class Pivot {
  int roundId;
  int gameId;

  Pivot({this.roundId, this.gameId});

  Pivot.fromJson(Map<String, dynamic> json) {
    roundId = json['round_id'];
    gameId = json['game_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['round_id'] = this.roundId;
    data['game_id'] = this.gameId;
    return data;
  }
}

class Results {
  int id;
  String answer;
  int gameId;
  String createdAt;
  String updatedAt;

  Results({this.id, this.answer, this.gameId, this.createdAt, this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['Answer'];
    gameId = json['game_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Answer'] = this.answer;
    data['game_id'] = this.gameId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}