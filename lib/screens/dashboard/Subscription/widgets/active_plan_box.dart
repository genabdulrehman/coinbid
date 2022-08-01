import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Models/price_plan_model.dart';
import '../../../../constant/colors.dart';

class ActivePlaneBox extends StatelessWidget {
  final PricePlanModel pricePlan;
  const ActivePlaneBox({required this.pricePlan , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kOrangeColor),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFF7F1),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child:  Center(child:Image(
                          image: AssetImage(pricePlan.url),
                          width: 18,
                        ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pricePlan.packageName,style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color:Colors.black
                          ),),
                          const SizedBox(height: 5,),
                          Text("Rs.${pricePlan.price.round()}",style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color:Colors.black
                          ),),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: kOrangeColor,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: const Center(child: Icon(Icons.done,color: Colors.white,size: 10,),),
                              ),
                              const SizedBox(width: 10,),
                              Text(pricePlan.des1,style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:Colors.black
                              ),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: kOrangeColor,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: const Center(child: Icon(Icons.done,color: Colors.white,size: 10,),),
                              ),
                              const SizedBox(width: 10,),
                              Text(pricePlan.des2,style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:Colors.black
                              ),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: kOrangeColor,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: const Center(child: Icon(Icons.done,color: Colors.white,size: 10,),),
                              ),
                              const SizedBox(width: 10,),
                              Text(pricePlan.des3,style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:Colors.black
                              ),),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: kOrangeColor,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Center(child: Icon(Icons.done,color: Colors.white,size: 20,),),
                      ),

                    ],
                  ),
                )
            ),
            pricePlan.isRecommended == true ?
            Positioned(
              right: 20,
              top: -12,
              child: Container(
                  height: 25,
                  width: 135,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffE27425),
                          Color(0xffE22525),
                        ],
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('images/recommend.png'),
                        width: 13,
                      ),
                      const SizedBox(width: 5,),
                      Text('Recommended',style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                      ),),
                    ],
                  )
              ),
            ):Container(),
          ],
        )
    );
  }
}