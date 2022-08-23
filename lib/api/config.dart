import 'package:coinbid/Constant/constant.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  final TwilioPhoneVerify twilioPhoneVerify = TwilioPhoneVerify(
      accountSid: userController.accountSid,
      authToken: userController.authToken,
      serviceSid: userController.serviceSid);
}
 String mainUrl = 'https://coinbid11.herokuapp.com';
class ApiUrl {
  String signupUrl = '$mainUrl/users/signup';
  String loginUrl = '$mainUrl/users/signin';
  String bankDetailUrl = '$mainUrl/users/bank';
  String getUser = '$mainUrl/users/me';
  String updateBankDetailUrl = '$mainUrl/users/bank';
  String forgetPassword = '$mainUrl/users/forget/password';
  String updateUserUrl = '$mainUrl/users/update';
  String getSubscriptionPlans = '$mainUrl/users/package';
  String getBanners = '$mainUrl/users/banner';
  String getCoins = '$mainUrl/users/coin';
  String getWallet = '$mainUrl/users/wallet';
  String withdrawAmount = '$mainUrl/users/request/payment';
  String getSubscribedPlan = '$mainUrl/get/subscribe/plan';
}
