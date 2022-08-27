import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String title;
  final VoidCallback clickFuction;
  final String url;
   const CustomButtonWithIcon({required this.url ,required this.title,required this.clickFuction});
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    return Container(
      height: 55,
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      child: MaterialButton(
        splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: kBorderColor),
          borderRadius: BorderRadius.circular(30.0),

        ),
        onPressed: clickFuction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage(url),
              width: 25,
            ),
            const SizedBox(width: 7,),
            Text(title, style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black
            ),),
          ],
        )
      ),
    );
  }
}