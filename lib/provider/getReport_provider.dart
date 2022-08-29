
import 'package:coinbid/Models/user_report_model.dart';
import 'package:flutter/material.dart';
import '';
import '../Controllers/get_user_report_Controller.dart';


class GetReportProvider with ChangeNotifier {
  GetUserReportController getUserReportController = GetUserReportController();
  UserReportModel? userReportModel;
  bool isLoading = false;

  getUserReport() async {
    isLoading = true;
    notifyListeners();
    await getUserReportController.getUserReport().then((value) {
      isLoading = false;
      if (value.success == true) {
        userReportModel = value;
        notifyListeners();
      }
    });
  }
}
