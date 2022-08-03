import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../Constant/constant.dart';
import '../Models/bank_model.dart';

class BankController extends GetxController {
  static BankController instance = Get.find();
  Rx<BankModel> bankDetail = BankModel().obs;

  @override
  void onReady() {
    super.onReady();
  }


  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<dynamic> postBankDetails(
      {context,
        String? bankName,
      String? accountNumber,
      String? ifsc,
      String? upi_id}) async {
    await fetchToken();

    Map<String, dynamic> body = {
      "bank_name": bankName,
      "account_number": accountNumber,
      "ifsc_code": ifsc,
      "upi_id": upi_id
    };

   return await postJson(ApiUrl().bankDetailUrl, body,context,
        headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    });
  }

  Future<dynamic> editBankDetails(
      {context,
        String? bankName,
        String? accountNumber,
        String? ifsc,
        String? upi_id}) async {
    await fetchToken();
print(token.toString());
    Map<String, dynamic> body = {
      "bank_name": bankName,
      "account_number": accountNumber,
      "ifsc_code": ifsc,
      "upi_id": upi_id
    };

    return await putJson(ApiUrl().updateBankDetailUrl, body,context,
        headers: {
          'Content-Type': 'application/json',
          'user_access_token': token.toString()
        });
  }
}
