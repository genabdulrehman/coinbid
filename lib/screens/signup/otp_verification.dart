import 'package:coinbid/constant/colors.dart';
import 'package:coinbid/screens/signup/otp_verification_code.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/customButton.dart';
import '../../widgets/custom_textfield.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController _emailTextEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h *.01),
            Text("Enter your email address to get your otp verification code and submit on it.",
              style: GoogleFonts.nunito(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kTextColor
              ),),
            SizedBox(height: h *.035),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: _emailTextEditController,
                        label: 'Email Address',
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          else if(!EmailValidator.validate(value)){
                            return 'email address is not valid';
                          }
                          return null;
                        },
                        hintText: "Email Address"),
                  ],
                )),
            Spacer(),
            CustomButton(title: 'Continue',
              clickFuction: (){
                if(_formKey.currentState!.validate()){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => OtpVerificationCode(email: _emailTextEditController.text,)),
                  // );
                }
              },
            ),
            SizedBox(height: h *.045),
          ],
        ),
      ),
    );
  }
}
