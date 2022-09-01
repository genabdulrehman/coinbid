import 'package:coinbid/Models/active_plan_model.dart';
import 'package:coinbid/Models/subscription_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:coinbid/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../provider/subsciption_provider.dart';
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

  Future<void> subscribePlan(context, String planId) async {
    loadingDialogue(context: context);
    String url = '$mainUrl/subscribe/plan/$planId';
    print("Url : of subscribe plan: $url");
    await fetchToken();
    try {
      await putJson(
              url,
              {},
              headers: {
                // 'Content-Type': 'application/json',
                'user_access_token': token.toString()
              },
              context)
          .then((value) {
        if (value['success'] == true) {
          Get.back();
          Get.snackbar("Successfully", value['message']);
          Provider.of<SubscriptionProvider>(context, listen: false).getUserActivePackage();
        } else {
          Get.back();
          errorDialogue(
              context: context,
              title: "Something went wrong",
              bodyText: value['message']);
        }
      });
    } catch (e) {
      Get.back();
      print("Failed to subscribe : $e");
    }
  }

  Future<ActivePlanModel> getSubscribedPackage({
    context,
  }) async {
    await fetchToken();
    ActivePlanModel activePlanModel = ActivePlanModel();

    await getJson(ApiUrl().getSubscribedPlan, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((plans) {
      if (plans["success"] != null && plans["success"] == true) {
        activePlanModel = ActivePlanModel.fromJson(plans);
      } else {
        debugPrint("message x: ${plans['message']}");
      }
    });
    return activePlanModel;
  }
}
