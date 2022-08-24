import 'package:coinbid/Models/UserModel.dart';
import 'package:coinbid/constant/colors.dart';
import 'package:coinbid/constant/constant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../widgets/customButton.dart';
import '../../widgets/custom_button_icon.dart';
import '../../widgets/custom_textfield.dart';


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
  bool active = false;
  String phoneNo = '';


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
                  IntlPhoneField(
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),
                    dropdownTextStyle: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),
                    onTap: (){
                      setState(() {
                        active = true;
                      });
                    },
                    decoration: InputDecoration(
                     // labelText: 'Phone Number',
                      label: active == true ? Text('Phone Number' , style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor
                    ),):null,
                      labelStyle: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor
                    ),
                      hintStyle: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffB9B9BD)
                      ),
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xffE1E1E5), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xffE1E1E5), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                      phoneNo = phone.completeNumber;
                    },
                  ),
                  // CustomTextField(
                  //   textInputType: TextInputType.phone,
                  //     controller: _phoneNumberTextEditController,
                  //     label: 'Mobile No',
                  //     validator: (value) {
                  //       String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                  //       RegExp regExp = RegExp(pattern);
                  //       if (value.length == 0) {
                  //         return 'Please enter mobile number';
                  //       }
                  //       else if (!regExp.hasMatch(value)) {
                  //         return 'Please enter valid mobile number';
                  //       }
                  //       return null;
                  //     },
                  //     hintText: "+91.."),
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
                print(phoneNo);
                UserModel userModel = UserModel(
                    name: _nameTextEditController.text,
                    password: _passwordTextEditController.text,
                    phoneNo: phoneNo,
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
          ),
          SizedBox(height: h*0.020,),
        ],
      ),
    );
  }
}
