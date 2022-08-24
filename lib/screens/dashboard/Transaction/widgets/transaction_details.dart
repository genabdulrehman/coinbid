import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coinbid/Models/getTrasactions_model.dart';

import '../../../../Models/transaction_model.dart';
import '../../../../constant/colors.dart';

class TransactionDetail extends StatefulWidget {
  final GetTransactionsModel? transactions;
  bool isLoading;

  TransactionDetail({
    Key? key,
    this.transactions,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: widget.isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  SizedBox(height: h * .02),
                  if (widget.transactions?.transactions?.length != null)
                    for (int i = 0;
                        i < widget.transactions!.transactions!.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  // backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
                                  backgroundColor: kLightBackgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipOval(
                                      child: Image(
                                        image: NetworkImage(
                                            "${widget.transactions!.transactions?[i].users?.profile}"),
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        color: true == true
                                            ? kPrimaryColor
                                            : kOrangeColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                      child: Icon(
                                        true == true
                                            ? Icons.call_received_rounded
                                            : Icons.call_made_outlined,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  true == true
                                      ? "From ${widget.transactions?.transactions?[i].users?.name}"
                                      : " widget.transactions[i].user",
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  true == true
                                      ? "${widget.transactions?.transactions?[i].transaction}"
                                      : "${widget.transactions?.transactions?[i].transaction} Payment Transfered",
                                  // overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: kTextColor),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 66,
                              height: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: true == true
                                      ? const Color(0xffF4FFFC)
                                      : const Color(0xffFFFBF9)),
                              child: Center(
                                child: Text(
                                  "${widget.transactions?.transactions?[i].transaction}",
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: true == true
                                          ? kPrimaryColor
                                          : kOrangeColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                ],
              ));
  }
}
