import 'package:coinbid/Models/price_plan_model.dart';
import 'package:get/get.dart';

class PricePlanController extends GetxController {
  static PricePlanController instance = Get.find();
  RxList<PricePlanModel> pricePlan = RxList<PricePlanModel>([
    PricePlanModel(
        packageName: 'Platinum Package',
        price: 500,
        active: false,
        isRecommended: false,
        url: 'images/platinum.png',
        des1: '10 Ads For Per Day',
        des2: '1000 Coins Included',
        des3: 'Validity for 7days '),
    PricePlanModel(
      packageName: 'Diamond Package',
      price: 250,
      isRecommended: true,
      active: false,
      url: 'images/diamond.png',
      des1: '10 Ads For Per Day',
      des2: '500 Coins Included',
      des3: 'Validity for 7days ',
    ),
    PricePlanModel(
        packageName: 'Gold Package',
        price: 120,
        active: false,
        isRecommended: false,
        url: 'images/gold.png',
        des1: '10 Ads For Per Day',
        des2: '250 Coins Included',
        des3: 'Validity for 7days '),
    PricePlanModel(
        packageName: 'Gold Package',
        price: 120,
        active: false,
        isRecommended: false,
        url: 'images/gold.png',
        des1: '10 Ads For Per Day',
        des2: '250 Coins Included',
        des3: 'Validity for 7days '),
    PricePlanModel(
        packageName: 'Gold Package',
        price: 120,
        active: false,
        isRecommended: false,
        url: 'images/gold.png',
        des1: '10 Ads For Per Day',
        des2: '250 Coins Included',
        des3: 'Validity for 7days '),
  ]);

  @override
  void onReady() {
    super.onReady();
  }
}
