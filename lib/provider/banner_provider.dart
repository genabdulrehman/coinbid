import 'package:coinbid/Controllers/bank/bank_controller.dart';
import 'package:coinbid/Controllers/banners_controller.dart';
import 'package:coinbid/Controllers/user/getUser_controller.dart';
import 'package:coinbid/Models/bank_model.dart';
import 'package:coinbid/Models/banner_model.dart';
import 'package:coinbid/Models/getUser_model.dart';
import 'package:flutter/material.dart';
import '';
import '../widgets/loading_widget.dart';

class GetBannersProvider with ChangeNotifier {
  GetBannersController getBannersController = GetBannersController();
  BannerModel? bannerModel;
  bool isLoading = false;

  getBanners() async {
    isLoading = true;

    await getBannersController.getBanners().then((banners) {
      isLoading = false;
      if (banners.success == true) {
        bannerModel = banners;
        notifyListeners();
      }
    });
  }
}
