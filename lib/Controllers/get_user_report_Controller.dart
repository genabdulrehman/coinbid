
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../Models/user_report_model.dart';

class GetUserReportController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<UserReportModel> getUserReport({
    context,
  }) async {
    await fetchToken();
    UserReportModel userReportModel = UserReportModel();

    await getJson(ApiUrl().getUserReportUrl, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((plans) {
      if (plans["success"] != null && plans["success"] == true) {
        userReportModel = UserReportModel.fromJson(plans);
        print("Bnners ---> ${userReportModel.reports?.coinEarned}");
      } else {
        debugPrint("message x: ${plans['message']}");
      }
    });
    return userReportModel;
  }


  Future<void> resetDailyCoinReset(context) async{
    await fetchToken();
    putJson(ApiUrl().resetDailyCoins,
        {}, context,
        headers: {'user_access_token': token.toString()}
    ).then((value) {
    });
  }
}
