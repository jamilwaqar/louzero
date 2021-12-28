import 'package:louzero/controller/constant/constants.dart';
import 'baseClient.dart';

class ApiService {
  final BaseClient _client = BaseClient();
  String tag = 'ApiService';

  Future<dynamic> googleApi(String url, Map<String, dynamic> data) async {
    if (url.isEmpty) return Future.error('Invalid input!');
    try {
      dynamic response = await _client.getTypeless(url, queryParameters: {
        ...data,
        'key':AppKey.googleMapKey,
      });

      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}