
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

errorDialogue(
    {required BuildContext context,
      required String title,
      required String bodyText,
      String? imageUrl}) {
  showDialog(
      barrierDismissible: false,
      //barrierColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Builder(
          builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              //height: MediaQuery.of(context).size.height/boxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'images/Close.png',
                            color: Colors.black,
                            width: 15,
                          ))),
                  Row(
                    children: [
                      Image.asset(
                        imageUrl ?? 'images/something_wrong_icon.png',
                        color: Colors.black,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(
                    thickness: 0.7,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    bodyText,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            );
          },
        ),
      ));
}

