class MainRound {
  int status;
  String response;
  String message;
  User user;
  bool bid;
  String betDate;
  String userAns;
  Round round;
  Agent agent;
  List<UserAnswers> userAnswers;

  MainRound(
      {this.status,
      this.response,
      this.message,
      this.bid,
      this.user,
      this.round,
      this.userAns,
      this.betDate,this.agent});

  MainRound.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    bid = json['bid'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    round = json['round'] != null ? new Round.fromJson(json['round']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    userAns = json['userAns'];
    betDate = json['bet_date'];
//Issue caused by chita's painYakii and then i setup this check with string 'No Bet Yet'
    if (json['userAnswers'] != null && json['userAnswers'] != "No Bet Yet") {
      userAnswers = new List<UserAnswers>();
      json['userAnswers'].forEach((v) {
        userAnswers.add(new UserAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    data['bid'] = this.bid;
    data['bet_date'] = this.betDate;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.round != null) {
      data['round'] = this.round.toJson();
    }
     if (this.agent != null) {
      data['agent'] = this.agent.toJson();
    }
    data['userAns'] = this.userAns;

    if (this.userAnswers != null) {
      data['userAnswers'] = this.userAnswers.map((v) => v.toJson()).toList();
    }
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
  int coins;

  Agent(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
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
    return data;
  }
}


class User {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  String selectedPackageId;
  int coins;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.selectedPackageId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    selectedPackageId = json['selectedPackageId'];
    coins = json['coins'];
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
    data['selectedPackageId'] = this.selectedPackageId;
    data['coins'] = this.coins;
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
  List<Packages> packages;
  int selectedPackageId;
  String selectedPackageAccumulativePrice;
  Packages selectedPackage;
  List<Games> games;

  Round(
      {this.id,
      this.name,
      this.startingDate,
      this.endingDate,
      this.createdAt,
      this.updatedAt,
      this.packages,
      this.games,
      this.selectedPackageId,
      this.selectedPackageAccumulativePrice,
      this.selectedPackage});

  Round.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    selectedPackageId = json['selectedPackageId'];
    selectedPackageAccumulativePrice = json['selectedPackageAccumulativePrice'];

    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages.add(new Packages.fromJson(v));
      });
    }

    selectedPackage = json['selected_package'] != null
        ? new Packages.fromJson(json['selected_package'])
        : null;

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
    data['selectedPackageId'] = this.selectedPackageId;
    data['selectedPackageAccumulativePrice'] =
        this.selectedPackageAccumulativePrice;
    if (this.packages != null) {
      data['packages'] = this.packages.map((v) => v.toJson()).toList();
    }

    if (this.selectedPackage != null) {
      data['selected_package'] = this.selectedPackage.toJson();
    }
    if (this.games != null) {
      data['games'] = this.games.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Packages {
  int id;
  String participationFee;
  String accumulativePrice;
  int roundId;
  String createdAt;
  String updatedAt;

  Packages(
      {this.id,
      this.participationFee,
      this.accumulativePrice,
      this.roundId,
      this.createdAt,
      this.updatedAt});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    participationFee = json['participation_fee'];
    accumulativePrice = json['accumulative_price'];
    roundId = json['round_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['participation_fee'] = this.participationFee;
    data['accumulative_price'] = this.accumulativePrice;
    data['round_id'] = this.roundId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  bool widegtSwitch0;
  bool widegtSwitch1;
  bool widegtSwitch2;
  String userSelctedTeamOrAnswer;
  Pivot pivot;

  Games(
      {this.id,
      this.name,
      this.teamA,
      this.teamB,
      this.happeningDate,
      this.createdAt,
      this.updatedAt,
      this.widegtSwitch0 = false,
      this.widegtSwitch1 = false,
      this.widegtSwitch2 = false,
      this.pivot,
      this.userSelctedTeamOrAnswer,
      this.flagA,
      this.flagB});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    teamA = json['team_a'];
    teamB = json['team_b'];
    happeningDate = json['happening_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    widegtSwitch0 = json['widegtSwitch0'];
    widegtSwitch1 = json['widegtSwitch1'];
    widegtSwitch2 = json['widegtSwitch2'];
    userSelctedTeamOrAnswer = json['userSelctedTeamOrAnswer'];
    flagA = json['flag_a'];
    flagB = json['flag_b'];

    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    data['widegtSwitch0'] = this.widegtSwitch0;
    data['widegtSwitch1'] = this.widegtSwitch1;
    data['widegtSwitch2'] = this.widegtSwitch2;
    data['userSelctedTeamOrAnswer'] = this.userSelctedTeamOrAnswer;
    data['flag_a'] = this.flagA;
    data['flag_b'] = this.flagB;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
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

class UserAnswers {
  int id;
  String teamA;
  String teamB;
  String winner;

  UserAnswers({this.id, this.teamA, this.teamB, this.winner});

  UserAnswers.fromJson(Map<String, dynamic> json) {
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
