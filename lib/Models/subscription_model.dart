class SubscriptionModel {
  bool? success;
  List<Packages>? packages;

  SubscriptionModel({this.success, this.packages});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  String? sId;
  String? title;
  int? price;
  int? expireDate;
  int? banners;
  int? coins;
  bool? isRecommended;
  bool? active = false;
  String? icon;
  int? iV;

  Packages(
      {this.sId,
      this.title,
      this.price,
        this.coins,
        this.active,
        this.isRecommended,
      this.expireDate,
      this.banners,
      this.icon,
      this.iV});

  Packages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'] ?? 200;
    coins = json['coins'];
    isRecommended = json['recommended'];
    expireDate = json['expire_date'];
    banners = json['banners'];
    icon = json['icon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['expire_date'] = this.expireDate;
    data['banners'] = this.banners;
    data['icon'] = this.icon;
    data['__v'] = this.iV;
    return data;
  }
}
