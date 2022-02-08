import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:image_cropper/image_cropper.dart';

class CameraOption {
  Future<File?> showCameraOptions(BuildContext context, {required bool isAvatar}) async {
    var style = const TextStyle(
      fontFamily: "Mulish",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.black,
    );
    var styleCancel = const TextStyle(
      fontFamily: "Mulish",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.black,
    );
    File? file = await showCupertinoModalPopup<File?>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text("Camera", style: style),
                  onPressed: () async {
                    File? file = await _getImage(context, isPhoto: false);
                    Navigator.pop(context, file);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Photo Library", style: style),
                  onPressed: () async {
                    File? file = await _getImage(context);
                    Navigator.pop(context, file);
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text("Cancel", style: styleCancel),
                isDestructiveAction: true,
                onPressed: () {
                  Get.back();
                },
              ),
            ));
    if (file != null) {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: file.path,
          cropStyle: isAvatar ? CropStyle.circle : CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio4x3,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      return croppedFile;
    }
    return file;
  }

  Future<File?> _getImage(context, {bool isPhoto = true}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: isPhoto? ImageSource.gallery : ImageSource.camera);
      return File(image!.path);
    } catch (e) {
      Get.snackbar('Upload image Error!', e.toString());
    }
    return null;
  }
}
