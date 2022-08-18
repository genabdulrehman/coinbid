class GetCoinModel {
  bool? success;
  List<Coins>? coins;

  GetCoinModel({this.success, this.coins});

  GetCoinModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['coins'] != null) {
      coins = <Coins>[];
      json['coins'].forEach((v) {
        coins!.add(new Coins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.coins != null) {
      data['coins'] = this.coins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coins {
  String? sId;
  String? coinId;
  String? users;
  String? coins;
  String? price;
  int? status;
  String? date;
  int? iV;

  Coins(
      {this.sId,
      this.coinId,
      this.users,
      this.coins,
      this.price,
      this.status,
      this.date,
      this.iV});

  Coins.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    coinId = json['coin_id'];
    users = json['users'];
    coins = json['coins'];
    price = json['price'];
    status = json['status'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['coin_id'] = this.coinId;
    data['users'] = this.users;
    data['coins'] = this.coins;
    data['price'] = this.price;
    data['status'] = this.status;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}
