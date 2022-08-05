import 'package:coinbid/Constant/constant.dart';
import 'package:coinbid/Controllers/bank_controller.dart';
import 'package:coinbid/Models/bank_model.dart';
import 'package:coinbid/constant/constant.dart';
import 'package:coinbid/provider/bankDetail_provider.dart';
import 'package:coinbid/screens/dashboard/Settings/widgets/bank_details_show_widgets.dart';
import 'package:coinbid/widgets/customButton.dart';
import 'package:coinbid/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../provider/user_provider.dart';
import '../../../widgets/custom_textfield.dart';

class BankDetailScreen extends StatefulWidget {
  const BankDetailScreen({Key? key}) : super(key: key);

  @override
  State<BankDetailScreen> createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  TextEditingController _accountNoTextEditController = TextEditingController();
  TextEditingController _nameTextEditController = TextEditingController();
  TextEditingController _ifscCodeTextEditController = TextEditingController();

  TextEditingController _upiIdEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String token = '';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // userController.readDataFromHive().then((value) => token = value!);
  // }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final dataProvider =
          Provider.of<BankDetailProvider>(context, listen: false);
      dataProvider.getBankDetails(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bankProvider = Provider.of<BankDetailProvider>(context).bankModel;
    final isLoading = Provider.of<BankDetailProvider>(context).loading;
    final data = Provider.of<BankDetailProvider>(context).data;
    _nameTextEditController =
        TextEditingController(text: bankProvider?.banks?.first.bankName);
    _accountNoTextEditController =
        TextEditingController(text: bankProvider?.banks?.first.accountNumber);
    _ifscCodeTextEditController =
        TextEditingController(text: bankProvider?.banks?.first.ifscCode);
    _upiIdEditController =
        TextEditingController(text: bankProvider?.banks?.first.upiId);
    print("Bank details is : $bankProvider");
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(13),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    border: Border.all(color: kBorderColor),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 10,
                )),
              ),
            ),
          ),
          title: Text(
            "Bank Details",
            style: GoogleFonts.nunito(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        body: isLoading == false
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: h * .02),
                    data == true
                        ? Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffFF7455),
                                ),
                                child: const Image(
                                  image: AssetImage('images/ornament.png'),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Bank name - ${bankProvider?.banks?.first.bankName ?? ''}"
                                          .toUpperCase(),
                                      style: GoogleFonts.nunito(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: h * .02),
                                    BankDetailsWidget(
                                        type: 'A/c number -',
                                        data: bankProvider
                                                ?.banks?.first.accountNumber
                                                .toString() ??
                                            ''),
                                    BankDetailsWidget(
                                        type: 'IFSC code -',
                                        data:
                                            "${bankProvider?.banks?.first.ifscCode}"),
                                    // BankDetailsWidget(
                                    //    type: 'branch -', data: data.banks?.first. ??''),
                                    BankDetailsWidget(
                                      type: 'UPI ID -',
                                      data:
                                          "${bankProvider?.banks?.first.upiId.toString()}",
                                    ),
                                    SizedBox(height: h * .02),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          bottomSheet(h: h, edit: true);
                                        },
                                        child: Container(
                                          width: 121,
                                          height: 28,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white),
                                          child: Center(
                                            child: Text(
                                              "Edit Bank Account",
                                              style: GoogleFonts.nunito(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xffFF7455),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: h / 2.5),
                                  child: const Text(
                                      "You have no banks details, please enter."),
                                ),
                                // Spacer(),
                                SizedBox(
                                  height: h * .2,
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    bottomSheet(h: h, edit: false);
                                  },
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                  ],
                ))
            : const Center(
                child: CircularProgressIndicator(),
              )

        // future: bankController.getBankDetails(token),

        );
  }

  Future<dynamic> bottomSheet({required double h, bool? edit}) {
    return Get.bottomSheet(
        FractionallySizedBox(
          heightFactor: 0.75,
          child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: kBorderColor),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Image(
                          image: AssetImage('images/cross_icon.png'),
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Add Bank Account",
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: h * 0.020,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _nameTextEditController,
                              label: 'Bank Name',
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'Please enter your bank name';
                                }
                                return null;
                              },
                              hintText: "Bank Name"),
                          SizedBox(
                            height: h * 0.020,
                          ),
                          CustomTextField(
                              controller: _accountNoTextEditController,
                              label: 'Account Number',
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'Please enter your account number';
                                }
                                return null;
                              },
                              hintText: "Account Number"),
                          SizedBox(
                            height: h * 0.020,
                          ),
                          CustomTextField(
                              controller: _ifscCodeTextEditController,
                              label: 'IFSC CODE',
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'Please enter your IFSC Code';
                                }
                                return null;
                              },
                              hintText: "IFSC CODE"),
                          SizedBox(
                            height: h * 0.020,
                          ),
                          CustomTextField(
                              controller: _upiIdEditController,
                              label: 'UPI ID',
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'Please enter your UPI ID';
                                }
                                return null;
                              },
                              hintText: "UPI ID"),
                        ],
                      )),
                  SizedBox(
                    height: h * 0.020,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Note : ',
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: kOrangeColor),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "Becarefull when entering your deatils you need to raise a request for changing deatils ",
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: kTextColor),
                          )
                        ]),
                  ),
                  const Spacer(),
                  CustomButton(
                      title: 'Submit',
                      clickFuction: () async {
                        if (_formKey.currentState!.validate()) {
                          if (edit == true) {
                            loadingDialogue(context: context);
                            await BankController.instance
                                .editBankDetails(
                              context: context,
                              bankName: _nameTextEditController.text,
                              ifsc: _ifscCodeTextEditController.text,
                              upi_id: _upiIdEditController.text,
                              accountNumber: _accountNoTextEditController.text,
                            )
                                .then((value) {
                              Get.back();
                              if (value['success']) {
                                Get.back();
                                Get.snackbar('Successfully', 'updated');
                                final dataProvider =
                                    Provider.of<BankDetailProvider>(context,
                                        listen: false);
                                dataProvider.getBankDetails(context);
                              } else {
                                Get.back();
                                Get.snackbar(
                                    'Something Went Wrong', value['message']);
                              }
                            });
                          } else {
                            loadingDialogue(context: context);
                            await BankController.instance
                                .postBankDetails(
                              context: context,
                              bankName: _nameTextEditController.text,
                              ifsc: _ifscCodeTextEditController.text,
                              upi_id: _upiIdEditController.text,
                              accountNumber: _accountNoTextEditController.text,
                            )
                                .then((value) {
                              Get.back();
                              if (value['success']) {
                                Get.back();
                                Get.snackbar('Successfully', value['message']);
                                final dataProvider =
                                    Provider.of<BankDetailProvider>(context,
                                        listen: false);
                                dataProvider.getBankDetails(context);
                              } else {
                                Get.back();
                                Get.snackbar(
                                    'Something Went Wrong', value['message']);
                              }
                            });
                          }
                        }
                      }),
                  SizedBox(
                    height: h * 0.020,
                  ),
                ],
              )),
        ),
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        enableDrag: true,
        isScrollControlled: true);
  }
}
