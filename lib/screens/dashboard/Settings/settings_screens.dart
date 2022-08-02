import 'package:coinbid/screens/dashboard/Settings/bank_detail_screen.dart';
import 'package:coinbid/screens/dashboard/Settings/profile_screen.dart';
import 'package:coinbid/screens/dashboard/Settings/profile_verification.dart';
import 'package:coinbid/screens/dashboard/Settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../Controllers/page_controller.dart';
import '../../../constant/colors.dart';
import '../../../provider/user_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? userEmail;
  String? userName;
  Future<String?> readDataFromHive() async {
    var box = await Hive.openBox("UserData");
    String? data = box.get("user-email");
    String? data2 = box.get("user-name");
    userEmail = data.toString();
    userName = data2.toString();

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
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * .02),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    // backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
                    backgroundColor: kLightBackgroundColor,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage('images/profile1.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${dataProvider?.name.toString()}",
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 160,
                        child: FittedBox(
                          child: Text(
                            '${dataProvider?.email}',
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: kTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 97,
                    height: 29,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: kOrangeColor),
                        color: const Color(0xffFFF7F1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('images/platinum.png'),
                          width: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Platinum",
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff3A3836)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * .05),
              Text(
                'ACCOUNT',
                style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kTextColor),
              ),
              SizedBox(height: h * .02),
              SettingTile(
                  function: () {
                    Navigator.of(context).push(
                        PageCreateRoute().createRoute(const ProfileScreen()));
                  },
                  title: 'User Profile',
                  url: 'setting_icons/person.png'),
              const Divider(
                color: kBorderColor,
                thickness: 1,
              ),
              SettingTile(
                  function: () {
                    Navigator.of(context).push(PageCreateRoute()
                        .createRoute(const BankDetailScreen()));
                  },
                  title: 'Bank Details',
                  url: 'setting_icons/bank.png'),
              const Divider(
                color: kBorderColor,
                thickness: 1,
              ),
              SettingTile(
                  function: () {
                    Navigator.of(context).push(PageCreateRoute()
                        .createRoute(const ProfileVerification()));
                  },
                  title: 'Profile Verification',
                  url: 'setting_icons/verify.png'),
              const Divider(
                color: kBorderColor,
                thickness: 1,
              ),
              SettingTile(
                  function: () {},
                  title: 'Cancellation & Refund',
                  url: 'setting_icons/refund.png'),
              SizedBox(height: h * .02),
              Text(
                'COMPANY',
                style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kTextColor),
              ),
              SizedBox(height: h * .02),
              SettingTile(
                  function: () {},
                  title: 'About us',
                  url: 'setting_icons/about.png'),
              const Divider(
                color: kBorderColor,
                thickness: 1,
              ),
              SettingTile(
                  function: () {},
                  title: 'Privacy Policy',
                  url: 'setting_icons/privacy.png'),
              const Divider(
                color: kBorderColor,
                thickness: 1,
              ),
              SettingTile(
                  function: () {},
                  title: 'Terms & Conditions',
                  url: 'setting_icons/term.png'),
              const Divider(
                color: kBorderColor,
                thickness: 1,
              ),
              SettingTile(
                  function: () {},
                  title: 'Refer a friend',
                  url: 'setting_icons/refer.png'),
            ],
          ),
        ),
      ),
    );
  }
}
