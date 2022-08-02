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

  Future<Rx<BankModel>> getBankDetail(String token) async {
    var bank = getJson(ApiUrl().bankDetailUrl, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token
    });
    bankDetail =
        BankModel.fromJson(bank as Map<String, dynamic>) as Rx<BankModel>;
    return bankDetail;
  }

  Future<Rx<BankModel>> getBankDetails(String token) async {
    getJson(ApiUrl().bankDetailUrl, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token
    }).then((response) {
      bankDetail.value = BankModel.fromJson(response as Map<String, dynamic>);
    });

    return bankDetail;
  }

  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<void> postBankDetails(
      {String? bankName,
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

    var bank = postJson(ApiUrl().bankDetailUrl, body, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((value) {});
  }
}
