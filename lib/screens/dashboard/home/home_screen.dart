import 'package:coinbid/Constant/constant.dart';
import 'package:coinbid/provider/user_provider.dart';
import 'package:coinbid/screens/dashboard/home/exchange_coin.dart';
import 'package:coinbid/screens/dashboard/home/widgets/carosel_slider.dart';
import 'package:coinbid/screens/dashboard/home/widgets/google_ads_slider.dart';
import 'package:coinbid/screens/dashboard/home/widgets/play_ads.dart';
import 'package:coinbid/screens/dashboard/home/widgets/price_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../Controllers/page_controller.dart';
import '../../../constant/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  Future<String?> readDataFromHive() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-name");
    userName = data.toString();

    return data;
  }

  @override
  void initState() {
    readDataFromHive();
    super.initState();
    Future.delayed(Duration.zero, () {
      final dataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      dataProvider.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider =
        Provider.of<UserDataProvider>(context).getUserModel?.users;
    print("Data Provider ${dataProvider}");
    final w = MediaQuery.of(context).size.width.toInt();
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(height: h * .06),
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  // backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
                  backgroundColor: kLightBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Image(
                        image: AssetImage('images/profile.png'),
                        width: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dataProvider?.name != null
                        ? Text(
                            '${dataProvider?.name}',
                            // "${userName}",
                            style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          )
                        : Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                    Text(
                      "Good Morning!",
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kTextColor),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(color: kBorderColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Image(
                        image: AssetImage('images/notification.png'),
                        width: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * .015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: PriceBox(
                  boxColor: kOrangeColor,
                  url: 'images/curency.png',
                  price: '\$34500',
                  title: 'Total Cash',
                  function: () {
                    Navigator.of(context).push(PageCreateRoute()
                        .createRoute(const ExchangeCoinScreen()));
                    // Get.to(const ExchangeCoinScreen());
                  },
                )),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: PriceBox(
                  boxColor: kSecondaryColor,
                  url: 'images/star.png',
                  price: '34500',
                  title: 'Total Points',
                  function: () {},
                ))
              ],
            ),
            SizedBox(height: h * .015),
            const CustomIndicator(),
            SizedBox(height: h * .015),
            Row(
              children: [
                Text(
                  "Watch Ads",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
                Text(
                  "(0/5)",
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff946C52)),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: 70,
                    height: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: .2,
                        valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor),
                        backgroundColor: Color(0xffFDEEE4),
                      ),
                    )),
              ],
            ),
            SizedBox(height: h * .015),
            Container(
              height: h * .23,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: kBorderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const GetVideo(
                  videoLink:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
            ),
            SizedBox(height: h * .017),
            const GoogleAdsBanner(),
          ],
        ),
      ),
    );
  }
}
