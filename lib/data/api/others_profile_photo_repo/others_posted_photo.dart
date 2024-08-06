import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/api/profile_repo/section_2/profile_section_service.dart';
import 'package:verbinden/data/models/allPost/all_post.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';

import 'package:http/http.dart' as http;

class OthersPostedPhotoService {
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();
  Future<List<OthersPost?>> getOthersPosts(
      {required int userid, int limit = 10, int offset = 0}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      final url =
          Uri.parse('${EndPoints.baseUrl}/post?').replace(queryParameters: {
        'limit': limit.toString(),
        'offset': offset.toString(),
        'userbid': userid.toString()
      });
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };

      try {
        final response = await http.get(url, headers: header);
        log('response from getotherspost  ${response.body}');
        if (response.statusCode == 200) {
          log('response 200 frm get Otherspost');
          final data = jsonDecode(response.body);
          List<OthersPost> posts = [];
          for (var item in data['after execution']['PostsData']) {
            posts.add(OthersPost.fromJson(item));
            log('post from $item');
          }
          return posts;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return getOthersPosts(userid: userid, limit: 10, offset: 0);
        }
        throw Exception('Failed to load posts');
      } catch (e) {
        log('error --$e');
        throw Exception('Failed to load posts');
      }
    } else {
      throw Exception('Tokens are missing');
    }
  }
}
