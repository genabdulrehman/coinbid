import 'package:coinbid/screens/dashboard/home/tab_page/buy.dart';
import 'package:coinbid/screens/dashboard/home/tab_page/exchange.dart';
import 'package:coinbid/screens/dashboard/home/widgets/price_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../provider/getWallet_provider.dart';

class ExchangeCoinScreen extends StatefulWidget {
  const ExchangeCoinScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeCoinScreen> createState() => _ExchangeCoinScreenState();
}

class _ExchangeCoinScreenState extends State<ExchangeCoinScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<GetWalletProvider>(context, listen: false).getwallet();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider =
        Provider.of<GetWalletProvider>(context, listen: true).getWalletModel;
    final walletLoading =
        Provider.of<GetWalletProvider>(context, listen: true).isLoading;

    final w = MediaQuery.of(context).size.width.toInt();
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(13),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(30)),
              child: const Center(
                  child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 10,
              )),
            ),
          ),
        ),
        title: Text(
          "Exchange Coins",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: h * .03),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: PriceBox(
                  boxColor: kOrangeColor,
                  url: 'images/curency.png',
                  price: '\$ ${walletProvider?.wallets?.price}',
                  title: 'Total Cash',
                  function: () {},
                )),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: PriceBox(
                  boxColor: kSecondaryColor,
                  url: 'images/star.png',
                  price: '${walletProvider?.wallets?.coins}',
                  title: 'Total Coins',
                  function: () {},
                ))
              ],
            ),
          ),
          SizedBox(height: h * .035),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: kLightBackgroundColor,
                  borderRadius: BorderRadius.circular(30)),
              child: TabBar(
                controller: _controller,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                labelColor: Colors.black,
                labelStyle: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff444545)),
                unselectedLabelStyle: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kTextColor),
                unselectedLabelColor: kTextColor,
                tabs: const [
                  Tab(
                    text: 'Exchange',
                  ),
                  Tab(
                    text: 'Buy',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: const <Widget>[
                ExchangePage(),
                BuyCoinPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
