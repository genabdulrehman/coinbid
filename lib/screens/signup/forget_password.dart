import 'package:coinbid/Constant/constant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/colors.dart';
import '../../widgets/customButton.dart';
import '../../widgets/custom_textfield.dart';
import 'reset_link_successfully.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
        title: Text("Forget Password",style: GoogleFonts.nunito(
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
            Text("Enter your email address to get your password reset link and reset your password.",
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
            SizedBox(height: h *.035),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Back to",style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kGreyTextColor
                ),),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Text("login",style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      color: kOrangeColor
                  ),),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(title: 'Submit',
              clickFuction: (){
                if(_formKey.currentState!.validate()){
                  userController.resetPassword(_emailTextEditController.text, context);
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
