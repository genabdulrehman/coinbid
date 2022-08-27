import 'package:coinbid/Models/video_ads_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../api/config.dart';
import '../api/http.dart';

class VideoAdsController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<VideoAdsModel> getVideoAdsModel({
    context,
  }) async {
    await fetchToken();
    VideoAdsModel videoAdsModel = VideoAdsModel();

    await getJson(ApiUrl().getVideoAdsUrl, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((response) {
      if (response["success"] != null && response["success"] == true) {
        videoAdsModel = VideoAdsModel.fromJson(response);
        print("Transations ---> ${videoAdsModel.success}");
      } else {
        Get.snackbar(
            "Something went wrong",
            response['message']);
      }
    });
    return videoAdsModel;
  }
}