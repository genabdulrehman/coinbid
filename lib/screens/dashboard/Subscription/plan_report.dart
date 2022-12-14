import 'package:coinbid/screens/dashboard/Subscription/widgets/report_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/colors.dart';
import '../home/widgets/play_ads.dart';

class PlanReport extends StatefulWidget {
  const PlanReport({Key? key}) : super(key: key);

  @override
  State<PlanReport> createState() => _PlanReportState();
}

class _PlanReportState extends State<PlanReport> {
  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
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
        title: Text("Plan Report",style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h *.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Active Plan - Platinum",style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                        const SizedBox(height: 5,),
                        Text('Rs.500',style: GoogleFonts.nunito(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: (){
                         // Navigator.of(context).push(PageCreateRoute().createRoute(const PlanReport()));
                        },
                        child: Container(
                          height: 24,
                          width: 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffECECEC)
                          ),
                          child: Center(
                            child: Text('Change Plan',style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: h *.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Container(
              height: 82,
              padding: const EdgeInsets.only(left: 10,right: 10 ,top: 5 , bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.07),
                    spreadRadius: 3,
                    blurStyle: BlurStyle.normal,
                    blurRadius: 20,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
                  child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffFFF7F1),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child:  const Center(child:Image(
                      image: AssetImage('images/platinum.png'),
                      width: 18,
                    ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Platinum Package',style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color:Colors.black
                      ),),
                      const SizedBox(height: 5,),
                      Text("Currently Activated!",style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color:const Color(0xffC8C7C6)
                      ),),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(child: Icon(Icons.done,color: Colors.white,size: 14,),),
                  ),

                ],
              )
          ),
        ),
            SizedBox(height: h *.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Report List',style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color:Colors.black
              ),),
            ),
            SizedBox(height: h *.02),
            const ReportBox('Total Addons', 'Jun 10-Jun 11', 'images/graph.png', 0,),
            const ReportBox('Total Ad Watched', 'Jun 10-Jun 11', 'images/graph.png', 0,),
            const ReportBox('Total Coins Earned', 'Jun 10-Jun 11', 'images/graph.png', 0,),
            const ReportBox('Total Coins Earned', 'Jun 10-Jun 11', 'images/graph.png', 0,),
            const ReportBox('Today Coins Earned', 'Jun 10-Jun 11', 'images/graph.png', 0,),
            const ReportBox('Converted Earnings', 'Jun 10-Jun 11', 'images/graph.png', 0,),
            SizedBox(height: h *.025),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 197,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const GetVideo(videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
              ),
            ),
            SizedBox(height: h *.01),
          ],
        ),
      ),
    );
  }
}


