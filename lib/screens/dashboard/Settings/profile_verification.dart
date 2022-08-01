import 'package:coinbid/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/colors.dart';

class ProfileVerification extends StatefulWidget {
  const ProfileVerification({Key? key}) : super(key: key);

  @override
  State<ProfileVerification> createState() => _ProfileVerificationState();
}

class _ProfileVerificationState extends State<ProfileVerification> {
  @override
  Widget build(BuildContext context) {
    final h =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(13),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              width: 10,
              height: 10,

              decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: const Center(child: Icon(Icons.arrow_back_ios , color: Colors.black,size: 10,)),
            ),
          ),
        ),
        title: Text("Profile Verification",style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: h *.02),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xffFDF6F0),
              ),
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('images/verify_badge.png'),
                    width: 100,
                  ),
                  Text("For Verified Badge you must eligible to our Terms",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: const Color(0xff5C5956)
                  ),),
                  SizedBox(height: h *.02),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffFDF6F0),
                            ),
                            child: Text("Atleast 3  Use this app for 3 months",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kOrangeColor
                              ),),
                          ),
                          SizedBox(height: h *.015),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffFDF6F0),
                            ),
                            child: Text("Age should be 18+",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kOrangeColor
                              ),),
                          ),
                          SizedBox(height: h *.015),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffFDF6F0),
                            ),
                            child: Text("Min withdrawal  20,000 ",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kOrangeColor
                              ),),
                          ),
                        ],
                      )
                  ),
                ],
              )
            ),
            const Spacer(),
            CustomButton(
                title: 'Raise A Request',
                clickFuction: (){}),
            SizedBox(height: h *.02),
          ],
        ),
      ),
    );
  }
}
