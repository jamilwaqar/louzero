import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:louzero/controller/constant/colors.dart';

class CameraOption {
  static Future showCameraOptions(BuildContext context) {
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
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text("Camera", style: style),
                  onPressed: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Photo Library", style: style),
                  onPressed: () {
                    Navigator.pop(context, ImageSource.gallery);
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
}
