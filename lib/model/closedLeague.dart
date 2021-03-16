class ClosedLeague {
  int status;
  String response;
  String message;
  List<FirstPackageWinners> firstPackageWinners;
  List<SecondPackageWinners> secondPackageWinners;
  List<ThirdPackageWinners> thirdPackageWinners;
  List<Answers> answers;
  Round round;

  ClosedLeague(
      {this.status,
      this.response,
      this.message,
      this.firstPackageWinners,
      this.secondPackageWinners,
      this.thirdPackageWinners,
      this.answers,
      this.round});

  ClosedLeague.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    message = json['message'];
    if (json['First Package Winners'] != null) {
      firstPackageWinners = new List<FirstPackageWinners>();
      json['First Package Winners'].forEach((v) {
        firstPackageWinners.add(new FirstPackageWinners.fromJson(v));
      });
    }
    if (json['Second Package Winners'] != null) {
      secondPackageWinners = new List<SecondPackageWinners>();
      json['Second Package Winners'].forEach((v) {
        secondPackageWinners.add(new SecondPackageWinners.fromJson(v));
      });
    }
    if (json['Third Package Winners'] != null) {
      thirdPackageWinners = new List<ThirdPackageWinners>();
      json['Third Package Winners'].forEach((v) {
        thirdPackageWinners.add(new ThirdPackageWinners.fromJson(v));
      });
    }
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
    if (this.firstPackageWinners != null) {
      data['First Package Winners'] =
          this.firstPackageWinners.map((v) => v.toJson()).toList();
    }
    if (this.secondPackageWinners != null) {
      data['Second Package Winners'] =
          this.secondPackageWinners.map((v) => v.toJson()).toList();
    }
    if (this.thirdPackageWinners != null) {
      data['Third Package Winners'] =
          this.thirdPackageWinners.map((v) => v.toJson()).toList();
    }
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    if (this.round != null) {
      data['round'] = this.round.toJson();
    }
    return data;
  }
}

class FirstPackageWinners {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String image;
  String winningCoins;
  List<Images> images;

  FirstPackageWinners(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.image,
      this.winningCoins,
      this.images});

  FirstPackageWinners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    image = json['image'];
    winningCoins = json['Winning Coins'];
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
    data['image'] = this.image;
    data['Winning Coins'] = this.winningCoins;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class SecondPackageWinners {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String image;
  String winningCoins;
  List<Images> images;

  SecondPackageWinners(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.image,
      this.winningCoins,
      this.images});

  SecondPackageWinners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    image = json['image'];
    winningCoins = json['Winning Coins'];
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
    data['image'] = this.image;
    data['Winning Coins'] = this.winningCoins;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ThirdPackageWinners {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String roles;
  int coins;
  String image;
  String winningCoins;
  List<Images> images;

  ThirdPackageWinners(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.coins,
      this.image,
      this.winningCoins,
      this.images});

  ThirdPackageWinners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roles = json['roles'];
    coins = json['coins'];
    image = json['image'];
    winningCoins = json['Winning Coins'];
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
    data['image'] = this.image;
    data['Winning Coins'] = this.winningCoins;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
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
  String creatorId;
  String joiningId;
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