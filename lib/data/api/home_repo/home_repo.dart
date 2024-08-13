import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/models/allPost/all_post.dart';

import '../../secure_storage/secure_storage.dart';
import '../access_regenerator/access_token.dart';
import 'package:http/http.dart' as http;

class HomePageService {
  AccessTokenGenerator accessTokenReGenerator = AccessTokenGenerator();
  SecureStorageService secureStorage = SecureStorageService();
  Future<List<OthersPost>> getAllPost({int limit = 10}) async {
    //declare the tokens here
    String? accessToken = await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await secureStorage.readSecureStorage('RefreshToken');
    //checking the accesstoken and refreshtoken is not null
    if (accessToken != null && refreshToken != null) {
      final header = {'x-api-key': 'apikey@ciao', 'x-access-token': accessToken};
      final url = Uri.parse("${EndPoints.baseUrl}/post/userrelatedposts?")  
          .replace(queryParameters: {'limit': limit.toString()});
      try {
        //getting response
        final response = await http.get(url, headers: header); 
        print('response of homepage $response');
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          List<OthersPost> othersPost = [];
          for (var item in data["after execution"]["PostsData"]) {
            othersPost.add(OthersPost.fromJson(item));
          }
          return othersPost;
        } else if (response.statusCode == 400) {
          String gResponse =
              await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$gResponse gresponse');
          secureStorage.writeSecureStorage('AccessToken', gResponse);

          accessToken = gResponse;
          return getAllPost(limit: limit);
        }
        throw Exception('error on get all post');
      } catch (e) {
        log(e.toString());
        throw Exception('error is $e');
      }
    } else {
      throw Exception('token is missing');
    }
  }
}
