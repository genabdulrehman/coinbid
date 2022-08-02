import 'package:flutter/cupertino.dart';

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.verified,
    this.password,
    this.phoneNo,
    this.v,
  });

  String? id;
  String? name;
  String? email;
  String? phoneNo;
  int? verified;
  String? password;
  int? v;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        verified: json["verified"],
        phoneNo: json["mobile"] ?? "",
        password: json["password"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "verified": verified,
        "password": password,
        "__v": v,
      };
}
