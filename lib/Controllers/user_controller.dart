import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinbid/api/http.dart';
import 'package:coinbid/screens/signup/otp_verification_code.dart';
import 'package:coinbid/widgets/error_dialogue.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

import '../Models/UserModel.dart';
import '../api/config.dart';
import '../screens/dashboard/home_page.dart';
import '../screens/signup/reset_link_successfully.dart';
import '/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class UserController extends GetxController{
  static UserController instance = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  Rx<UserModel> userData = UserModel().obs;
  User? currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference studentReference =
  FirebaseFirestore.instance.collection('Users');



  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //binding all Streams
    currentUser = user;
    if (currentUser != null) {
      userData.bindStream(listenToUser());

    }
  }

  Stream<UserModel> listenToUser() =>
      studentReference.doc(firebaseUser.value?.uid)
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data() as Map<String, dynamic>));



  Future<void> signUp(UserModel userModel,context,) async {

    postJson(
        ApiUrl().signupUrl,
        {
          "name":userModel.name,
          "email":userModel.email,
          "password":userModel.password,
          "verified":true
        }
    ).then((value) {
      if(value['success'] == true){
            Navigator.pop(context);
            Get.offAll( () => const PasswordResetLinkSuccessfully(title: "User Signup successfully",));
      }
      else{
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

Future<void> sendOtp(UserModel userModel,context) async{
  loadingDialogue(context: context);
  await ApiConfig().twilioPhoneVerify.sendSmsCode(userModel.phoneNo ??'').then((value) {
    if (value.successful == true)  {
      Navigator.pop(context);
      Get.to(OtpVerificationCode(userModel: userModel,));
    } else {
      Navigator.pop(context);
      errorDialogue(
          context: context,
          title: "Something went wrong",
          bodyText: value.errorMessage.toString());
    }
  });
}
  Future<void> resendOtp(String phoneNo,context) async{
    loadingDialogue(context: context);
    await ApiConfig().twilioPhoneVerify.sendSmsCode(phoneNo).then((value) {
      if (value.successful == true)  {
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

Future<TwilioResponse>  verifyOtp(String phoneNo, String otpCode) async{
  var twilioResponse = await ApiConfig().twilioPhoneVerify.verifySmsCode(
      phone: phoneNo,
      code: otpCode);
  return twilioResponse;
}
  // Future<void> verifyPhoneNumber(String phoneNumber , context, UserModel userModel) async {
  //   loadingDialogue(context: context);
  //   await firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential authCredential) {
  //         otpCode = authCredential.smsCode.toString();
  //         print(otpCode);
  //         Navigator.of(context).pop();
  //         Get.to(() => OtpVerificationCode(
  //             userModel: userModel,
  //             otpCode: otpCode,
  //             verificationCode: verificationId));
  //       },
  //       verificationFailed: (FirebaseAuthException error){
  //         Navigator.pop(context);
  //         errorDialogue(
  //             context: context,
  //             title: "Something went wrong",
  //             bodyText: error.message.toString());
  //         print(error.message);
  //
  //       },
  //
  //       codeSent: (String id , int? token) {
  //
  //         verificationId = id;
  //         print(token.toString());
  //         Navigator.pop(context);
  //         Get.to(() => OtpVerificationCode(
  //             userModel: userModel,
  //             otpCode: otpCode,
  //             verificationCode: verificationId));
  //         // errorDialogue(
  //         //     context: context,
  //         //     imageUrl: 'images/correct.png',
  //         //     title: "Successfully",
  //         //     bodyText: "Code Send Successfully");
  //       },
  //     codeAutoRetrievalTimeout: (String verification) {
  //       debugPrint("timeout");
  //       debugPrint("sms code auto retrieval");
  //
  //       verificationId = verification;
  //       Navigator.pop(context);
  //       errorDialogue(
  //           context: context,
  //           title: "Something went wrong",
  //           bodyText: 'Timed out waiting for SMS.');
  //       debugPrint("_codeAutoRetrievalTimeout $verification");
  //     },
  //
  //       );
  // }


  Future<void> logIn(
      String email, password, context) async {
    loadingDialogue(context: context);
    postJson(
        ApiUrl().loginUrl,
        {
          "email":email,
          "password":password
        }
    ).then((value) {
      if(value['success'] == true){

        print(value['token']);
        Navigator.pop(context);
        Get.offAll(const HomePage());
      }
      else{
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
    loadingDialogue(context: context);
    await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.pop(context);
      Get.offAll( const PasswordResetLinkSuccessfully(title: "Link Send Successfully",));
    }).catchError((error) {
      Navigator.pop(context);
      errorDialogue(
          context: context,
          title: "Something went wrong",
          bodyText: error.message.toString());
    });
  }

  void  signOut ()async{
    await firebaseAuth.signOut();
   // Get.offAll(const WelcomeScreen());
  }

  Future<void> updateUserData(Map<String, dynamic> data,context) async{
    await studentReference.doc(currentUser?.uid).update(
        data
    ).then((value) {
      Get.snackbar(
        "Successfully",
        "Details of student updated successfully",
        backgroundColor: const Color(0x85ffffff),
      );
    }
    ).catchError((e){
      Navigator.pop(context);
      errorDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }
}