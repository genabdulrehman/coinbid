import 'package:coinbid/Models/getTrasactions_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class TransactionsController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<GetTransactionsModel> getTransations({
    context,
  }) async {
    await fetchToken();
    GetTransactionsModel getTransactionsModel = GetTransactionsModel();

    await getJson(ApiUrl().getTransations, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((transactions) {
      if (transactions["success"] != null && transactions["success"] == true) {
        getTransactionsModel = GetTransactionsModel.fromJson(transactions);
        print("Transations ---> ${getTransactionsModel.success}");
      } else {
        debugPrint("message x: ${transactions['message']}");
      }
    });
    return getTransactionsModel;
  }
}
