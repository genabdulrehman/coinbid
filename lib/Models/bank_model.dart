import 'package:coinbid/Models/UserModel.dart';

class BankModel {
  BankModel({
    this.success,
    this.banks,
  });

  bool? success;
  List<Bank>? banks;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    success: json["success"],
    banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "banks": List<dynamic>.from(banks!.map((x) => x.toJson())),
  };
}

class Bank {
  Bank({
    this.id,
    this.bankName,
    this.accountNumber,
    this.users,
    this.ifscCode,
    this.upiId,
    this.amount,
    this.status,
    this.v,
  });

  String? id;
  String? bankName;
  String? accountNumber;
  UserModel? users;
  String? ifscCode;
  String? upiId;
  int? amount;
  String? status;
  int? v;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["_id"],
    bankName: json["bank_name"],
    accountNumber: json["account_number"],
    users: UserModel.fromJson(json["users"]),
    ifscCode: json["ifsc_code"],
    upiId: json["upi_id"],
    amount: json["amount"],
    status: json["status"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bank_name": bankName,
    "account_number": accountNumber,
    "users": users?.toJson(),
    "ifsc_code": ifscCode,
    "upi_id": upiId,
    "amount": amount,
    "status": status,
    "__v": v,
  };
}