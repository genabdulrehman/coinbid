
import 'package:coinbid/Models/withdrawl_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:coinbid/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../provider/getCoins_provider.dart';
import '../provider/getWallet_provider.dart';

class WithdrawAmountController extends GetxController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<WithdrawlModel> withdrawAmount(
     money,
    context,
  ) async {
    loadingDialogue(context: context);
    await fetchToken();
    WithdrawlModel withdrawlModel = WithdrawlModel();
    Object body = {"money": money.text};
    print("Amount from Ui $money");

    await postJson(ApiUrl().withdrawAmount, body, context,
        headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((response) {
      if (response["success"] != null && response["success"] == true) {
        Provider.of<GetWalletProvider>(context, listen: false).getwallet();
        Get.back();
        money.clear();
        Get.snackbar('withdraw request', response['message']);
        withdrawlModel = WithdrawlModel.fromJson(response);
        print("Withdraw ---> ${withdrawlModel.message}");
      } else {
        Get.back();
        Get.snackbar('Something went wrong', response['message']);
      }
    });
    return withdrawlModel;
  }


  Future<void> exchangeCoin(context, coin , price) async {
    loadingDialogue(context: context);
    await fetchToken();
    postJson(ApiUrl().exchangeCoinUrl,
        {
            "coin":coin.text,
            "price":price.text,
        },
        headers: {
          'Content-Type': 'application/json',
          'user_access_token': token.toString()
        },
        context).then((value) {
      if (value["success"] != null && value['success'] == true) {
        Provider.of<GetWalletProvider>(context, listen: false).getwallet();
        Get.back();
        coin.clear();
        price.clear();
        Get.snackbar('Exchange Request', value['message']);
      } else {
        Get.back();
        Get.snackbar('Something went wrong', value['message']);
      }
    });
  }

  Future<void> buyCoin(context, String id) async {
    loadingDialogue(context: context);
    String url = '${ApiUrl().userBuyCoinUrl}/$id';
    await fetchToken();
    putJson(url,
        {},
        headers: {
          'Content-Type': 'application/json',
          'user_access_token': token.toString()
        },
        context).then((value) {
      if (value["success"] != null && value['success'] == true) {
        Provider.of<GetWalletProvider>(context, listen: false).getwallet();
        Provider.of<GetCoinsProvider>(context, listen: false).getCoins();
        Get.back();
        Get.snackbar('Order Buy Successfully', value['message']);
      } else {
        Get.back();
        Get.snackbar('Something went wrong', value['message']);
      }
    });
  }

}
