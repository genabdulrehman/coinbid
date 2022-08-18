import 'package:coinbid/Controllers/bank/bank_controller.dart';
import 'package:coinbid/Controllers/banners_controller.dart';
import 'package:coinbid/Controllers/getCoins_controller.dart';
import 'package:coinbid/Controllers/user/getUser_controller.dart';
import 'package:coinbid/Models/bank_model.dart';
import 'package:coinbid/Models/banner_model.dart';
import 'package:coinbid/Models/getCoin_model.dart';
import 'package:coinbid/Models/getUser_model.dart';
import 'package:flutter/material.dart';
import '';
import '../widgets/loading_widget.dart';

class GetCoinsProvider with ChangeNotifier {
  GetCoinsController getCoinsController = GetCoinsController();
  GetCoinModel? getCoinModel;
  bool isLoading = false;

  getCoins() async {
    isLoading = true;

    await getCoinsController.getCoins().then((coins) {
      isLoading = false;
      if (coins.success == true) {
        getCoinModel = coins;
        notifyListeners();
      }
    });
  }
}
