
import 'package:coinbid/api/config.dart';
import 'package:coinbid/api/http.dart';
import 'package:get/get.dart';

import '../Constant/constant.dart';
import '../Models/bank_model.dart';

class BankController extends GetxController{
  static BankController instance = Get.find();
  Rx<BankModel> bankDetail = BankModel().obs;

  @override
  void onReady() {
    super.onReady();


  }

  Future<Rx<BankModel>> getBankDetail(String token) async {
      var bank = getJson(ApiUrl().bankDetailUrl,
        headers: {
          'Content-Type': 'application/json',
          'user_access_token': token
        }
      );
       bankDetail = BankModel.fromJson(bank as Map<String, dynamic>) as Rx<BankModel>;
      return bankDetail;
  }
  Future<Rx<BankModel>> getBankDetails(String token) async {
     getJson(ApiUrl().bankDetailUrl,
        headers: {
          'Content-Type': 'application/json',
          'user_access_token': token
        }
    ).then((response) {
     bankDetail.value = BankModel.fromJson(response as Map<String , dynamic>);
    });

        return bankDetail;
  }

}