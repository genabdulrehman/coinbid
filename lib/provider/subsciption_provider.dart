import 'package:coinbid/Controllers/getSubsciption_controller.dart';
import 'package:coinbid/Models/subscription_model.dart';
import 'package:flutter/material.dart';

import '../Controllers/user/getUser_controller.dart';
import '../Models/getUser_model.dart';

class SubscriptionProvider with ChangeNotifier {
  GetSubscriptionController getSubscriptionController =
      GetSubscriptionController();
  SubscriptionModel subscriptionModel = SubscriptionModel();
  bool isLoading = false;


  getSubscriptions() async {
    isLoading = true;
    notifyListeners();
    await getSubscriptionController.getSubsciptionPlans().then((plans) {
      isLoading = false;
      notifyListeners();
      if (plans.success == true) {
        subscriptionModel = plans;
        notifyListeners();
      }
    });
  }
}
