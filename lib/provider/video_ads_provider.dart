import 'package:coinbid/Controllers/video_ads_controller.dart';
import 'package:coinbid/Models/video_ads_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VideoAdsProvider extends ChangeNotifier {
  VideoAdsController videoAdsController = VideoAdsController();

  VideoAdsModel? videoAdsModel;
  bool isLoading = false;
  getVideoAds() async {
    isLoading = true;
    notifyListeners();
    await videoAdsController.getVideoAdsModel().then((transations) {
      if (transations.success == true) {
        isLoading = false;
        videoAdsModel = transations;
        notifyListeners();
      } else {

      }
    });
  }
}
