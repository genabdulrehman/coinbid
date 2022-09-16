import 'package:coinbid/Constant/constant.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

class ApiConfig {
  final TwilioPhoneVerify twilioPhoneVerify = TwilioPhoneVerify(
      accountSid: userController.accountSid,
      authToken: userController.authToken,
      serviceSid: userController.serviceSid);
}

String mainUrl = 'https://coinbid.in';

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
  String getTransations = '$mainUrl/users/transactions';
  String getTransationsYesterday = '$mainUrl/users/transactions/yesterday';
  String getTransationsToday = '$mainUrl/users/transactions/today';
  String exchangeCoinUrl = '$mainUrl/users/exchange/coins';
  String getVideoAdsUrl = '$mainUrl/users/videos/ads';
  String watchAdds = '$mainUrl/users/watch/ads';
  String getUserReportUrl = '$mainUrl/users/reports';
  String userBuyCoinUrl = '$mainUrl/users/buy/coins';
  String cashFreePaymentUrl = 'https://test.cashfree.com/api/v2/cftoken/order';
  String removeCounterUrl = '$mainUrl/users/empty/ads';
  String removeSubscriptionPlanUrl = '$mainUrl/users/delete/plan';
  String resetDailyCoins = '$mainUrl/users/coin/empty';
  String deleteCoinOrderUrl = '$mainUrl/users/delete/coin';
}
