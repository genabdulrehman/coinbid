import 'dart:math';
//TEsting

import 'package:coinbid/Controllers/bank_controller.dart';
import 'package:coinbid/Controllers/price_planController.dart';
import 'package:coinbid/Controllers/transaction_controller.dart';
import 'package:coinbid/Controllers/user_controller.dart';
import 'package:coinbid/constant/colors.dart';
import 'package:coinbid/provider/bankDetail_provider.dart';
import 'package:coinbid/provider/banner_provider.dart';
import 'package:coinbid/provider/getCoins_provider.dart';
import 'package:coinbid/provider/subsciption_provider.dart';
import 'package:coinbid/provider/user_provider.dart';
import 'package:coinbid/screens/dashboard/home/home_screen.dart';
import 'package:coinbid/screens/dashboard/home_page.dart';
import 'package:coinbid/screens/onBoarding/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

bool isLogin = true;
Future<String?> readDataFromHive() async {
  var box = await Hive.openBox("UserData");
  String? data = await box.get("user-access-token");
  print("User token : $data");
  if (data == null) {
    isLogin = false;
  }
  print("User access token : $isLogin");

  return data;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await readDataFromHive();
  Firebase.initializeApp().then((value) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      Get.put(PricePlanController());
      Get.put(TransactionController());
      Get.put(UserController());
      Get.put(BankController());
      runApp(const MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>(
            create: (context) => UserDataProvider()),
        ChangeNotifierProvider<BankDetailProvider>(
            create: (context) => BankDetailProvider()),
        ChangeNotifierProvider<SubscriptionProvider>(
            create: (context) => SubscriptionProvider()),
        ChangeNotifierProvider<GetBannersProvider>(
            create: (context) => GetBannersProvider()),
        ChangeNotifierProvider<GetCoinsProvider>(
            create: (context) => GetCoinsProvider()),
      ],
      child: GetMaterialApp(
          defaultTransition: Transition.rightToLeft,
          debugShowCheckedModeBanner: false,
          title: 'Coinbid App',
          theme: ThemeData(
            primarySwatch: generateMaterialColor(kPrimaryColor),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
          ),
          home: isLogin ? HomePage() : SplashScreen()),
    );
  }
}
