import 'package:coinbid/Models/getCoin_model.dart';
import 'package:coinbid/Models/getWallet_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class GetWalletController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<GetWalletModel> getWallet({
    context,
  }) async {
    await fetchToken();
    GetWalletModel getWalletModel = GetWalletModel();

    await getJson(ApiUrl().getWallet, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((wallet) {
      print("Wallet ---> ${wallet}");
      if (wallet["success"] != null && wallet["success"] == true) {
        getWalletModel = GetWalletModel.fromJson(wallet);
        print("Wallet ---> ${getWalletModel.wallets?.coins}");
      } else {
        debugPrint("message x: ${wallet['message']}");
      }
    });
    return getWalletModel;
  }
}
