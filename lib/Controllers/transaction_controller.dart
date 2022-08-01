import 'package:coinbid/Models/transaction_model.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController{

  static TransactionController instance = Get.find();
  RxList<TransactionModel> transactions = RxList<TransactionModel>([
    TransactionModel(
        receive: false,
        amount: 145,
        url: 'images/profile.png',
        time: '09:45',
        user: 'Josh Hazlewood'),
    TransactionModel(
        receive: true,
        amount: 145,
        url: 'images/profile.png',
        time: '09:45',
        user: 'Authos'),
    TransactionModel(
        receive: false,
        amount: 145,
        url: 'images/profile.png',
        time: '09:45',
        user: 'Josh Hazlewood'),
    TransactionModel(
        receive: true,
        amount: 145,
        url: 'images/profile.png',
        time: '09:45',
        user: 'Authos'),
    TransactionModel(
        receive: false,
        amount: 145,
        url: 'images/profile.png',
        time: '09:45',
        user: 'Josh Hazlewood'),
    TransactionModel(
        receive: true,
        amount: 145,
        url: 'images/profile.png',
        time: '09:45',
        user: 'Authos'),
  ]);

  @override
  void onReady() {
    super.onReady();

  }





}