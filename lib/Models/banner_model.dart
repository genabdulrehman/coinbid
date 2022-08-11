class BannerModel {
  bool? success;
  List<Banners>? banners;

  BannerModel({this.success, this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? sId;
  String? title;
  String? color;
  String? image;
  int? iV;

  Banners({this.sId, this.title, this.color, this.image, this.iV});

  Banners.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    color = json['color'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['color'] = this.color;
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}
