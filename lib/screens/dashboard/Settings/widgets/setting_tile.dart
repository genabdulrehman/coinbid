import 'package:coinbid/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String url;
  final VoidCallback function;
  const SettingTile({required this.function , required this.title,required this.url ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kLightBackgroundColor
              ),
              child:  Center(child:Image(
                image: AssetImage(url),
                width: 15,
              ),
              ),
            ),
            const SizedBox(width: 15,),
            Text(title,style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black
            ),),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15,
            )
          ],

        ),
      ),
    );
  }
}
