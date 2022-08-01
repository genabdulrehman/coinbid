
import 'package:twilio_phone_verify/twilio_phone_verify.dart';
import 'package:http/http.dart' as http;

class ApiConfig{
  final TwilioPhoneVerify twilioPhoneVerify = TwilioPhoneVerify(
      accountSid: 'AC51ff97ecacf05e992f25df3699aa34be',
      authToken: 'e0f7d481f847c74b6dc5a8a43073ad0f',
      serviceSid: 'VA1b8f6a2f3b89045812d191de8638b55c'
  );
}

class ApiUrl {
  static String mainUrl = 'https://coinbid11.herokuapp.com';
  String signupUrl = '$mainUrl/users/signup';
  String loginUrl = '$mainUrl/users/signin';

}