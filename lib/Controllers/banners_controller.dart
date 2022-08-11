import 'package:coinbid/Models/banner_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class GetBannersController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<BannerModel> getBanners({
    context,
  }) async {
    await fetchToken();
    BannerModel bannerModel = BannerModel();

    await getJson(ApiUrl().getBanners, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((plans) {
      if (plans["success"] != null && plans["success"] == true) {
        bannerModel = BannerModel.fromJson(plans);
        print("Bnners ---> ${bannerModel.banners?.first.title}");
      } else {
        debugPrint("message x: ${plans['message']}");
      }
    });
    return bannerModel;
  }
}
