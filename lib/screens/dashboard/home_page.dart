import 'package:coinbid/screens/dashboard/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../constant/colors.dart';
import 'Settings/settings_screens.dart';
import 'Subscription/subscription_screen.dart';
import 'Transaction/transaction_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _page1 = GlobalKey<NavigatorState>();
  final _page2 = GlobalKey<NavigatorState>();
  final _page3 = GlobalKey<NavigatorState>();
  final _page4 = GlobalKey<NavigatorState>();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          _page1.currentState!.maybePop();
          return false;
        }
        else if (currentIndex == 1) {
          _page2.currentState!.maybePop();
          return false;
        }
        else if (currentIndex == 2) {
          _page3.currentState!.maybePop();
          return false;
        }
        else if (currentIndex == 3) {
          _page4.currentState!.maybePop();
          return false;
        }

        return true;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedLabelStyle: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kTextColor
          ),
          selectedLabelStyle: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kTextColor
          ),

          onTap: (int index){
            setState(() {

              currentIndex=index;

            });

          },
          currentIndex: currentIndex,

          fixedColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,

          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/home_icon.png',width: 20,),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/active_home.png',width: 20,),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/subscription_icon.png',width: 23,),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/active_subscription.png',width: 23,),
              ),
              label: 'Subscription',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/transaction_icon.png',width: 20,),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/active_transaction.png',width: 20,),
              ),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/setting_icon.png',width: 20,),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('images/active_setting.png',width: 20,),
              ),
              label: 'Settings',
            ),
          ],
        ),
        body: IndexedStack(
          index: currentIndex,
          children: <Widget>[

            Navigator(
              key: _page1,
              onGenerateRoute: (route) => PageTransition(
                type: PageTransitionType.leftToRight,
                settings: route,
                child:  const HomeScreen(),
              ),
            ),
            Navigator(
              key: _page2,
              onGenerateRoute: (route) => PageTransition(
                type: PageTransitionType.leftToRight,
                settings: route,
                child:  const SubscriptionScreen(),
              ),
            ),
            Navigator(
              key: _page3,
              onGenerateRoute: (route) => PageTransition(
                type: PageTransitionType.leftToRight,
                settings: route,
                child:  const TransactionScreen(),
              ),
            ),
            Navigator(
              key: _page4,
              onGenerateRoute: (route) => PageTransition(
                type: PageTransitionType.leftToRight,
                settings: route,
                child:  const SettingScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
