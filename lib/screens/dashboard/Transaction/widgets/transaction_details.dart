import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coinbid/Models/getTrasactions_model.dart';
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
                                  // backgroundImage: widget.transactions!.transactions?[i].from?.profile != null?NetworkImage(widget.transactions!.transactions?[i].from?.profile ??''):null,
                                  backgroundColor: kLightBackgroundColor,
                                  child: widget.transactions!.transactions?[i].from?.profile == null ? ClipOval(
                                    child: Image(
                                      image: AssetImage('images/profile.png'),
                                      width: 30,
                                    ),
                                  ):
                                  ClipOval(
                                    child: Image(
                                      image: NetworkImage(widget.transactions!.transactions?[i].from?.profile ??''),
                                      width: 40,
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
                                        color: widget.transactions?.transactions?[i].received == true
                                            ? kPrimaryColor
                                            : kOrangeColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                      child: Icon(
                                        widget.transactions?.transactions?[i].received == true
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
                                  widget.transactions?.transactions?[i].received == true
                                      ? "From ${widget.transactions?.transactions?[i].from?.name}"
                                      : " ${widget.transactions?.transactions?[i].from?.name}",
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.transactions?.transactions?[i].received == true
                                      ? "Received to My Account"
                                      : "Payment Transferred",
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
                                  color: widget.transactions?.transactions?[i].received == true
                                      ? const Color(0xffF4FFFC)
                                      : const Color(0xffFFFBF9)),
                              child: Center(
                                child: Text(
                                  "+\$${widget.transactions?.transactions?[i].price}",
                                  maxLines: 1,
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: widget.transactions?.transactions?[i].received == true
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
