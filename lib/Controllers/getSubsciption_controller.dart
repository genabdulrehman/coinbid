import 'package:coinbid/Models/subscription_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../Constant/constant.dart';
import '../Models/bank_model.dart';
import '../widgets/error_dialogue.dart';

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

  Future<void> subscribePlan(context, String planId) async{
    String url = '$mainUrl/subscribe/plan/$planId';
   await postJson(url, {} ,
        headers:{
          'Content-Type': 'application/json',
          'user_access_token': token.toString()
        }
        , context).then((value) {
      if (value['success'] == true) {
       // Navigator.pop(context);
      } else {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value['message']);
      }
    });
  }

  Future<void> getSubscriptionPlan(context) async{
    await getJson(ApiUrl().getSubscribedPlan,
        headers:{
          'Content-Type': 'application/json',
          'user_access_token': token.toString()
        }
    ).then((value) {
      if (value['success'] == true) {
        print("successfully getting");
      } else {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value['message']);
      }
    });
  }

}
