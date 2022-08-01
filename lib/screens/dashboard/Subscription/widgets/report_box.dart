import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/colors.dart';

class ReportBox extends StatelessWidget {
  final String title;
  final String date;
  final String url;
  final int addons;
  const ReportBox(this.title,this.date,this.url,this.addons , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 7),
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.06),
                spreadRadius: 4,
                blurStyle: BlurStyle.normal,
                blurRadius: 30,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color:Colors.black
              ),),
              const SizedBox(height: 5,),
              Text(date,style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color:const Color(0xffC8C7C6)
              ),),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text("$addons Addons",style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color:Colors.black
                  ),),
                  const Spacer(),
                  Image(
                    image: AssetImage(url),
                    width: 40,
                  ),

                ],
              )
            ],
          )
      ),
    );
  }
}