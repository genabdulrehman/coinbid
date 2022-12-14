import 'dart:convert';

import 'package:coinbid/Models/UserModel.dart';
import 'package:coinbid/Models/getUser_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class GetUserController extends GetxController {
  String? token;
  Future<String?> fetchToken() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  GetUserModel? getUserModel;
  Future<GetUserModel?> getUserData() async {
    await fetchToken();

    try {
      http.Response response =
          await http.get(Uri.parse(ApiUrl().getUser), headers: {
        "user_access_token": token.toString(),
      });

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);

        getUserModel = GetUserModel.fromJson(decodedResponse);
      } else {
        print("Error");
      }
    } catch (e) {
      print("Errror in fetching getting userdata : $e");
    }

    return getUserModel;
  }
}
