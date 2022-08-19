import 'package:coinbid/Controllers/withdraw_controller.dart';
import 'package:coinbid/constant/constant.dart';
import 'package:coinbid/provider/getWallet_provider.dart';
import 'package:coinbid/widgets/customButton.dart';
import 'package:coinbid/widgets/error_dialogue.dart';
import 'package:coinbid/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant/colors.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final TextEditingController _money = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? amount;
    final w = MediaQuery.of(context).size.width.toInt();
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(height: h * .035),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.07),
                    spreadRadius: 3,
                    blurStyle: BlurStyle.normal,
                    blurRadius: 20,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Exchange",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(height: h * .025),
                  const ExchangeBox(
                    url: 'images/coin.png',
                    title: 'Coin',
                    label: 'No of Coins',
                    color: kSecondaryColor,
                  ),
                  SizedBox(height: h * .025),
                  const ExchangeBox(
                    url: 'images/price_icon.png',
                    title: 'Price',
                    label: 'Enter your price',
                    color: kOrangeColor,
                  ),
                  SizedBox(height: h * .035),
                  CustomButton(title: "Submit", clickFuction: () {})
                ],
              ),
            ),
            SizedBox(height: h * .035),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.07),
                    spreadRadius: 3,
                    blurStyle: BlurStyle.normal,
                    blurRadius: 20,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Withdraw",
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(height: h * .025),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: TextFormField(
                      controller: _money,
                      onChanged: (value) {
                        setState(() {
                          amount = value;
                          print("Amount : $amount");
                        });
                      },
                      cursorColor: Colors.black,
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Enter withdrawal amount',
                        filled: true,
                        fillColor: kLightBackgroundColor,
                        hintStyle: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kTextColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: h * .035),
                  Container(
                    height: 55,
                    width: double.infinity,
                    margin: const EdgeInsets.all(0),
                    child: MaterialButton(
                      elevation: 0,
                      splashColor: kPrimaryColor.withOpacity(.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: kPrimaryColor)),
                      onPressed: () async {
                        try {
                          // loadingDialogue(context: context);
                          await withdrawAmountController.withdrawAmount(
                              money: _money.text, context: context);

                          // Get.back();
                          _money.text = "";
                        } catch (e) {
                          errorDialogue(
                              context: context,
                              title: "Error",
                              bodyText: e.toString());
                        }
                      },
                      child: Text(
                        'Submit',
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * .035),
          ],
        ),
      ),
    );
  }
}

class ExchangeBox extends StatelessWidget {
  final String url;
  final String title;
  final String label;
  final Color color;
  const ExchangeBox(
      {required this.color,
      required this.url,
      required this.title,
      required this.label,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: kLightBackgroundColor,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Image(
                      image: AssetImage(url),
                      width: 13,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.end,
              cursorColor: Colors.black,
              style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: label,
                hintStyle: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kTextColor),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
