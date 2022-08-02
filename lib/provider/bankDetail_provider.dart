import 'package:coinbid/Controllers/bank/bank_controller.dart';
import 'package:coinbid/Controllers/user/getUser_controller.dart';
import 'package:coinbid/Models/bank_model.dart';
import 'package:coinbid/Models/getUser_model.dart';
import 'package:flutter/material.dart';
import '';

class BankDetailProvider with ChangeNotifier {
  BankDetailsController bankDetailsController = BankDetailsController();
  BankModel? bankModel;
  bool loading = false;

  getBankDetails() async {
    loading = true;
    bankModel = (await bankDetailsController.getbankDetails());
    loading = false;
    notifyListeners();
  }
}
