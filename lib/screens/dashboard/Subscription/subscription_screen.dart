import 'package:coinbid/Models/price_plan_model.dart';
import 'package:coinbid/constant/colors.dart';
import 'package:coinbid/constant/constant.dart';
import 'package:coinbid/screens/dashboard/Subscription/plan_report.dart';
import 'package:coinbid/screens/dashboard/Subscription/widgets/active_plan_box.dart';
import 'package:coinbid/screens/dashboard/Subscription/widgets/inActive_plan_box.dart';
import 'package:coinbid/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/page_controller.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool value = false;
  double selectedPrice =0;
  setPlan(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            pricePlanController.pricePlan[index].active = true;
            pricePlanController.pricePlan[1].active = false;
            pricePlanController.pricePlan[2].active = false;
            pricePlanController.pricePlan[3].active = false;
          }
          break;
        case 1:
          {
            pricePlanController.pricePlan[index].active = true;
            pricePlanController.pricePlan[0].active = false;
            pricePlanController.pricePlan[2].active = false;
            pricePlanController.pricePlan[3].active = false;
          }
          break;
        case 2:
          {
            pricePlanController.pricePlan[index].active = true;
            pricePlanController.pricePlan[0].active = false;
            pricePlanController.pricePlan[1].active = false;
            pricePlanController.pricePlan[3].active = false;
          }
          break;
        case 3:
          {
            pricePlanController.pricePlan[index].active = true;
            pricePlanController.pricePlan[0].active = false;
            pricePlanController.pricePlan[1].active = false;
            pricePlanController.pricePlan[2].active = false;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        title: Text("Subscription",style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black
        ),),
      ),
      body: Obx(() =>
          SingleChildScrollView(
            child: Column(
        children: [
            SizedBox(height: h *.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                height: 85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kSecondaryColor.withOpacity(.08)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Active Plan",style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff56544E)
                            ),),
                            const SizedBox(height: 5,),
                            Text('Platinum Ad Plan Activated!',style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff8A877F)
                            ),),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(PageCreateRoute().createRoute(const PlanReport()));
                            },
                            child: Container(
                              height: 40,
                              width: 109,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: kSecondaryColor
                              ),
                              child: Center(
                                child: Text('See Report',style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: h *.02),
            for(int i=0 ; i<pricePlanController.pricePlan.length ; i++)
              pricePlanController.pricePlan[i].active == false ?
              GestureDetector(
                onTap: (){
                  setState(() {
                    setPlan(i);
                    selectedPrice = pricePlanController.pricePlan[i].price;
                  });
                },
                  child: InactivePlaneBox(pricePlan: pricePlanController.pricePlan[i],)):ActivePlaneBox(pricePlan: pricePlanController.pricePlan[i],),
          SizedBox(height: h *.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
                title: "Subscribe for Rs.${selectedPrice.round()}", clickFuction: (){}),
          ),
          SizedBox(height: h *.02),

        ],
      ),
          )),
    );
  }
}




