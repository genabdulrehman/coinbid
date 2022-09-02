
import 'package:coinbid/Controllers/payment_controller.dart';
import 'package:coinbid/constant/colors.dart';
import 'package:coinbid/provider/subsciption_provider.dart';
import 'package:coinbid/screens/dashboard/Subscription/plan_report.dart';
import 'package:coinbid/screens/dashboard/Subscription/widgets/active_plan_box.dart';
import 'package:coinbid/screens/dashboard/Subscription/widgets/inActive_plan_box.dart';
import 'package:coinbid/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Controllers/getSubsciption_controller.dart';
import '../../../Controllers/page_controller.dart';
import '../../../Models/subscription_model.dart';
import '../../../provider/user_provider.dart';
import '../../../widgets/error_dialogue.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List<Packages> packages = [];
  GetSubscriptionController getSubscriptionController =
      GetSubscriptionController();
  double selectedPrice = 0;
  String planId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<UserDataProvider>(context, listen: false).getData();
          Provider.of<SubscriptionProvider>(context, listen: false)
              .getSubscriptions();
      Provider.of<SubscriptionProvider>(context, listen: false).getUserActivePackage();
    });
  }



  @override
  Widget build(BuildContext context) {
    final subsciptionProvider =
        Provider.of<SubscriptionProvider>(context).subscriptionModel;
    final userProvider = Provider.of<UserDataProvider>(context).getUserModel;
    final packageProvider = Provider.of<SubscriptionProvider>(context, listen: true).activePlanModel;
    packages = subsciptionProvider.packages ?? [];
    print("Subsc --> $subsciptionProvider");
    var isLoading = Provider.of<SubscriptionProvider>(context).isLoading;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Subscription",
            style: GoogleFonts.nunito(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: isLoading == false
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: h * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: double.infinity,
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: kSecondaryColor.withOpacity(.08)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Active Plan",
                                      style: GoogleFonts.nunito(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff56544E)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Platinum Ad Plan Activated!',
                                      style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff8A877F)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          PageCreateRoute()
                                              .createRoute(const PlanReport()));
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 109,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: kSecondaryColor),
                                      child: Center(
                                        child: Text(
                                          'See Report',
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * .02),
                    if (subsciptionProvider.packages != null)
                      for (int i = 0;
                          i < subsciptionProvider.packages!.length;
                          i++)
                        subsciptionProvider.packages![i].active == false
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i < packages.length; i++) {
                                      packages[i].active = false;
                                    }
                                    packages[i].active = true;
                                    ActivePlaneBox(
                                      ads:
                                          "${subsciptionProvider.packages?[i].banners.toString()} Ads for per day. ",
                                      coins:
                                          "${subsciptionProvider.packages?[i].coins} coins included",
                                      validity: "7 days validity.",
                                      name:
                                          '${subsciptionProvider.packages?[i].title.toString()} Package',
                                      price:
                                          subsciptionProvider.packages?[i].price.toString() ?? '',
                                      url: 'images/platinum.png',
                                      isRecommended: subsciptionProvider
                                              .packages?[i].isRecommended ??
                                          false,
                                    );
                                    selectedPrice = subsciptionProvider
                                        .packages![i].price!
                                        .toDouble();
                                    planId =
                                        subsciptionProvider.packages![i].sId ??
                                            '';
                                  });
                                },
                                child: InactivePlaneBox(
                                  title:
                                      '${subsciptionProvider.packages?[i].title.toString()} Package',
                                  url: subsciptionProvider.packages?[i].icon ?? '',
                                  price:
                                      '${subsciptionProvider.packages?[i].price.toString()}',
                                ))
                            : ActivePlaneBox(
                                ads:
                                    "${subsciptionProvider.packages?[i].banners.toString()} Ads for per day. ",
                                coins:
                                    "${subsciptionProvider.packages?[i].coins} coins included",
                                validity: "${subsciptionProvider.packages?[i].expireDate} days validity.",
                                name:
                                    '${subsciptionProvider.packages?[i].title.toString()} Package',
                                price:
                                    subsciptionProvider.packages?[i].price.toString() ?? '',
                                url: subsciptionProvider.packages?[i].icon ?? '',
                                isRecommended: subsciptionProvider
                                        .packages?[i].isRecommended ??
                                    false,
                              ),
                    SizedBox(height: h * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              title:
                                  "Subscribe for Rs.${selectedPrice.round()}",
                              clickFuction: () {
                                if (planId == '') {
                                  errorDialogue(
                                      context: context,
                                      title: "Selected plan is required",
                                      bodyText:
                                          "Please select any plan for subscription.");
                                }
                                else if (packageProvider.packages!.isNotEmpty) {
                                  errorDialogue(
                                      context: context,
                                      title: "Already buy plan",
                                      bodyText:
                                      "You have already buy one plan.");
                                }
                                else {
                                  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
                                  PaymentController().getPaymentToken(context, orderId, selectedPrice.toString()).then((value) {
                                    if(value.status == "OK"){
                                      Get.back();
                                       PaymentController().proceedPayment(context,value.cfToken!, orderId,planId, selectedPrice.toString(), userProvider!);
                                    }
                                    else{
                                      Get.back();
                                      Get.snackbar(
                                          "Something went wrong",
                                          value.message??'');
                                    }
                                  });
                                }
                              }),
                    ),
                    SizedBox(height: h * .02),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
