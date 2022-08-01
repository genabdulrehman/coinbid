import 'package:coinbid/constant/colors.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '/Constant/constant.dart';
import 'package:flutter/material.dart';



loadingDialogue({context}){
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (c) {
        return AlertDialog(
          backgroundColor: Colors.white,
          insetPadding:const EdgeInsets.symmetric(horizontal: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(10.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 12,bottom: 12),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

