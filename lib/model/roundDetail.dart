class RoundDetail {
  int status;
  String response;
  String message;
  Winners winners;
  List<Answers> answers;
  List<LeaderBoard> leaderBoard;
  Round round;

  RoundDetail(
      {this.status,
      this.response,
      this.message,
      this.winners,
      this.answers,
      this.leaderBoard,
      this.round});

  RoundDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    winners =
        json['winners'] != null ? new Winners.fromJson(json['winners']) : null;
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    if (json['leaderBoard'] != null) {
      leaderBoard = new List<LeaderBoard>();
      json['leaderBoard'].forEach((v) {
        leaderBoard.add(new LeaderBoard.fromJson(v));
      });
    }
    round = json['round'] != null ? new Round.fromJson(json['round']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.winners != null) {
      data['winners'] = this.winners.toJson();
    }
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    if (this.leaderBoard != null) {
      data['leaderBoard'] = this.leaderBoard.map((v) => v.toJson()).toList();
    }
    if (this.round != null) {
      data['round'] = this.round.toJson();
    }
    return data;
  }
}

class Winners {
  FirstPackageWinners firstPackageWinners;
  SecondPackageWinners secondPackageWinners;
  ThirdPackageWinners thirdPackageWinners;

  Winners(
      {this.firstPackageWinners,
      this.secondPackageWinners,
      this.thirdPackageWinners});

  Winners.fromJson(Map<String, dynamic> json) {
    firstPackageWinners = json['firstPackageWinners'] != null
        ? new FirstPackageWinners.fromJson(json['firstPackageWinners'])
        : null;
    secondPackageWinners = json['secondPackageWinners'] != null
        ? new SecondPackageWinners.fromJson(json['secondPackageWinners'])
        : null;
    thirdPackageWinners = json['thirdPackageWinners'] != null
        ? new ThirdPackageWinners.fromJson(json['thirdPackageWinners'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.firstPackageWinners != null) {
      data['firstPackageWinners'] = this.firstPackageWinners.toJson();
    }
    if (this.secondPackageWinners != null) {
      data['secondPackageWinners'] = this.secondPackageWinners.toJson();
    }
    if (this.thirdPackageWinners != null) {
      data['thirdPackageWinners'] = this.thirdPackageWinners.toJson();
    }
    return data;
  }
}

class FirstPackageWinners {
  List<FirstJackPotWinners> firstJackPotWinners;
  List<SecondJackPotWinners> secondJackPotWinners;
  List<ThirdJackPotWinners> thirdJackPotWinners;

  FirstPackageWinners(
      {this.firstJackPotWinners,
      this.secondJackPotWinners,
      this.thirdJackPotWinners});

