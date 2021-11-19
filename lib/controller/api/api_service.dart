import 'dart:io';
import 'dart:math';

import 'package:louzero/controller/constant/constants.dart';

import 'baseClient.dart';


class ApiService {
  final BaseClient _client = BaseClient();
  String TAG = 'ApiService';

  Future<dynamic> googleApi(String url, Map<String, dynamic> data) async {
    if (url.isEmpty) return Future.error('Invalid input!');
    try {
      dynamic response = await _client.getTypeless(url, queryParameters: {
        ...data,
        'key':AppKey.googleMapKey,
      });
      // headers: _getHeaders(fcmKey));
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  ///***************************************************************************
  ///****                      UTILS                                       *****
  ///***************************************************************************

  Map<String, String>_getHeaders(String token) {
    return {
      HttpHeaders.authorizationHeader: 'key=$token',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  String randomString(int strlen) {
    const chars = "0123456789";
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

}