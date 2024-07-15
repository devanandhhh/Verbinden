import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:http/http.dart' as http;

class AccessTokenGenerator {
  Future<String> accessReGenerator(
      String accessToken, String refreshToken) async {
    final uri = Uri.parse('${EndPoints.baseUrl}${EndPoints.accessGenerator}');
    final header = {
      'x-api-key': 'apikey@ciao',
      'x-access-token': accessToken,
      'x-refresh-token': refreshToken
    };
    try {
      final response = await http.get(uri, headers: header);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['after execution']['AccesToken'];
      } 
    } catch (e) {
      log('$e the error catched');
      // return null;
    }
    return '';
  }
}
