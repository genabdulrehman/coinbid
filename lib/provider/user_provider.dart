import 'package:coinbid/Controllers/user/getUser_controller.dart';
import 'package:coinbid/Models/getUser_model.dart';
import 'package:flutter/material.dart';
import '';

class UserDataProvider with ChangeNotifier {
  GetUserController getUserController = GetUserController();
  GetUserModel? getUserModel;
  bool loading = false;

  getData() async {
    loading = true;
    await getUserController.getUserData().then((value) {
      loading = false;
      if (value?.success == true) {
        getUserModel = value;
        notifyListeners();
      }
    });
  }
}
