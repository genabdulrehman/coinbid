import 'package:coinbid/Models/UserModel.dart';
import 'package:coinbid/constant/colors.dart';
import 'package:coinbid/constant/constant.dart';
import 'package:coinbid/screens/signup/login_screen.dart';
import 'package:coinbid/screens/signup/otp_verification.dart';
import 'package:coinbid/screens/signup/otp_verification_code.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

import '../../Controllers/page_controller.dart';
import '../../widgets/customButton.dart';
import '../../widgets/custom_button_icon.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_dialogue.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailTextEditController = TextEditingController();
  final TextEditingController _nameTextEditController = TextEditingController();
  final TextEditingController _confirmPasswordTextEditController = TextEditingController();
  final TextEditingController _phoneNumberTextEditController = TextEditingController();
  final TextEditingController _passwordTextEditController = TextEditingController();

   final TwilioPhoneVerify _twilioPhoneVerify = TwilioPhoneVerify(
  accountSid: 'AC51ff97ecacf05e992f25df3699aa34be', // replace with Account SID
  authToken: 'e0f7d481f847c74b6dc5a8a43073ad0f',  // replace with Auth Token
  serviceSid: 'VA1b8f6a2f3b89045812d191de8638b55c' // replace with Service SID
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  void visibility(){
    setState(() {
      obscure = !obscure;
    });
  }
  bool obscure1 = true;

  void visibility1(){
    setState(() {
      obscure1 = !obscure1;
    });
  }
  // String validateMobile(String value) {
  //   String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value.length == 0) {
  //     return 'Please enter mobile number';
  //   }
  //   else if (!regExp.hasMatch(value)) {
  //     return 'Please enter valid mobile number';
  //   }
  //   return null;
  // }
  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h*0.030,),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                      controller: _nameTextEditController,
                      label: 'Name',
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      hintText: "Name"),
                  SizedBox(height: h*0.020,),
                  CustomTextField(
                      controller: _emailTextEditController,
                      label: 'Email',
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        else if(!EmailValidator.validate(value)){
                          return 'email address is not valid';
                        }
                        return null;
                      },
                      hintText: "Email"),
                  SizedBox(height: h*0.020,),
                  CustomTextField(
                    textInputType: TextInputType.phone,
                      controller: _phoneNumberTextEditController,
                      label: 'Mobile No',
                      validator: (value) {
                        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = RegExp(pattern);
                        if (value.length == 0) {
                          return 'Please enter mobile number';
                        }
                        else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                      hintText: "+91.."),
                  SizedBox(height: h*0.020,),
                  CustomTextField(
                    controller: _passwordTextEditController,
                    label: 'Password',
                    hideText: obscure,
                    trailingIcon: obscure ? IconButton(
                      icon: const Icon(Icons.remove_red_eye,
                        color: kGreyTextColor,),
                      onPressed: visibility,
                    ) : IconButton
                      (onPressed: visibility,
                        icon: const Icon(Icons.visibility_off,
                          color: kGreyTextColor,
                        )),
                    hintText: "Password",
                    validator:(value) {
                      if (value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'password should be at least 6 characters';
                      }
                      return null;
                    },),
                  SizedBox(height: h*0.020,),
                  CustomTextField(
                    controller: _confirmPasswordTextEditController,
                    label: 'Confirm Password',
                    hideText: obscure1,
                    trailingIcon: obscure1 ? IconButton(
                      icon: const Icon(Icons.remove_red_eye,
                        color: kGreyTextColor,),
                      onPressed: visibility1,
                    ) : IconButton
                      (onPressed: visibility1,
                        icon: const Icon(Icons.visibility_off,
                          color: kGreyTextColor,
                        )),
                    hintText: "Confirm Password",
                    validator:(value) {
                      if (value.trim().isEmpty) {
                        return 'Please enter your confirm password';
                      }
                      if (value != _passwordTextEditController.text) {
                        return 'password and confirm password must be matched';
                      }
                      return null;
                    },),
                ],
              )),

          SizedBox(height: h*0.035,),
          CustomButton(title: 'Sign Up',
            clickFuction: () async{
              if(_formKey.currentState!.validate()){
                UserModel userModel = UserModel(
                    name: _nameTextEditController.text,
                    password: _passwordTextEditController.text,
                    phoneNo: _phoneNumberTextEditController.text,
                    email: _emailTextEditController.text
                );
               //  userController.verifyPhoneNumber(_phoneNumberTextEditController.text,context,userModel);
                userController.sendOtp(userModel, context);
              }
            },
          ),
          SizedBox(height: h*0.035,),
          Row(
            children: [
              const Expanded(
                child: Divider(
                  color: kBorderColor,
                  thickness: 1,
                ),
              ),
              const SizedBox(width: 5,),
              Text("Sign up with google or Facebook",style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: kGreyTextColor
              ),),
              const SizedBox(width: 5,),
              const Expanded(
                child: Divider(
                  color: kBorderColor,
                  thickness: 1,
                ),
              ),

            ],
          ),
          SizedBox(height: h*0.035,),
          Row(
            children: [
              Expanded(
                child: CustomButtonWithIcon(url: 'images/facebook.png',
                    title: 'Facebook',
                    clickFuction: (){}),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: CustomButtonWithIcon(url: 'images/google.png',
                    title: 'Google',
                    clickFuction: (){}),
              ),

            ],
          )

        ],
      ),
    );
  }
}
