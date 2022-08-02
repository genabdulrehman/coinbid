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
    getUserModel = (await getUserController.getUserData());
    loading = false;
    notifyListeners();
  }
}
