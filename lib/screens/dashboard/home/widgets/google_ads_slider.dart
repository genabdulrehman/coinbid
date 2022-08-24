import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/colors.dart';

class GoogleAdsBanner extends StatefulWidget {
  const GoogleAdsBanner({Key? key}) : super(key: key);

  @override
  State<GoogleAdsBanner> createState() => _GoogleAdsBannerState();
}

class _GoogleAdsBannerState extends State<GoogleAdsBanner> {
  final List<Widget> introWidgetsList = <Widget>[
    const GoogleAdsBox(boxColor: Colors.blue, title: "“The Loyality Club, especially the branded app, changed the way people"),
    const GoogleAdsBox(boxColor: Color(0xff8480E4), title: "“The Loyality Club, especially the branded app, changed the way people"),
    const GoogleAdsBox(boxColor: kPrimaryColor, title: "“The Loyality Club, especially the branded app, changed the way people"),
    const GoogleAdsBox(boxColor: kOrangeColor, title: "“The Loyality Club, especially the branded app, changed the way people")

  ];
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: isActive ? 6 : 6,
      width: isActive ? 6 : 6,
      decoration: BoxDecoration(
          color: isActive ? const Color(0xff626A68) : kGreyTextColor,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
  int currentPos = 0;
  late PageController controller;
  @override
  void initState(){
    super.initState();
    controller =PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return CarouselSlider(
        options: CarouselOptions(
            height: h*.15,
            //aspectRatio: 16/9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                currentPos = index;
              });
            }
        ),
        items: introWidgetsList
    );
    //   Column(
    //     children: [
    //       SizedBox(
    //         height: 114,
    //         child: PageView.builder(
    //           physics: const ClampingScrollPhysics(),
    //           itemCount: introWidgetsList.length,
    //           onPageChanged: (int page) {
    //             currentPos = page;
    //             setState(() {});
    //           },
    //           controller: controller,
    //           itemBuilder: (context, index) {
    //             return introWidgetsList[index];
    //           },
    //         ),
    //       ),
    //       // SizedBox(height: h *.020),
    //       Row(
    //         mainAxisSize: MainAxisSize.min,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           for (int i = 0; i < introWidgetsList.length; i++)
    //             if (i == currentPos) ...[circleBar(true)] else
    //               circleBar(false),
    //         ],
    //       ),
    //     ]
    // );
  }
}


class GoogleAdsBox extends StatelessWidget {
  final String title;
  final Color boxColor;
  const GoogleAdsBox({required this.boxColor ,required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 114,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: boxColor
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
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(child:Image(
                      image: AssetImage('images/ads.png'),
                      width: 25,
                    ),
                    ),
                  ),
                  const Spacer(),
                  Text(title,style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                  ),),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  height: 32,
                  width: 113,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kSecondaryColor
                  ),
                  child: Center(
                    child: Text('See Google Ads',style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}