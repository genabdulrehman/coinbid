import 'package:coinbid/Models/subscription_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../Constant/constant.dart';
import '../Models/bank_model.dart';

class GetSubscriptionController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<SubscriptionModel> getSubsciptionPlans({
    context,
  }) async {
    await fetchToken();
    SubscriptionModel subscriptionModel = SubscriptionModel();

    await getJson(ApiUrl().getSubscriptionPlans, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((plans) {
      if (plans["success"] != null && plans["success"] == true) {
        subscriptionModel = SubscriptionModel.fromJson(plans);
        print("Subscription ---> ${subscriptionModel.packages?.first.price}");
      } else {
        debugPrint("message x: ${plans['message']}");
      }
    });
    return subscriptionModel;
  }
}
