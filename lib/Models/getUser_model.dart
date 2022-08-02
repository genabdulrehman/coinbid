class GetUserModel {
  bool? success;
  Users? users;

  GetUserModel({this.success, this.users});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class Users {
  String? sId;
  String? name;
  String? email;
  int? verified;
  int? iV;

  Users({this.sId, this.name, this.email, this.verified, this.iV});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['__v'] = this.iV;
    return data;
  }
}
