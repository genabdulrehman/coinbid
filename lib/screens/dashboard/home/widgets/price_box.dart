import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/colors.dart';

class PriceBox extends StatelessWidget {
  final Color boxColor;
  final String url;
  final String price;
  final String title;
  final VoidCallback function;

  const PriceBox({required this.function, required this.boxColor,required this.url, required this.price ,required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: 160,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: boxColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Image(
                image: AssetImage(url),
                width: 45,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                  ),),
                  const SizedBox(height: 5,),
                  Text(price,
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
