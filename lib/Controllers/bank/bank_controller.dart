
import 'package:coinbid/Models/bank_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../api/http.dart';

class BankDetailsController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  BankModel? bankModel;
  // Future<BankModel?> getbankDetails() async {
  //   await fetchToken();
  //
  //   try {
  //     http.Response response =
  //         await http.get(Uri.parse(ApiUrl().bankDetailUrl), headers: {
  //       "user_access_token": token.toString(),
  //     });
  //     print("Banks ---> ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       var decodedResponse = jsonDecode(response.body);
  //
  //       bankModel = BankModel.fromJson(decodedResponse);
  //     } else {
  //       print("Bank request Error");
  //     }
  //   } catch (e) {
  //     print("Errror in fetching getting bankData : $e");
  //   }
  //
  //   return bankModel;
  // }

  Future<BankModel?> getBankDetails() async {
    await fetchToken();
    print(token.toString());
    await getJson(ApiUrl().bankDetailUrl, headers: {
      'Content-Type': 'application/json',
      'user_access_token': token.toString()
    }).then((response) {
      if(response['success'] == true)
        {
          bankModel = BankModel.fromJson(response);
        }
      else{
        debugPrint("message: ${response['message']}");
      }

    });

    return bankModel;
  }
}
