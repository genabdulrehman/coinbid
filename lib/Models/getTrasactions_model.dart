class GetTransactionsModel {
  bool? success;
  List<Transactions>? transactions;

  GetTransactionsModel({this.success, this.transactions});

  GetTransactionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? sId;
  Users? users;
  String? transaction;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Transactions(
      {this.sId,
      this.users,
      this.transaction,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Transactions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    transaction = json['transaction'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    data['transaction'] = this.transaction;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Users {
  String? sId;
  String? name;
  String? email;
  int? verified;
  String? password;
  int? iV;
  String? city;
  String? mobile;
  String? profile;
  String? state;

  Users(
      {this.sId,
      this.name,
      this.email,
      this.verified,
      this.password,
      this.iV,
      this.city,
      this.mobile,
      this.profile,
      this.state});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    password = json['password'];
    iV = json['__v'];
    city = json['city'];
    mobile = json['mobile'];
    profile = json['profile'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['password'] = this.password;
    data['__v'] = this.iV;
    data['city'] = this.city;
    data['mobile'] = this.mobile;
    data['profile'] = this.profile;
    data['state'] = this.state;
    return data;
  }
}
