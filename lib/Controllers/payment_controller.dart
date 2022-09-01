import 'dart:convert';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:coinbid/Models/payment_proceed_model.dart';
import 'package:coinbid/api/config.dart';
import 'package:get/get.dart';
import '../Models/getUser_model.dart';
import '../Models/payment_token_model.dart';
import 'package:http/http.dart' as http;
import '../widgets/loading_widget.dart';
import 'getSubsciption_controller.dart';

class PaymentController{
  PaymentTokenModel paymentTokenModel = PaymentTokenModel();
  Future<PaymentTokenModel> getPaymentToken(context,String orderId,String amount) async{
    loadingDialogue(context: context);
    Map<String,String> headers = {
      "Content-Type": "application/json",
      "x-client-secret": 'd6a633144c5659597bfae601ecf067cc068a1fff',
      "x-client-id": '2242555e3b0cd4dc01241ffd99552422',
    };
    final body = jsonEncode({
      "orderId": orderId,
      "orderAmount": amount,
      "orderCurrency":"INR"
    });
   await http
        .post(Uri.parse(ApiUrl().cashFreePaymentUrl),
     headers:headers,
        body: body,
       )
        .timeout(const Duration(minutes: 2))
        .then((response) {
     paymentTokenModel = PaymentTokenModel.fromJson(jsonDecode(response.body));
   });
    return paymentTokenModel;
  }

PaymentProceedModel paymentProceedModel = PaymentProceedModel();
  Future<void> proceedPayment(context,String token,String orderId,String planId ,String amount,GetUserModel userModel,) async{
    Map<String, dynamic> inputs = {
      "orderId":orderId,
      "orderAmount":amount,
      "customerName": userModel.users?.name ??'',
      "orderCurrency":"INR",
      "appId":"2242555e3b0cd4dc01241ffd99552422",
      "customerPhone":userModel.users?.mobile ??'',
      "customerEmail":userModel.users?.email ??'',
      "stage": "TEST",
      "color1": "#FFFFFF",
      "color2":"#000000",
      "tokenData":token,
    };
    CashfreePGSDK.doPayment(inputs).then((value) {
      print(value);
      paymentProceedModel = PaymentProceedModel.fromJson(value!);
      if(paymentProceedModel.txStatus == "CANCELLED"){
        Get.snackbar(
            paymentProceedModel.txStatus?? '',
            'You cancelled the payment request');
    }
      else if(paymentProceedModel.txStatus == "FAILED"){
        Get.snackbar(
            paymentProceedModel.txStatus?? '',
            paymentProceedModel.txMsg?? '');
      }
      else if(paymentProceedModel.txStatus == "SUCCESS"){
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     maintainState: true,
        //     builder: (BuildContext context) => const SuccessPaymentScreen(),
        //   ),
        //       (Route<dynamic> route) => false,
        // );
        GetSubscriptionController().subscribePlan(
            context, planId,
        );
      }
    });
  }

}