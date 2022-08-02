class BankModel {
  bool? success;
  List<Banks>? banks;

  BankModel({this.success, this.banks});

  BankModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.banks != null) {
      data['banks'] = this.banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  String? sId;
  String? bankName;
  String? accountNumber;
  Users? users;
  String? ifscCode;
  String? upiId;
  int? amount;
  String? status;
  int? iV;

  Banks(
      {this.sId,
      this.bankName,
      this.accountNumber,
      this.users,
      this.ifscCode,
      this.upiId,
      this.amount,
      this.status,
      this.iV});

  Banks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    ifscCode = json['ifsc_code'];
    upiId = json['upi_id'];
    amount = json['amount'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    data['ifsc_code'] = this.ifscCode;
    data['upi_id'] = this.upiId;
    data['amount'] = this.amount;
    data['status'] = this.status;
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

  Users(
      {this.sId, this.name, this.email, this.verified, this.password, this.iV});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    password = json['password'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['password'] = this.password;
    data['__v'] = this.iV;
    return data;
  }
}
