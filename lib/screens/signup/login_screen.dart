
import 'package:coinbid/screens/signup/login_page.dart';
import 'package:coinbid/screens/signup/signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controllers/page_controller.dart';
import '../../constant/colors.dart';
import '../../widgets/customButton.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  final int index;
  const LoginScreen({required this.index , Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{

  late TabController _controller;
  int index = 0;

  @override
  void initState() {
    _controller = TabController(initialIndex:widget.index , length: 2, vsync: this);
    super.initState();
    index = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text(index == 0 ? "Welcome Back 👋🏻":'Let’s Join With Us 👋🏻',style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: kOrangeColor
              ),),
               SizedBox(height: h *.01),
              Text("Complete our energy-saving challenge and compete with your neighbors for the chance of",
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kTextColor
              ),),
              SizedBox(height: h *.035),
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: kLightBackgroundColor,
                    borderRadius: BorderRadius.circular(16)
                ),
                child: TabBar(
                  controller: _controller,
                  onTap: (i){
                    setState(() {
                      index = i;
                    });
                  },
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                    color: Colors.white,
                  ),
                  labelColor: Colors.black,
                  labelStyle: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff444545)
                  ),
                  unselectedLabelStyle: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff444545)
                  ),
                  unselectedLabelColor: const Color(0xff444545),
                  tabs: const [
                    Tab(
                      text: 'Login',
                    ),
                    Tab(
                      text: 'Sign up',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: const <Widget>[
                    LoginPage(),
                    SignUpPage()
                  ],
                ),
              ),

          // Container(
          //   height: 52,
          //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          //   decoration: BoxDecoration(
          //       color: kLightBackgroundColor,
          //       borderRadius: BorderRadius.circular(16)
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Container(
          //           height: 40,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(
          //               16.0,
          //             ),
          //             color: Colors.white,
          //           ),
          //           child: Center(
          //             child: Text("Login",
          //               style: GoogleFonts.nunito(
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.black
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: (){
          //             Navigator.of(context).push(PageCreateRoute().createRoute(const SignUpPage()),
          //             );
          //            // Navigator.of(context).pushReplacement(PageCreateRoute().createRoute(const SignUpPage()));
          //            // Get.to(const SignUpPage());
          //             // Navigator.push(
          //             //     context,
          //             //      MaterialPageRoute(
          //             //         builder: (BuildContext context) => const SignUpPage()));
          //             // Navigator.push(
          //             //   context,
          //             //   MaterialPageRoute(builder: (context) => const SignUpPage()),
          //             // );
          //           },
          //           child: Container(
          //             width: 150,
          //             height: 40,
          //             color: Colors.transparent,
          //             child: Center(
          //               child: Text("Sign up",
          //                 style: GoogleFonts.nunito(
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.black
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //     const LoginPage(),

            ],
          ),
        ),
      ),
    );
  }
}
