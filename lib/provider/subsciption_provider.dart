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
    await getSubscriptionController.getSubsciptionPlans().then((plans) {
      isLoading = false;
      if (plans.success == true) {
        subscriptionModel = plans;
        notifyListeners();
      }
    });
  }
}



// import 'package:coinbid/Controllers/user/getUser_controller.dart';
// import 'package:coinbid/Models/getUser_model.dart';
// import 'package:flutter/material.dart';
// import '';

// class UserDataProvider with ChangeNotifier {
//   GetUserController getUserController = GetUserController();
//   GetUserModel? getUserModel;
//   bool loading = false;

//   getData() async {
//     loading = true;
//     await getUserController.getUserData().then((value) {
//       loading = false;
//       if (value?.success == true) {
//         getUserModel = value;
//         notifyListeners();
//       }
//     });
//   }
// }
