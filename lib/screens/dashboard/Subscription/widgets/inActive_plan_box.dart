import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Models/price_plan_model.dart';
import '../../../../constant/colors.dart';

class InactivePlaneBox extends StatelessWidget {
  final String url;
  final String title;
  final String price;
  const InactivePlaneBox({
    Key? key,
    required this.url,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
          height: 82,
          padding:
              const EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.07),
                spreadRadius: 3,
                blurStyle: BlurStyle.normal,
                blurRadius: 20,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: const Color(0xffFFF7F1),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Image(
                    image: AssetImage(url),
                    width: 18,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Rs.${price}",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    border: Border.all(color: kGreyTextColor),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ],
          )),
    );
  }
}
