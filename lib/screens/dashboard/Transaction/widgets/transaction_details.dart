import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Models/transaction_model.dart';
import '../../../../constant/colors.dart';

class TransactionDetail extends StatefulWidget {
  final RxList<TransactionModel> transactions;


  const TransactionDetail({
    required this.transactions,
    Key? key}) : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    final h =MediaQuery.of(context).size.height;
    return Obx(() =>  SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: h *.02),
          for(int i=0;i<widget.transactions.length;i++)
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
                              image: AssetImage(widget.transactions[i].url),
                              width: 30,
                            ),),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                              color: widget.transactions[i].receive == true ? kPrimaryColor:kOrangeColor,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(
                            child: Icon(
                              widget.transactions[i].receive == true ? Icons.call_received_rounded:Icons.call_made_outlined,
                              color: Colors.white,
                              size: 10,),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 13,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.transactions[i].receive == true ? "From ${widget.transactions[i].user}" : widget.transactions[i].user,style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),),
                      const SizedBox(height: 5,),
                      Text(widget.transactions[i].receive == true ? "${widget.transactions[i].time} Received to My Account":"${widget.transactions[i].time} Payment Transfered",
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: kTextColor
                        ),),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 66,
                    height: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: widget.transactions[i].receive == true ? const Color(0xffF4FFFC):const Color(0xffFFFBF9)
                    ),
                    child: Center(
                      child: Text("+\$${widget.transactions[i].amount.round()}",style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: widget.transactions[i].receive == true ? kPrimaryColor:kOrangeColor
                      ),),
                    ),
                  ),

                ],
              ),
            )
        ],
      )

    ));
  }
}
