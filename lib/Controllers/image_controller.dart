import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class ImagePickerController{

  String url = '';
  Future<String> uploadImageToFirebase(String foldName , String fileName , File image) async {
    fStorage.Reference reference = fStorage.FirebaseStorage.instance
        .ref()
        .child(foldName)
        .child(fileName);
    fStorage.UploadTask uploadTask =
    reference.putFile(File(image.path));
    fStorage.TaskSnapshot taskSnapshot =
    await uploadTask.whenComplete(() {});
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

}