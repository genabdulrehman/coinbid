

class Welcome {
  Welcome({
    this.success,
    this.packages,
  });

  bool? success;
  List<Package>? packages;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
    this.date,
    this.v,
  });

  String? id;
  String? users;
  Packages? packages;
  bool? status;
  bool? refound;
  DateTime? date;
  int? v;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["_id"],
    users: json["users"],
    packages: Packages.fromJson(json["packages"]),
    status: json["status"],
    refound: json["refound"],
    date: DateTime.parse(json["date"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users,
    "packages": packages!.toJson(),
    "status": status,
    "refound": refound,
    "date": date!.toIso8601String(),
    "__v": v,
  };
}

class Packages {
  Packages({
    this.ads,
    this.totalAds,
    this.id,
    this.title,
    this.price,
    this.expireDate,
    this.banners,
    this.coins,
    this.recommended,
    this.v,
  });

  int? ads;
  int? totalAds;
  String? id;
  String? title;
  int? price;
  int? expireDate;
  int? banners;
  int? coins;
  bool? recommended;
  int? v;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
    ads: json["ads"],
    totalAds: json["total_ads"],
    id: json["_id"],
    title: json["title"],
    price: json["price"],
    expireDate: json["expire_date"],
    banners: json["banners"],
    coins: json["coins"],
    recommended: json["recommended"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "ads": ads,
    "total_ads": totalAds,
    "_id": id,
    "title": title,
    "price": price,
    "expire_date": expireDate,
    "banners": banners,
    "coins": coins,
    "recommended": recommended,
    "__v": v,
  };
}
