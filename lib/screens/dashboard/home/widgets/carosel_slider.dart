import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/colors.dart';

class CustomIndicator extends StatefulWidget {
  const CustomIndicator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomIndicatorState();
  }
}

class CustomIndicatorState extends State<CustomIndicator>{
  final List<Widget> introWidgetsList = <Widget>[
        const CarouselBox(boxColor: Color(0xff8480E4), url: 'images/slider_1.png', title: "Earn \$100 Daily what you’ll needed"),
        const CarouselBox(boxColor: Color(0xffFEC127), url: 'images/slider_1.png', title: "Earn \$100 Daily what you’ll needed"),
        const CarouselBox(boxColor: kOrangeColor, url: 'images/slider_1.png', title: "Earn \$100 Daily what you’ll needed")

  ];
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 9 : 9,
      width: isActive ? 9 : 9,
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
    return Column(
        children: [
          SizedBox(
            height: h*.17,
            child: PageView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: introWidgetsList.length,
              onPageChanged: (int page) {
                currentPos = page;
                setState(() {});
              },
              controller: controller,
              itemBuilder: (context, index) {
                return introWidgetsList[index];
              },
            ),
          ),
          SizedBox(height: h *.010),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < introWidgetsList.length; i++)
                if (i == currentPos) ...[circleBar(true)] else
                  circleBar(false),
            ],
          ),
          // CarouselSlider(
          //   options: CarouselOptions(
          //       height: 168,
          //       aspectRatio: 16/9,
          //       viewportFraction: 0.8,
          //       initialPage: 0,
          //       enableInfiniteScroll: true,
          //       reverse: false,
          //       autoPlay: true,
          //       autoPlayInterval: Duration(seconds: 3),
          //       autoPlayAnimationDuration: Duration(milliseconds: 800),
          //       autoPlayCurve: Curves.fastOutSlowIn,
          //       scrollDirection: Axis.horizontal,
          //       onPageChanged: (index, reason) {
          //         setState(() {
          //           currentPos = index;
          //         });
          //       }
          //   ),
          //   items: const [
          //     CarouselBox(boxColor: Color(0xff8480E4), url: 'images/slider_1.png', title: "Earn \$100 Daily what you’ll needed"),
          //     CarouselBox(boxColor: Color(0xffFEC127), url: 'images/slider_1.png', title: "Earn \$100 Daily what you’ll needed"),
          //     CarouselBox(boxColor: kOrangeColor, url: 'images/slider_1.png', title: "Earn \$100 Daily what you’ll needed")
          //   ]
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: listPaths.map((url) {
          //     int index = listPaths.indexOf(url);
          //     return Container(
          //       width: 8.0,
          //       height: 8.0,
          //       margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: currentPos == index
          //             ? const Color.fromRGBO(0, 0, 0, 0.9)
          //             : const Color.fromRGBO(0, 0, 0, 0.4),
          //       ),
          //     );
          //   }).toList(),
          // ),
        ]
    );
  }
}

class CarouselBox extends StatelessWidget {
  final String url;
  final String title;
  final Color boxColor;
  const CarouselBox({required this.boxColor,required this.url ,required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: boxColor
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  ),),
                  const Spacer(),
                  Container(
                    height: 35,
                    width: 121,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                    ),
                    child: Center(
                      child: Text('Get Started',style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Image(
                image: AssetImage(url),
                //width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
