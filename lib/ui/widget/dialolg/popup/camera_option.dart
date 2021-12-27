import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraOption {
  Future<File?> showCameraOptions(BuildContext context) async {
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
    await showCupertinoModalPopup(
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
                    Get.back();
                    File? file = await _getImage(context);
                    Navigator.pop(context, file);
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text("Cancel", style: styleCancel),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ));

  }

  Future<File?> _getImage(context, {bool isPhoto = true}) async {
    try {
      List<Media> medias = await ImagePickers.pickerPaths();
      File file = File(medias.first.path!);
      return file;
    } catch (e) {
      if (!(await Permission.camera.isGranted)) {
        // openDialogPermission(
        //   title:
        //   PermissionDes.Camera,
        //   context: context,
        // );
      }
    }
    return null;
  }
}
