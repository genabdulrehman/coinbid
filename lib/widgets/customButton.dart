import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback clickFuction;
  final Color? buttonColor;
  const CustomButton({this.buttonColor,required this.title,required this.clickFuction});
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    return Container(
      height: 55,
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      child: MaterialButton(
        elevation: 0,
        color: buttonColor ?? kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: clickFuction,
        child: Text(title, style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),),
      ),
    );
  }
}