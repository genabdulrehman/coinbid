import 'package:coinbid/Controllers/getSubsciption_controller.dart';
import 'package:coinbid/Models/active_plan_model.dart';
import 'package:coinbid/Models/subscription_model.dart';
import 'package:flutter/material.dart';



class SubscriptionProvider with ChangeNotifier {
  GetSubscriptionController getSubscriptionController =
      GetSubscriptionController();
  SubscriptionModel subscriptionModel = SubscriptionModel();
  ActivePlanModel activePlanModel = ActivePlanModel();
  bool isLoading = false;
  bool packageLoading = false;

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

  getUserActivePackage() async {
    packageLoading = true;
    notifyListeners();
    await getSubscriptionController.getSubscribedPackage().then((plans) {
      packageLoading = false;
      notifyListeners();
      if (plans.success == true) {
        activePlanModel = plans;
        notifyListeners();
      }
    });
  }

}
