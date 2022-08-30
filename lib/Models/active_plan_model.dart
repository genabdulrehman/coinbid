

class ActivePlanModel {
  ActivePlanModel({
    this.success,
    this.packages,
  });

  bool? success;
  List<Package>? packages;

  factory ActivePlanModel.fromJson(Map<String, dynamic> json) => ActivePlanModel(
    success: json["success"],
    packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "packages": List<dynamic>.from(packages!.map((x) => x.toJson())),
  };
}

class Package {
  Package({
    this.id,
    this.users,
    this.packages,
    this.status,
    this.refound,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? users;
  Packages? packages;
  bool? status;
  bool? refound;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["_id"],
    users: json["users"],
    packages: Packages.fromJson(json["packages"]),
    status: json["status"],
    refound: json["refound"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users,
    "packages": packages?.toJson(),
    "status": status,
    "refound": refound,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
  };
}

class Packages {
  Packages({
    this.ads,
    this.totalAds,
    this.id,
    this.title,
    this.expireDate,
    this.banners,
    this.recommended,
    this.v,
    this.coins,
    this.price,
    this.icon
  });

  int? ads;
  int? totalAds;
  String? id;
  String? title;
  int? expireDate;
  int? banners;
  bool? recommended;
  int? v;
  int? coins;
  int? price;
  String? icon;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
    ads: json["ads"],
    totalAds: json["total_ads"],
    id: json["_id"],
    title: json["title"],
    expireDate: json["expire_date"],
    banners: json["banners"],
    recommended: json["recommended"],
    v: json["__v"],
    coins: json["coins"],
    price: json["price"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "ads": ads,
    "total_ads": totalAds,
    "_id": id,
    "title": title,
    "expire_date": expireDate,
    "banners": banners,
    "recommended": recommended,
    "__v": v,
    "coins": coins,
    "price": price,
  };
}
