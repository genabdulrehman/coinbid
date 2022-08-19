import 'package:coinbid/Models/getCoin_model.dart';
import 'package:coinbid/Models/withdrawl_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:coinbid/widgets/error_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../provider/getWallet_provider.dart';

class WithdrawAmountController extends GetxController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<WithdrawlModel> withdrawAmount({
    String? money,
    context,
  }) async {
    await fetchToken();
    WithdrawlModel withdrawlModel = WithdrawlModel();
    Object body = {"money": money};
    print("Amount from Ui $money");

    await postJson(ApiUrl().withdrawAmount, body, context, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((response) {
      if (response["success"] != null && response["success"] == true) {
        Provider.of<GetWalletProvider>(context, listen: false).getwallet();
        Get.snackbar('withdraw request', response['message']);
        withdrawlModel = WithdrawlModel.fromJson(response);
        print("Withdraw ---> ${withdrawlModel.message}");
      } else {
        debugPrint("message x: ${response['message']}");
      }
    });
    return withdrawlModel;
  }
}
