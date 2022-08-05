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
  String? birth;
  String? city;
  String? mobile;
  String? profile;
  String? state;

  Users(
      {this.sId,
      this.name,
      this.email,
      this.verified,
      this.iV,
      this.birth,
      this.city,
      this.mobile,
      this.profile,
      this.state});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    iV = json['__v'];
    birth = json['birth'];
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
    data['__v'] = this.iV;
    data['birth'] = this.birth;
    data['city'] = this.city;
    data['mobile'] = this.mobile;
    data['profile'] = this.profile;
    data['state'] = this.state;
    return data;
  }
}
