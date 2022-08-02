import 'package:coinbid/Controllers/bank/bank_controller.dart';
import 'package:coinbid/Controllers/user/getUser_controller.dart';
import 'package:coinbid/Models/bank_model.dart';
import 'package:coinbid/Models/getUser_model.dart';
import 'package:flutter/material.dart';
import '';
import '../widgets/loading_widget.dart';

class BankDetailProvider with ChangeNotifier {
  BankDetailsController bankDetailsController = BankDetailsController();
  BankModel? bankModel;
  bool data = false;
  bool loading = false;

  getBankDetails(context) async {
    loading = true;
    notifyListeners();
     await bankDetailsController.getBankDetails().then((value) {
       loading = false;
       notifyListeners();
      if(value?.banks?.first.bankName != null){
        data = true;
        bankModel = value;
        notifyListeners();
      }
    });
  }
}
