import 'dart:io';

import 'package:coinbid/Models/video_ads_model.dart';
import 'package:coinbid/widgets/error_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../api/config.dart';
import '../api/http.dart';
import '../provider/getWallet_provider.dart';

class VideoAdsController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<void> isAdswatched(bool ads) async {
    var box = await Hive.openBox("UserData");
    var data = box.put("is-ads-watched", ads);
    // token = data.toString();
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
        isAdswatched(false);
        videoAdsModel = VideoAdsModel.fromJson(response);
        print("Transations ---> ${videoAdsModel.success}");
      } else {
        Get.snackbar("Something went wrong", response['message']);

        if (response["message"] == "Today 5 ads watched") {
          isAdswatched(true);
        }
      }
    });
    return videoAdsModel;
  }

  Future<void> watchAdds({context, String? id}) async {
    var res;
    await fetchToken();
    print(token.toString());
    Map<String, dynamic> body = {};
    print("Watch adds is called on $id");

    try {
      var response = await putJson("${ApiUrl().watchAdds}/$id", body, context,
          headers: {'user_access_token': token.toString()});

      print("Successfully add is watched");
      await Provider.of<GetWalletProvider>(context, listen: false).getwallet();
    } catch (e) {
      print("Status Code os : $e");

      errorDialogue(context: context, title: "Error", bodyText: e.toString());
    }
  }
}
