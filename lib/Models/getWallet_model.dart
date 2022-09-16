class GetWalletModel {
  bool? success;
  Wallets? wallets;

  GetWalletModel({this.success, this.wallets});

  GetWalletModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    wallets =
        json['wallets'] != null ? new Wallets.fromJson(json['wallets']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.wallets != null) {
      data['wallets'] = this.wallets!.toJson();
    }
    return data;
  }
}

class Wallets {
  int? total_ads;
  String? sId;
  int? coins;
  String? users;
  int? price;
  int? iV;
  int? counter;
  String? updatedAt;

  Wallets(
      {this.total_ads,
      this.sId,
      this.coins,
      this.users,
      this.price,
      this.iV,
      this.counter,
      this.updatedAt});

  Wallets.fromJson(Map<String, dynamic> json) {
    total_ads = json['total_ads'];
    sId = json['_id'];
    coins = json['coins'];
    users = json['users'];
    price = json['price'];
    iV = json['__v'];
    counter = json['counter'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_ads'] = this.total_ads;
    data['_id'] = this.sId;
    data['coins'] = this.coins;
    data['users'] = this.users;
    data['price'] = this.price;
    data['__v'] = this.iV;
    data['counter'] = this.counter;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
