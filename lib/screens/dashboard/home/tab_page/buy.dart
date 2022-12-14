import 'package:coinbid/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyCoinPage extends StatefulWidget {
  const BuyCoinPage({Key? key}) : super(key: key);

  @override
  State<BuyCoinPage> createState() => _BuyCoinPageState();
}

class _BuyCoinPageState extends State<BuyCoinPage> {
  RangeValues _currentRangeValues = const RangeValues(500, 1000);

  static String _valueToString(double value) {
    return value.toStringAsFixed(0);
  }
  String firstPrice = '';
  String endPrice = '';
  double average = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstPrice = _currentRangeValues.start.round().toString();
    endPrice = _currentRangeValues.end.round().toString();
    average = (_currentRangeValues.start.round() + _currentRangeValues.end.round())/2;
  }
  @override
  Widget build(BuildContext context) {
    final w =MediaQuery.of(context).size.width.toInt();
    final h =MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            SizedBox(height: h *.035),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20,right:20,top: 20,bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.07),
                    spreadRadius: 3,
                    blurStyle: BlurStyle.normal,
                    blurRadius: 20,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                            TextSpan(
                                text: 'Price ',
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: kOrangeColor
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Range',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  )
                                ]
                            )
                        ),
                        const SizedBox(height: 10,),
                        Text('Rs.$firstPrice - Rs.$endPrice',style:GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kTextColor
                        ),)
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xffFDFAF8)
                      ),
                      child: Center(
                        child: Text('Average Price : Rs${average.round()}',style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:kOrangeColor
                        ),),
                      ),
                    )
                  ],),
                  SliderTheme(
                    data: const SliderThemeData(
                      trackHeight: 1,

                    ),
                    child: RangeSlider(
                      activeColor: kOrangeColor,
                      inactiveColor: kBorderColor,
                      values: _currentRangeValues,
                      min: 500,
                      max: 4000,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                          firstPrice = values.start.round().toString();
                          endPrice = values.end.round().toString();
                          average = (values.start.round() + values.end.round())/2;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: h *.035),
            BuyCoinBox(id: 'Ex 261564', date: '10/06/2022', price: '4000.00', coin: '5000 coins', function: (){}),
            SizedBox(height: h *.025),
            BuyCoinBox(id: 'Ex 261564', date: '10/06/2022', price: '4000.00', coin: '5000 coins', function: (){}),
            SizedBox(height: h *.025),
            BuyCoinBox(id: 'Ex 261564', date: '10/06/2022', price: '4000.00', coin: '5000 coins', function: (){}),
            SizedBox(height: h *.025),
            BuyCoinBox(id: 'Ex 261564', date: '10/06/2022', price: '4000.00', coin: '5000 coins', function: (){}),
            SizedBox(height: h *.025),
            BuyCoinBox(id: 'Ex 261564', date: '10/06/2022', price: '4000.00', coin: '5000 coins', function: (){}),
            SizedBox(height: h *.025),
            BuyCoinBox(id: 'Ex 261564', date: '10/06/2022', price: '4000.00', coin: '5000 coins', function: (){}),
            SizedBox(height: h *.035),
          ],
        ),
      ),
    );
  }
}

class BuyCoinBox extends StatelessWidget {
  final String id;
  final String date;
  final String price;
  final String coin;
  final VoidCallback function;


  const BuyCoinBox({
    required this.id,
    required this.date,
    required this.price,
    required this.coin,
    required this.function,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 55,
          height: 55,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: const Color(0xffFDFBEF),
              borderRadius: BorderRadius.circular(30)
          ),
          child: const Center(child:Image(
            image: AssetImage('images/buy_icon.png'),
            width: 25,
          ),
          ),
        ),
        Column(
          children: [
            Text(id,style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color:Colors.black
            ),),
            const SizedBox(height: 5,),
            Text(date,style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:kTextColor
            ),),
          ],
        ),
        Column(
          children: [
            Text(price,style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color:Colors.black
            ),),
            const SizedBox(height: 5,),
            Text(coin,style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:kTextColor
            ),),
          ],
        ),
        Container(
          height: 40,
          width: 75,
          margin: const EdgeInsets.all(0),
          child: MaterialButton(
            elevation: 0,
            splashColor: kPrimaryColor.withOpacity(.2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(color: kPrimaryColor)
            ),
            onPressed: (){},
            child: Text('Buy', style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: kPrimaryColor
            ),),
          ),
        ),

      ],
    );
  }
}
