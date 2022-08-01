import 'package:coinbid/screens/signup/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/colors.dart';
import '../../widgets/customButton.dart';


class PasswordResetLinkSuccessfully extends StatefulWidget {
  final String title;
  const PasswordResetLinkSuccessfully({required this.title , Key? key}) : super(key: key);

  @override
  State<PasswordResetLinkSuccessfully> createState() => _PasswordResetLinkSuccessfullyState();
}

class _PasswordResetLinkSuccessfullyState extends State<PasswordResetLinkSuccessfully> {
  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h *.15),
             Image(
              image: const AssetImage('images/success.png'),
              width: w*.5,
            ),
            SizedBox(height: h *.1),
            SizedBox(
              width: w*.4,
              child: Text(widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),),
            ),
            SizedBox(height: h *.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Complete our energy-saving challenge and compete with your neighbors for the chance of",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: kTextColor
                ),),
            ),
            SizedBox(height: h *.035),
            const Spacer(),
            CustomButton(title: 'Back to Login',
              clickFuction: (){
              Get.offAll(const LoginScreen(index: 0,));
              },
            ),
            SizedBox(height: h *.045),
          ],
        ),
      ),
    );
  }
}
