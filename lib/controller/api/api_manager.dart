import 'package:backendless_sdk/backendless_sdk.dart';

class APIManager {
  static const API_HOST = "https://api.backendless.com";
  static const APPLICATION_ID = "D8545E9B-1856-3BFE-FF33-600B71DE0300";
  static const ANDROID_API_KEY = "AD89DC13-EF4C-4020-AF1D-F33BE922DA3F";
  static const IOS_API_KEY = "1B0D4E55-CBBE-48F2-9983-D177CC415326";

  static Future save(String path, dynamic data) async {
    try {
      if (data['objectId'] == null) {
        data.remove('objectId');
      }
      dynamic response = await Backendless.data.of(path).save(data);
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  static Future update(String path, dynamic data) async {
    dynamic response = await Backendless.data.of(path).save(data);
    return response;
  }

  static Future delete(String path, String objectId) async {
    dynamic response = await Backendless.data.of(path)
        .remove(entity: {"objectId": objectId});
    return response;
  }
}
