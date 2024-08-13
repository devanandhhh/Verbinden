import 'dart:developer';

import '../../../core/endpoints.dart';
import '../../secure_storage/secure_storage.dart';
import '../profile_repo/section_2/profile_section_service.dart';
import 'package:http/http.dart' as http;

class LikeAndUnlikeRepo {
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();
  Future<int?> likeFunction({required int postId}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.post}${EndPoints.like}/$postId');
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
      };
      try {
        final response = await http.post(url, headers: header);
        if (response.statusCode == 200) {
          log('liked ');
          return response.statusCode;
        } else {
          return response.statusCode;
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }
  //unlike
  Future<int?> unLikeFunction({required int postId}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.post}${EndPoints.like}/$postId');
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken,
      };
      try {
        final response = await http.delete(url, headers: header);
        if (response.statusCode == 200) {
          log('unlike ');
          return response.statusCode;
        } else {
          print(response.body);
          return response.statusCode;
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return null;
  }
}
