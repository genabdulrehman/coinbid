import 'dart:async';

import 'package:coinbid/Constant/constant.dart';
import 'package:coinbid/Models/UserModel.dart';
import 'package:coinbid/widgets/error_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

import '../../constant/colors.dart';
import '../../widgets/customButton.dart';
import '../../widgets/loading_widget.dart';

class OtpVerificationCode extends StatefulWidget {
  final UserModel userModel;
  const OtpVerificationCode({
    required this.userModel,
    Key? key}) : super(key: key);

  @override
  State<OtpVerificationCode> createState() => _OtpVerificationCodeState();
}

class _OtpVerificationCodeState extends State<OtpVerificationCode> {
  String codeValue = '';
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final formKey = GlobalKey<FormState>();

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    startTimer();
  }


  @override
  void dispose() {
    _timer.cancel();
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(13),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              width: 10,
              height: 10,

              decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: const Center(child: Icon(Icons.arrow_back_ios , color: Colors.black,size: 10,)),
            ),
          ),
        ),
        title: Text("OTP Verification",style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black
        ),),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            SizedBox(height: h *.035),
            Text(_start.toString(),style: GoogleFonts.nunito(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),),
            SizedBox(height: h *.01),
            SizedBox(
              width: w*.7,
              child: Text("We sent your otp verification code to your mobile no let’s input it..",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: kTextColor
                ),),
            ),
            SizedBox(height: h *.016),
           _start == 0 ? GestureDetector(
              onTap: (){
               _start = 60;
                startTimer();
               textEditingController.clear();
               userController.resendOtp(widget.userModel.phoneNo ??'', context);
              },
              child: SizedBox(
                height: 30,
                child: Center(
                  child: Text("Not sent yet?",style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      color: kOrangeColor
                  ),),
                ),
              ),
            ):Container(),
            SizedBox(height: h *.030),
            // Form(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         OtpBox(
            //           controller: value1,
            //           onChange: (value){
            //           if(value.length == 1){
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },),
            //         OtpBox(
            //           controller: value2,
            //           onChange: (value){
            //           if(value.length == 1){
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },),
            //         OtpBox(
            //           controller: value3,
            //           onChange: (value){
            //           if(value.length == 1){
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },),
            //         OtpBox(
            //           controller: value4,
            //           onChange: (value){
            //           if(value.length == 1){
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },),
            //         OtpBox(
            //           controller: value5,
            //           onChange: (value){
            //           if(value.length == 1){
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },),
            //         OtpBox(
            //           controller: value6,
            //           onChange: (value){
            //           if(value.length == 1){
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },),
            //
            //
            //       ],
            //     )),
            Form(
              key: formKey,
              child: PinCodeTextField(
                length: 6,
                obscureText: false,
                cursorColor: Colors.black,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                textStyle: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  inactiveFillColor: kLightBackgroundColor,
                  activeColor: kPrimaryColor,
                  inactiveColor: kLightBackgroundColor,
                  selectedColor: kPrimaryColor,
                  selectedFillColor: kLightBackgroundColor,
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
               // backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    codeValue = value;
                  });
                },
                appContext: context,
              ),
            ),
            // SizedBox(height: h *.035),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(widget.userModel.email ??'',style: GoogleFonts.nunito(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         decoration: TextDecoration.underline,
            //         color: Colors.black
            //     ),),
            //     const SizedBox(width: 5,),
            //     GestureDetector(
            //       onTap: (){},
            //       child: const Image(
            //         image: AssetImage('images/edit.png'),
            //         width: 17,
            //       ),
            //     ),
            //   ],
            // ),
            const Spacer(),
            CustomButton(title: 'Continue',
              clickFuction: () async{

                if(codeValue.length != 6){
                  errorController!.add(ErrorAnimationType
                      .shake);
                }
                else{
                  loadingDialogue(context: context);
                  userController.verifyOtp(widget.userModel.phoneNo ??'', codeValue).then((value) {
                    if (value.successful == true) {
                      if (value.verification?.status == VerificationStatus.approved) {
                        userController.signUp(widget.userModel, context);
                      } else {
                        Navigator.pop(context);
                        errorController!.add(ErrorAnimationType
                            .shake);
                      }
                    } else {
                      Navigator.pop(context);
                      errorDialogue(
                          context: context,
                          title: "Something went wrong",
                          bodyText: value.errorMessage.toString());
                    }
                 });


                }

                 // Triggering error shake animation


              },
            ),
            SizedBox(height: h *.045),

          ],
        ),
      ),
    );
  }
}



class OtpBox extends StatelessWidget {
  final Function onChange;
  final TextEditingController controller;
  const OtpBox({
    required this.controller,
    required this.onChange,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: Colors.black,
        onChanged:  (value) => onChange(value),
        style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: kLightBackgroundColor,
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
