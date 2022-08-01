import 'package:coinbid/constant/colors.dart';
import 'package:coinbid/screens/signup/login_screen.dart';
import 'package:coinbid/screens/signup/signup_page.dart';
import 'package:coinbid/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controllers/page_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        children: [
          const Center(
            child: Image(
                image: AssetImage('images/mockup.png')),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: h*.37,
              decoration: const BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: h *.05),
                    Text("Watch Full Videos & Get Rewards",style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),),
                    SizedBox(height: h *.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Complete our energy-saving challenge and compete with your neighbors for the chance of",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kTextColor
                      ),),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(child: CustomButton(title: 'Log in', clickFuction: (){
                          Get.to(const LoginScreen(index: 0,));
                        })),
                        const SizedBox(width: 10,),
                        Expanded(child: CustomButton(title: 'Sign up',buttonColor: kSecondaryColor, clickFuction: (){
                          Get.to(const LoginScreen(index: 1,));
                        })),

                      ],
                    ),
                    SizedBox(height: h *.06),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
