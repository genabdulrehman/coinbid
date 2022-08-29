import 'package:coinbid/Models/getCoin_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class GetCoinsController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<GetCoinModel> getCoins({
    context,
  }) async {
    await fetchToken();
    GetCoinModel getCoinModel = GetCoinModel();

    await getJson(ApiUrl().getCoins, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((plans) {
      if (plans["success"] != null && plans["success"] == true) {
        getCoinModel = GetCoinModel.fromJson(plans);
        print("Bnners ---> ${getCoinModel.orders?.first.price}");
      } else {
        debugPrint("message x: ${plans['message']}");
      }
    });
    return getCoinModel;
  }
}
