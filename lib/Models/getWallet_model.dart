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
  String? sId;
  int? coins;
  String? users;
  int? price;
  int? iV;

  Wallets({this.sId, this.coins, this.users, this.price, this.iV});

  Wallets.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    coins = json['coins'];
    users = json['users'];
    price = json['price'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['coins'] = this.coins;
    data['users'] = this.users;
    data['price'] = this.price;
    data['__v'] = this.iV;
    return data;
  }
}
