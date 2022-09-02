import 'package:coinbid/screens/dashboard/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../widgets/customButton.dart';

class SuccessPaymentScreen extends StatefulWidget {
  const SuccessPaymentScreen({Key? key}) : super(key: key);

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen> with TickerProviderStateMixin{
  late final AnimationController animationControllerForSignUpCompleting;

  @override
  void initState() {
    super.initState();
    animationControllerForSignUpCompleting = AnimationController(vsync: this);
  }
  @override
  void dispose() {
    animationControllerForSignUpCompleting.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 190,
              height: 190,
              child: Lottie.asset(
                'images/done1.json',
                options: LottieOptions(enableMergePaths: true),
                fit: BoxFit.fill,
                controller: animationControllerForSignUpCompleting,
                onWarning: (warning) {
                  debugPrint("🔴 Lottie warning $warning");
                },
                onLoaded: (composition) {
                  Future.delayed(const Duration(microseconds: 900),
                          () {
                        animationControllerForSignUpCompleting
                          ..duration = composition.duration
                          ..forward();
                      });
                },
                //repeat: true,
              ),
            ),
            Text("Package Payment Successfully",style: GoogleFonts.nunito(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),),
            const SizedBox(height: 70,),
            CustomButton(title: "Home", clickFuction: (){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  maintainState: false,
                  builder: (BuildContext context) => const HomePage(),
                ),
                    (Route<dynamic> route) => true,
              );
            })
          ],
        ),
      ),

    );
  }
}
