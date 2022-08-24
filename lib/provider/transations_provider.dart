import 'package:coinbid/Controllers/transaction_controller.dart';
import 'package:coinbid/Models/getTrasactions_model.dart';
import 'package:coinbid/Models/transaction_model.dart';
import 'package:flutter/material.dart';

import '../Controllers/transations_controller.dart';

class TransactionsProvider extends ChangeNotifier {
  TransactionsController transactionController = TransactionsController();

  GetTransactionsModel? transactionModel;
  bool isLoading = false;
  getTransations() async {
    isLoading = true;
    await transactionController.getTransations().then((transations) {
      if (transations.success == true) {
        isLoading = false;
        transactionModel = transations;
        notifyListeners();
      } else {}
    });
  }
}
