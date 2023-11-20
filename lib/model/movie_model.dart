class MovieModel {
  List<Result>? result;

  MovieModel({
    this.result,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );
}

class Result {
  String? id;
  String? description;
  List<String>? director;
  List<String>? writers;
  List<String>? stars;
  List<String>? productionCompany;
  int? pageViews;
  List<String>? upVoted;
  List<String>? downVoted;
  String? title;
  String? language;
  int? runTime;
  int? releasedDate;
  String? genre;
  List<Voted>? voted;
  String? poster;
  int? totalVoted;
  int? voting;

  Result({
    this.id,
    this.description,
    this.director,
    this.writers,
    this.stars,
    this.productionCompany,
    this.pageViews,
    this.upVoted,
    this.downVoted,
    this.title,
    this.language,
    this.runTime,
    this.releasedDate,
    this.genre,
    this.voted,
    this.poster,
    this.totalVoted,
    this.voting,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        description: json["description"],
        director: json["director"] == null
            ? []
            : List<String>.from(json["director"]!.map((x) => x)),
        writers: json["writers"] == null
            ? []
            : List<String>.from(json["writers"]!.map((x) => x)),
        stars: json["stars"] == null
            ? []
            : List<String>.from(json["stars"]!.map((x) => x)),
        productionCompany: json["productionCompany"] == null
            ? []
            : List<String>.from(json["productionCompany"]!.map((x) => x)),
        pageViews: json["pageViews"],
        upVoted: json["upVoted"] == null
            ? []
            : List<String>.from(json["upVoted"]!.map((x) => x)),
        downVoted: json["downVoted"] == null
            ? []
            : List<String>.from(json["downVoted"]!.map((x) => x)),
        title: json["title"],
        language: json["language"],
        runTime: json["runTime"],
        releasedDate: json["releasedDate"],
        genre: json["genre"],
        voted: json["voted"] == null
            ? []
            : List<Voted>.from(json["voted"]!.map((x) => Voted.fromJson(x))),
        poster: json["poster"],
        totalVoted: json["totalVoted"],
        voting: json["voting"],
      );
}

class Voted {
  List<dynamic>? upVoted;
  List<dynamic>? downVoted;
  String? id;
  int? updatedAt;
  String? genre;

  Voted({
    this.upVoted,
    this.downVoted,
    this.id,
    this.updatedAt,
    this.genre,
  });

  factory Voted.fromJson(Map<String, dynamic> json) => Voted(
        upVoted: json["upVoted"] == null
            ? []
            : List<dynamic>.from(json["upVoted"]!.map((x) => x)),
        downVoted: json["downVoted"] == null
            ? []
            : List<dynamic>.from(json["downVoted"]!.map((x) => x)),
        id: json["_id"],
        updatedAt: json["updatedAt"],
        genre: json["genre"],
      );
}