  FirstPackageWinners.fromJson(Map<String, dynamic> json) {
    if (json['firstJackPotWinners'] != null) {
      firstJackPotWinners = new List<FirstJackPotWinners>();
      json['firstJackPotWinners'].forEach((v) {
        firstJackPotWinners.add(new FirstJackPotWinners.fromJson(v));
      });
    }
    if (json['secondJackPotWinners'] != null) {
      secondJackPotWinners = new List<SecondJackPotWinners>();
      json['secondJackPotWinners'].forEach((v) {
        secondJackPotWinners.add(new SecondJackPotWinners.fromJson(v));
      });
    }
    if (json['thirdJackPotWinners'] != null) {
      thirdJackPotWinners = new List<ThirdJackPotWinners>();
      json['thirdJackPotWinners'].forEach((v) {
        thirdJackPotWinners.add(new ThirdJackPotWinners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.firstJackPotWinners != null) {
      data['firstJackPotWinners'] =
          this.firstJackPotWinners.map((v) => v.toJson()).toList();
    }
    if (this.secondJackPotWinners != null) {
      data['secondJackPotWinners'] =
          this.secondJackPotWinners.map((v) => v.toJson()).toList();
    }
    if (this.thirdJackPotWinners != null) {
      data['thirdJackPotWinners'] =
          this.thirdJackPotWinners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecondPackageWinners {
  List<FirstJackPotWinners> firstJackPotWinners;
  List<SecondJackPotWinners> secondJackPotWinners;
  List<ThirdJackPotWinners> thirdJackPotWinners;

  SecondPackageWinners(
      {this.firstJackPotWinners,
      this.secondJackPotWinners,
      this.thirdJackPotWinners});

  SecondPackageWinners.fromJson(Map<String, dynamic> json) {
    if (json['firstJackPotWinners'] != null) {
      firstJackPotWinners = new List<FirstJackPotWinners>();
      json['firstJackPotWinners'].forEach((v) {
        firstJackPotWinners.add(new FirstJackPotWinners.fromJson(v));
      });
    }
    if (json['secondJackPotWinners'] != null) {
      secondJackPotWinners = new List<SecondJackPotWinners>();
      json['secondJackPotWinners'].forEach((v) {
        secondJackPotWinners.add(new SecondJackPotWinners.fromJson(v));
      });
    }
    if (json['thirdJackPotWinners'] != null) {
      thirdJackPotWinners = new List<ThirdJackPotWinners>();
      json['thirdJackPotWinners'].forEach((v) {
        thirdJackPotWinners.add(new ThirdJackPotWinners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.firstJackPotWinners != null) {
      data['firstJackPotWinners'] =
          this.firstJackPotWinners.map((v) => v.toJson()).toList();
    }
    if (this.secondJackPotWinners != null) {
      data['secondJackPotWinners'] =
          this.secondJackPotWinners.map((v) => v.toJson()).toList();
    }
    if (this.thirdJackPotWinners != null) {
      data['thirdJackPotWinners'] =
          this.thirdJackPotWinners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThirdPackageWinners {
  List<FirstJackPotWinners> firstJackPotWinners;
  List<SecondJackPotWinners> secondJackPotWinners;
  List<ThirdJackPotWinners> thirdJackPotWinners;

  ThirdPackageWinners(
      {this.firstJackPotWinners,
      this.secondJackPotWinners,
      this.thirdJackPotWinners});

  ThirdPackageWinners.fromJson(Map<String, dynamic> json) {
    if (json['firstJackPotWinners'] != null) {
      firstJackPotWinners = new List<FirstJackPotWinners>();
      json['firstJackPotWinners'].forEach((v) {
        firstJackPotWinners.add(new FirstJackPotWinners.fromJson(v));
      });
    }
    if (json['secondJackPotWinners'] != null) {
      secondJackPotWinners = new List<SecondJackPotWinners>();
      json['secondJackPotWinners'].forEach((v) {
        secondJackPotWinners.add(new SecondJackPotWinners.fromJson(v));
      });
    }
    if (json['thirdJackPotWinners'] != null) {
      thirdJackPotWinners = new List<ThirdJackPotWinners>();
      json['thirdJackPotWinners'].forEach((v) {
        thirdJackPotWinners.add(new ThirdJackPotWinners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.firstJackPotWinners != null) {
      data['firstJackPotWinners'] =
          this.firstJackPotWinners.map((v) => v.toJson()).toList();
    }
    if (this.secondJackPotWinners != null) {
      data['secondJackPotWinners'] =
          this.secondJackPotWinners.map((v) => v.toJson()).toList();
    }
    if (this.thirdJackPotWinners != null) {
      data['thirdJackPotWinners'] =
          this.thirdJackPotWinners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirstJackPotWinners {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String authCode;
  String image;
  String winningCoins;

  FirstJackPotWinners(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.authCode,
      this.image,
      this.winningCoins});

  FirstJackPotWinners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    authCode = json['auth_code'];
    image = json['image'];
    winningCoins = json['winningCoins'];
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
    data['image'] = this.image;
    data['winningCoins'] = this.winningCoins;
    return data;
  }
}

class SecondJackPotWinners {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String authCode;
  String image;
  String winningCoins;

  SecondJackPotWinners(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.authCode,
      this.image,
      this.winningCoins});

  SecondJackPotWinners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    authCode = json['auth_code'];
    image = json['image'];
    winningCoins = json['winningCoins'];
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
    data['image'] = this.image;
    data['winningCoins'] = this.winningCoins;
    return data;
  }
}

class ThirdJackPotWinners {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String authCode;
  String image;
  String winningCoins;

  ThirdJackPotWinners(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.authCode,
      this.image,
      this.winningCoins});

  ThirdJackPotWinners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    authCode = json['auth_code'];
    image = json['image'];
    winningCoins = json['winningCoins'];
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
    data['image'] = this.image;
    data['winningCoins'] = this.winningCoins;
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

class LeaderBoard {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String authCode;
  String image;
  String pointsScored;

  LeaderBoard(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.authCode,
      this.image,
      this.pointsScored});

  LeaderBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    authCode = json['auth_code'];
    image = json['image'];
    pointsScored = json['points_scored'];
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
    data['image'] = this.image;
    data['points_scored'] = this.pointsScored;
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
  Null creatorId;
  Null joiningId;
  List<Packages> packages;
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
      this.packages,
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
    if (json['packages'] != null) {
      packages = new List<Packages>();
      json['packages'].forEach((v) {
        packages.add(new Packages.fromJson(v));
      });
    }
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
    if (this.packages != null) {
      data['packages'] = this.packages.map((v) => v.toJson()).toList();
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
