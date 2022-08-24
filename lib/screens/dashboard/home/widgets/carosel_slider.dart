import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coinbid/Models/banner_model.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../constant/colors.dart';

class CustomIndicator extends StatefulWidget {
  BannerModel? bannerModel;
  CustomIndicator({
    Key? key,
    this.bannerModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomIndicatorState();
  }
}

class CustomIndicatorState extends State<CustomIndicator> {
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
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> introWidgetsList = <Widget>[
      if (widget.bannerModel?.banners != null)
        for (int i = 0; i < widget.bannerModel!.banners!.length; i++)
          CarouselBox(
              boxColor: HexColor("${widget.bannerModel?.banners?[i].color}"),
              url: 'images/slider_1.png',
              title: "${widget.bannerModel?.banners?[i].title.toString()}"),
    ];
    final w = MediaQuery.of(context).size.width.toInt();
    final h = MediaQuery.of(context).size.height;
    return CarouselSlider(
        options: CarouselOptions(
            height: h*.19,
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
    //   Column(children: [
    //   SizedBox(
    //     height: h * .17,
    //     child: PageView.builder(
    //       physics: const ClampingScrollPhysics(),
    //       itemCount: introWidgetsList.length,
    //       onPageChanged: (int page) {
    //         currentPos = page;
    //         setState(() {});
    //       },
    //       controller: controller,
    //       itemBuilder: (context, index) {
    //         return introWidgetsList[index];
    //       },
    //     ),
    //   ),
    //   SizedBox(height: h * .010),
    //   Row(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       for (int i = 0; i < introWidgetsList.length; i++)
    //         if (i == currentPos) ...[circleBar(true)] else circleBar(false),
    //     ],
    //   ),
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: listPaths.map((url) {
    //       int index = listPaths.indexOf(url);
    //       return Container(
    //         width: 8.0,
    //         height: 8.0,
    //         margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: currentPos == index
    //               ? const Color.fromRGBO(0, 0, 0, 0.9)
    //               : const Color.fromRGBO(0, 0, 0, 0.4),
    //         ),
    //       );
    //     }).toList(),
    //   ),
    // ]);
  }
}




class CarouselBox extends StatelessWidget {
  final String url;
  final String title;
  final Color boxColor;
  const CarouselBox(
      {required this.boxColor,
      required this.url,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: boxColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  Container(
                    height: 35,
                    width: 121,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
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
