import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinbid/api/http.dart';
import 'package:coinbid/provider/user_provider.dart';
import 'package:coinbid/screens/signup/otp_verification_code.dart';
import 'package:coinbid/widgets/error_dialogue.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

import '../Models/UserModel.dart';
import '../api/config.dart';
import '../screens/dashboard/home_page.dart';
import '../screens/signup/reset_link_successfully.dart';
import '/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late Rx<User?> firebaseUser;
  Rx<UserModel> userData = UserModel().obs;
  User? currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference studentReference =
      FirebaseFirestore.instance.collection('Users');
  CollectionReference twilioReference =
      FirebaseFirestore.instance.collection('Twilio');

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(currentUser);
    getTwilioAccess();
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //binding all Streams
    currentUser = user;
    if (currentUser != null) {
     // userData.bindStream(listenToUser());
    }
  }

  Stream<UserModel> listenToUser() => studentReference
      .doc(firebaseUser.value?.uid)
      .snapshots()
      .map((snapshot) =>
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>));

  String accountSid = '';
  String authToken = '';
  String serviceSid = '';
  Future<void> getTwilioAccess() async {
    twilioReference.doc('PDwgeYazeqR8wx4vVARf').get().then((value) {
      accountSid = value['accountSid'];
      authToken = value['authToken'];
      serviceSid = value['serviceSid'];
    });
  }

  Future<void> signUp(
    UserModel userModel,
    context,
  ) async {
    postJson(
            ApiUrl().signupUrl,
            {
              "name": userModel.name,
              "email": userModel.email,
              "password": userModel.password,
              "contact" : userModel.phoneNo,
              "verified": true
            },
            context)
        .then((value) {
      if (value['success'] == true) {
        Navigator.pop(context);
        Get.offAll(() => const PasswordResetLinkSuccessfully(
              title: "User Signup successfully",
            ));
      } else {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value['message']);
      }
    });
    // await firebaseAuth
    //     .createUserWithEmailAndPassword(
    //   email: userModel.email??'',
    //   password: userModel.password ??'',
    // ).then((auth) {
    //   currentUser = auth.user;
    //   studentReference.doc(currentUser?.uid).set({
    //     UserModel.iD: currentUser?.uid,
    //     UserModel.dbName: userModel.name,
    //     UserModel.dbEmail: userModel.email,
    //     UserModel.dbPass: userModel.password,
    //     UserModel.dbPhoneNo: userModel.phoneNo,
    //     UserModel.dbVerified:true,
    //   }).then((value) async {
    //     Navigator.pop(context);
    //     Get.offAll( () => const PasswordResetLinkSuccessfully(title: "User Signup successfully",));
    //   }).catchError((onError) {
    //     Navigator.pop(context);
    //     errorDialogue(
    //         context: context,
    //         title: "Something went wrong",
    //         bodyText: onError.message.toString());
    //   });
    // }).catchError((onError) {
    //   Navigator.pop(context);
    //   errorDialogue(
    //       context: context,
    //       title: "Something went wrong",
    //       bodyText: onError.message.toString());
    // });
  }

  Future<void> sendOtp(UserModel userModel, context) async {
    loadingDialogue(context: context);
    await ApiConfig()
        .twilioPhoneVerify
        .sendSmsCode(userModel.phoneNo ?? '')
        .then((value) {
      if (value.successful == true) {
        Navigator.pop(context);
        Get.to(OtpVerificationCode(
          userModel: userModel,
        ));
      } else {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value.errorMessage.toString());
      }
    });
  }

  Future<void> resendOtp(String phoneNo, context) async {
    loadingDialogue(context: context);
    await ApiConfig().twilioPhoneVerify.sendSmsCode(phoneNo).then((value) {
      if (value.successful == true) {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            imageUrl: 'images/correct.png',
            title: "Successfully",
            bodyText: "OTP Code Re-Send Successfully");
      } else {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value.errorMessage.toString());
      }
    });
  }

  Future<TwilioResponse> verifyOtp(String phoneNo, String otpCode) async {
    var twilioResponse = await ApiConfig()
        .twilioPhoneVerify
        .verifySmsCode(phone: phoneNo, code: otpCode);
    return twilioResponse;
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await firebaseAuth.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }

  Future<void> signUpAfterGoogleLogin(
      String name,
      String email,
      String profile,
      context,
      ) async {
    postJson(
        ApiUrl().signupUrl,
        {
            "name":name,
            "email":email,
            "profile":profile,
            "is_social":true
        },
        context)
        .then((value) {
      if (value['success'] == true) {
        enterDataToHive(keyName: "user-access-token", value: value['token']);
        getUserData(header: value['token']);
        token = value['token'];
        print("The token is -> ${value['token']}");
        Navigator.pop(context);
        Get.offAll(const HomePage());
      } else {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value['message']);
      }
    });
    // await firebaseAuth
    //     .createUserWithEmailAndPassword(
    //   email: userModel.email??'',
    //   password: userModel.password ??'',
    // ).then((auth) {
    //   currentUser = auth.user;
    //   studentReference.doc(currentUser?.uid).set({
    //     UserModel.iD: currentUser?.uid,
    //     UserModel.dbName: userModel.name,
    //     UserModel.dbEmail: userModel.email,
    //     UserModel.dbPass: userModel.password,
    //     UserModel.dbPhoneNo: userModel.phoneNo,
    //     UserModel.dbVerified:true,
    //   }).then((value) async {
    //     Navigator.pop(context);
    //     Get.offAll( () => const PasswordResetLinkSuccessfully(title: "User Signup successfully",));
    //   }).catchError((onError) {
    //     Navigator.pop(context);
    //     errorDialogue(
    //         context: context,
    //         title: "Something went wrong",
    //         bodyText: onError.message.toString());
    //   });
    // }).catchError((onError) {
    //   Navigator.pop(context);
    //   errorDialogue(
    //       context: context,
    //       title: "Something went wrong",
    //       bodyText: onError.message.toString());
    // });
  }



  Future<void> enterDataToHive({String? keyName, String? value}) async {
    var box = await Hive.openBox("UserData");
    box.put("$keyName", value);
  }

  Future<String?> readDataFromHive() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-access-token");
    token = data.toString();

    return data;
  }

  Future<void> removeDataFromHive() async {
    var box = await Hive.openBox("Signin");
    box.deleteAll(box.keys);
  }

  String token = '';
  Future<void> logIn(String email, password, context) async {
    loadingDialogue(context: context);
    postJson(ApiUrl().loginUrl, {"email": email, "password": password}, context)
        .then((value) {
      if (value['success'] == true) {
        enterDataToHive(keyName: "user-access-token", value: value['token']);
        getUserData(header: value['token']);
        token = value['token'];
        print("The token is -> ${value['token']}");
        Navigator.pop(context);
        Get.offAll(const HomePage());
      } else {
        Navigator.pop(context);
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value['message']);
      }
    });
    // loadingDialogue(context: context);
    // // await sharedPreferences!.clear();
    // await firebaseAuth
    //     .signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // )
    //     .then((auth) async{
    //   currentUser = auth.user;
    //   final dataSnapshot = await studentReference
    //       .doc(currentUser!.uid)
    //       .get();
    //     bool verified = dataSnapshot["Verified"];
    //
    //     if(verified == true){
    //       Get.offAll(const HomePage());
    //     }
    //     else{
    //       Navigator.pop(context);
    //       firebaseAuth.signOut();
    //       errorDialogue(
    //           context: context,
    //           title: "Something went wrong",
    //           bodyText: 'You are not a verified user');
    //     }
    //
    //   }).catchError((onError) {
    //     Navigator.pop(context);
    //     errorDialogue(
    //         context: context,
    //         title: "Something went wrong",
    //         bodyText: onError.message.toString());
    //   });
  }

  Future<void> resetPassword(String email, context) async {
    Map<String, dynamic> body = {"email": email};
    loadingDialogue(context: context);
    putJson(ApiUrl().forgetPassword, body, context).then((value) {
      if (value["success"]) {
        Get.offAll(const PasswordResetLinkSuccessfully(
          title: "Password Sent Successfully on Your Email",
        ));
      }
    });
  }

  void signOut() async {
    await firebaseAuth.signOut();
    await _googleSignIn.signOut();
    // Get.offAll(const WelcomeScreen());
  }

  Future<void> updateUserData(
      {String? name, date, city, mobile, state, profile, context}) async {
    await readDataFromHive();
    putJson(
        ApiUrl().updateUserUrl,
        {
          'name': name.toString(),
          'birth_date': date,
          'city': city,
          'mobile': mobile,
          'state': state,
          'profile': profile
        },
        context,
        headers: {
          'Content-Type': 'application/json',
          'user_access_token': token.toString()
        }).then((value) {
      if (value['success'] == true) {
        Get.back();
        Future.delayed(Duration.zero, () {
          final dataProvider =
              Provider.of<UserDataProvider>(context, listen: false);
          dataProvider.getData();
        });
        Navigator.pop(context);
        Get.snackbar(
             "Success",
            value['message']);
      } else {
        Get.back();
        errorDialogue(
            context: context,
            title: "Something went wrong",
            bodyText: value['message']);
      }
    });
  }

  // Get user data

  Future<dynamic> getUserData({String? header}) async {
    UserModel userModel;
    getJson(ApiUrl().getUser, headers: {"user_access_token": header.toString()})
        .then(
      (value) => {
        if (value["success"] == true)
          {
            print(value),
            enterDataToHive(
                keyName: "user-name", value: value["users"]['name']),
            enterDataToHive(
                keyName: "user-email", value: value["users"]['email']),
            enterDataToHive(keyName: "user-id", value: value["users"]['_id']),

            // UserModel.fromJson(value);

            // findTraderModel = FindTraderModel.fromJson(dataDecoded);
          },
        print("User Data : ${value["users"]['name']}")
      },
    );
  }
}
