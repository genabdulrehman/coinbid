

class UserReportModel {
  UserReportModel({
    this.success,
    this.reports,
  });

  bool? success;
  Reports? reports;

  factory UserReportModel.fromJson(Map<String, dynamic> json) => UserReportModel(
    success: json["success"],
    reports: Reports.fromJson(json["reports"] ??null),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "reports": reports!.toJson(),
  };
}

class Reports {
  Reports({
    this.id,
     this.users,
     this.adsWatch,
     this.coinEarned,
     this.convertedCoin,
    this.todayCoinEarned,
    this.convertedEarned,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? users;
  int? adsWatch;
  int? coinEarned;
  int? convertedCoin;
  int? todayCoinEarned;
  int? convertedEarned;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
    id: json["_id"] ?? '',
    users: json["users"]??'',
    adsWatch: json["ads_watch"]??'',
    coinEarned: json["coin_earned"]??0,
    convertedCoin: json["converted_coin"]??0,
    todayCoinEarned: json["today_coin_earned"]??0,
    convertedEarned: json["converted_earned"]??0,
    createdAt: DateTime.parse(json["created_at"]??null),
    updatedAt: DateTime.parse(json["updated_at"]??null),
    v: json["__v"] ??0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users,
    "ads_watch": adsWatch,
    "coin_earned": coinEarned,
    "converted_coin": convertedCoin,
    "today_coin_earned": todayCoinEarned,
    "converted_earned": convertedEarned,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
  };
}
