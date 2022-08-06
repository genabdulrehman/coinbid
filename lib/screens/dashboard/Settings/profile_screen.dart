import 'dart:io';

import 'package:coinbid/Controllers/image_controller.dart';
import 'package:coinbid/constant/constant.dart';

import 'package:coinbid/widgets/customButton.dart';
import 'package:coinbid/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../provider/user_provider.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/error_dialogue.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameTextEditController = TextEditingController();
  TextEditingController _phoneTextEditController = TextEditingController();
  TextEditingController _cityTextEditController = TextEditingController();
  TextEditingController _stateTextEditController = TextEditingController();
  DateTime? birthDate;
  String? birthDateInString;

  final _formKey = GlobalKey<FormState>();

  File? imageFile;

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print("Image path is $imageFile");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final dataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      dataProvider.getData();

    });



  }

  @override
  Widget build(BuildContext context) {
    final dataProvider =
        Provider.of<UserDataProvider>(context).getUserModel?.users;
    final loader =
        Provider.of<UserDataProvider>(context).loading;
    birthDateInString = dataProvider?.birth;
    _nameTextEditController = TextEditingController(text: dataProvider?.name);
    _phoneTextEditController =
        TextEditingController(text: dataProvider?.mobile);
    _cityTextEditController = TextEditingController(text: dataProvider?.city);
    _stateTextEditController = TextEditingController(text: dataProvider?.state);
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
          "User Profile",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: loader == false ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: h * .02),
              CircleAvatar(
                radius: 30,
                 backgroundImage: dataProvider?.profile != null ?NetworkImage(dataProvider?.profile??''):null,
                backgroundColor: kLightBackgroundColor,
                child: imageFile != null
                    ? ClipOval(
                        child: Image.file(
                          imageFile!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      )
                    :  dataProvider?.profile == null ? const ClipOval(
                        child: Image(
                          image: AssetImage('images/profile1.png'),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ):Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Add profile image',
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // pickImage();
                  _getFromGallery();
                },
                child: Container(
                  width: 86,
                  height: 29,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kOrangeColor.withOpacity(.15)),
                  child: Center(
                    child: Text(
                      "Browse",
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: kOrangeColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * .035),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: _nameTextEditController,
                          label: 'Name',
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          hintText: "Name"),
                      SizedBox(
                        height: h * 0.020,
                      ),
                      GestureDetector(
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: kBorderColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  birthDateInString == null
                                      ? 'Date of Birth'
                                      : birthDateInString!,
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: kBlackColor),
                                ),
                                const Image(
                                  image: AssetImage('images/calender_icon.png'),
                                  width: 18,
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            final datePick = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            if (datePick != null && datePick != birthDate) {
                              setState(() {
                                birthDate = datePick;
                                birthDateInString =
                                    "${birthDate?.day}/${birthDate?.month}/${birthDate?.year}";
                              });
                            }
                          }),
                      SizedBox(
                        height: h * 0.020,
                      ),
                      CustomTextField(
                          textInputType: TextInputType.phone,
                          controller: _phoneTextEditController,
                          label: 'Mobile No',
                          validator: (value) {
                            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = RegExp(pattern);
                            if (value.length == 0) {
                              return 'Please enter mobile number';
                            }
                            else if (!regExp.hasMatch(value)) {
                              return 'Please enter valid mobile number';
                            }
                            return null;
                          },
                          hintText: "+91.."),
                      SizedBox(
                        height: h * 0.020,
                      ),
                      CustomTextField(
                          controller: _cityTextEditController,
                          label: 'City',
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          hintText: "City"),
                      SizedBox(
                        height: h * 0.020,
                      ),
                      CustomTextField(
                          controller: _stateTextEditController,
                          label: 'State',
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Please enter your state';
                            }
                            return null;
                          },
                          hintText: "State"),
                    ],
                  )),
              SizedBox(height: h * .04),
              CustomButton(
                  title: 'Submit',
                  clickFuction: () async {
                      if (imageFile == null && dataProvider?.profile == null) {
                        errorDialogue(
                            context: context,
                            title: "Image is required",
                            bodyText: "Please, select image from gallery");
                      }
                      else if(birthDateInString == null){
                        errorDialogue(
                            context: context,
                            title: "Date of birth is required",
                            bodyText: "Please, select your date of birth");
                      }
                      else if(imageFile == null && _formKey.currentState!.validate()){
                        loadingDialogue(context: context);
                        await userController.updateUserData(
                            name: _nameTextEditController.text,
                            date: birthDateInString,
                            city: _cityTextEditController.text,
                            mobile: _phoneTextEditController.text,
                            state: _stateTextEditController.text,
                            profile: dataProvider?.profile,
                            context: context);
                      }
                      else if(_formKey.currentState!.validate()){
                        loadingDialogue(context: context);
                        userController.readDataFromHive().then((value) {
                          print(value);
                        });
                        ImagePickerController().uploadImageToFirebase("User Profile", dataProvider?.email ??"", imageFile!).then((value) async{
                          await userController.updateUserData(
                              name: _nameTextEditController.text,
                              date: birthDateInString,
                              city: _cityTextEditController.text,
                              mobile: _phoneTextEditController.text,
                              state: _stateTextEditController.text,
                              profile: value,
                              context: context);
                        }).catchError((error){
                          Get.back();
                          errorDialogue(
                              context: context,
                              title: "Something went wrong",
                              bodyText: error.toString());
                        });
                      }



                  }),
              SizedBox(height: h * .02),
            ],
          ),
        ),
      ):
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
