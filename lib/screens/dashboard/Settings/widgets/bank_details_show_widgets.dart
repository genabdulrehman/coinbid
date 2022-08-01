import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetailsWidget extends StatelessWidget {
  final String type;
  final String data;
  const BankDetailsWidget({
    required this.type,
    required this.data,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: RichText(
        text: TextSpan(
            text: type.toUpperCase(),
            style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white
            ),
            children: <TextSpan>[
              TextSpan(text: "  $data",
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                ),
              )
            ]
        ),
      ),
    );
  }
}