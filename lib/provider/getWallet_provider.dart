import 'package:coinbid/Controllers/bank/bank_controller.dart';
import 'package:coinbid/Controllers/banners_controller.dart';
import 'package:coinbid/Controllers/getCoins_controller.dart';
import 'package:coinbid/Controllers/getWallet_controller.dart';
import 'package:coinbid/Controllers/user/getUser_controller.dart';
import 'package:coinbid/Models/bank_model.dart';
import 'package:coinbid/Models/banner_model.dart';
import 'package:coinbid/Models/getCoin_model.dart';
import 'package:coinbid/Models/getUser_model.dart';
import 'package:coinbid/Models/getWallet_model.dart';
import 'package:flutter/material.dart';
import '';
import '../widgets/loading_widget.dart';

class GetWalletProvider with ChangeNotifier {
  GetWalletController getWalletController = GetWalletController();
  GetWalletModel? getWalletModel;
  bool isLoading = false;

  getwallet() async {
    isLoading = true;

    await getWalletController.getWallet().then((wallet) {
      isLoading = false;
      if (wallet.success == true) {
        getWalletModel = wallet;
        notifyListeners();
      }
    });
  }
}
