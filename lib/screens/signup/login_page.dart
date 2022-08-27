import 'package:coinbid/Constant/constant.dart';
import 'package:coinbid/Controllers/user_controller.dart';
import 'package:coinbid/screens/dashboard/home/home_screen.dart';
import 'package:coinbid/widgets/custom_button_icon.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../constant/colors.dart';
import '../../widgets/customButton.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_dialogue.dart';
import '../../widgets/loading_widget.dart';
import '../dashboard/home_page.dart';
import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTextEditController =
      TextEditingController();

  final TextEditingController _passwordTextEditController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  void visibility() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextEditController.dispose();
    _passwordTextEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width.toInt();
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: h * 0.035,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                      controller: _emailTextEditController,
                      label: 'Email',
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Please enter your email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'email address is not valid';
                        }
                        return null;
                      },
                      hintText: "Email"),
                  SizedBox(
                    height: h * 0.035,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditController,
                    label: 'Password',
                    hideText: obscure,
                    trailingIcon: obscure
                        ? IconButton(
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: kGreyTextColor,
                            ),
                            onPressed: visibility,
                          )
                        : IconButton(
                            onPressed: visibility,
                            icon: const Icon(
                              Icons.visibility_off,
                              color: kGreyTextColor,
                            )),
                    hintText: "Password",
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ],
              )),
          SizedBox(
            height: h * 0.01,
          ),
          GestureDetector(
            onTap: () {
              Get.to(const ForgetPassword());
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forget Password?",
                style: GoogleFonts.nunito(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                    color: kGreyTextColor),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.18,
          ),
          CustomButton(
            title: 'Log in',
            clickFuction: () {
              if (_formKey.currentState!.validate()) {
                userController.logIn(_emailTextEditController.text,
                    _passwordTextEditController.text, context);

                // UserController.instance.getUser();
              }
            },
          ),
          SizedBox(
            height: h * 0.035,
          ),
          Row(
            children: [
              const Expanded(
                child: Divider(
                  color: kBorderColor,
                  thickness: 1,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Log in with google",
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: kGreyTextColor),
              ),
              const SizedBox(
                width: 5,
              ),
              const Expanded(
                child: Divider(
                  color: kBorderColor,
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.035,
          ),
          CustomButtonWithIcon(
              url: 'images/google.png',
              title: 'Continue with google',
              clickFuction: () async{
                loadingDialogue(context: context);
                await userController
                    .signInWithGoogle()
                    .then((value) {
                  User? user = value.user;
                  if (user != null) {
                    print(user.displayName);
                   userController.signUpAfterGoogleLogin(
                       user.displayName ?? '',
                       user.email ?? '',
                       user.photoURL ?? '',
                       context);
                  }
                }).catchError((onError) {
                  Navigator.of(context).pop();
                  errorDialogue(
                    context: context,
                    title: "Something went wrong",
                    bodyText:
                    onError.message.toString(),
                  );
                });
              }),
        ],
      ),
    );
  }
}
