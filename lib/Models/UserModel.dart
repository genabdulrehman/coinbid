
import 'package:flutter/cupertino.dart';

class UserModel {
  static const iD = "uid";
  static const dbName = "Name";
  static const dbEmail = "Email";
  static const dbVerified = "Verified";
  static const dbPass = "Password";
  static const dbPhoneNo = "Phone No";
  static const dbProfile = "Profile";

  String? profile,uid,name,email,password,phoneNo;
  bool? verified;


  UserModel({this.profile,this.uid,this.name,this.email,this.password,this.phoneNo,this.verified});

  UserModel.fromMap(Map<String, dynamic> data){
    uid = data[iD];
    name = data[dbName];
    email = data[dbEmail];
    password = data[dbPass];
    phoneNo = data[dbPhoneNo];
    verified = data[dbVerified];
    profile = data[dbProfile];
  }

// UserModel.fromSnapshot(DocumentSnapshot snapshot) {
//   name = snapshot.data()[NAME];
//   email = snapshot.data()[EMAIL];
//   uid = snapshot.data()[ID];
//   userProfile = snapshot.data()[UserPROFILE];
//

}

