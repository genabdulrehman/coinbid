import 'package:coinbid/constant/constant.dart';
import 'package:coinbid/screens/dashboard/Transaction/widgets/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../provider/transations_provider.dart';
import '../home/tab_page/buy.dart';
import '../home/tab_page/exchange.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    Future.delayed(Duration.zero, () {
      Provider.of<TransactionsProvider>(context, listen: false)
          .getTransationsToday();
      Provider.of<TransactionsProvider>(context, listen: false)
          .getTransations();
      Provider.of<TransactionsProvider>(context, listen: false)
          .getTransationsYesterday();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transationsProvider =
        Provider.of<TransactionsProvider>(context, listen: true)
            .transactionModel;
    final transationsTodayProvider =
        Provider.of<TransactionsProvider>(context, listen: true)
            .transactionTodayModel;
    final transationsYesterdayProvider =
        Provider.of<TransactionsProvider>(context, listen: true)
            .transactionYesterdayModel;
    final isLoading =
        Provider.of<TransactionsProvider>(context, listen: true).isLoading;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * .02),
            Container(
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
                    text: 'Today',
                  ),
                  Tab(
                    text: 'Yesterday',
                  ),
                  Tab(
                    text: 'All',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: <Widget>[
                  TransactionDetail(
                      isLoading: isLoading,
                      transactions: transationsTodayProvider),
                  TransactionDetail(
                      isLoading: isLoading,
                      transactions: transationsYesterdayProvider),
                  TransactionDetail(
                      isLoading: isLoading, transactions: transationsProvider),
                  // TransactionDetail(
                  //     transactions: transactionController.transactions),
                  // TransactionDetail(
                  //     transactions: transactionController.transactions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
