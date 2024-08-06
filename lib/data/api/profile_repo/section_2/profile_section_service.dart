import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/data/models/edit_post/edit_post.dart';

import '../../../../core/endpoints.dart';
import '../../../models/getPost/get_post.dart';
import '../../../secure_storage/secure_storage.dart';
import '../../access_regenerator/access_token.dart';
import 'package:http/http.dart' as http;

class ProfilePostSectionService {
  //Accesstoken and SecureStorage
  // AccessTokenGenerator accessTokenReGenerator = AccessTokenGenerator();
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();

  //Get user Post
  Future<List<Post>> getUserPosts({int limit = 12, int offset = 0}) async {
    String? accessToken = await tokens.getAccessToken();
    //await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await tokens.getRefreshToken();
    //await secureStorage.readSecureStorage('RefreshToken');

    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      final url =
          Uri.parse('${EndPoints.baseUrl}/post?').replace(queryParameters: {
        'limit': limit.toString(),
        'offset': offset.toString(),
      });

      try {
        final response = await http.get(url, headers: header);
        print('===getuserpost ${response.statusCode}');
        if (response.statusCode == 200) {
          log('user post status code 200');
          final data = json.decode(response.body);
          print('$data ==== data here');
          List<Post> posts = [];
          for (var item in data['after execution']['PostsData']) {
            posts.add(Post.fromJson(item));
            print('$item is item-');
          }
          return posts;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newAccessToken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return getUserPosts(limit: limit, offset: offset);
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

  // Delete user post
  Future<void> deleteUserPost(int postId) async {
    String? accessToken = await tokens.getAccessToken();
    // await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await tokens.getRefreshToken();
    //await secureStorage.readSecureStorage('RefreshToken');
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.post}$postId');
      try {
        final response = await http.delete(url, headers: header);
        if (response.statusCode == 200) {
          log('Delete post successfully');
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          //   await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newAccessToken');

          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return deleteUserPost(postId);
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  //edit post
  Future<void> editUserPost(EditPostModel editPostModel) async {
    String? accessToken = await tokens.getAccessToken();
    // await secureStorage.readSecureStorage('AccessToken');
    String? refreshToken = await tokens.getRefreshToken();
    //await secureStorage.readSecureStorage('RefreshToken');
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      final body = {
        'caption': editPostModel.caption,
        'postid': editPostModel.postId
      };
      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.post}');
      try {
        final response = await http.patch(url, headers: header, body: body);
        if (response.statusCode == 200) {
          log('edit successfully');
        }else if(response.statusCode==400){
           String newAccessToken = await tokens.getAccessTokenRegenerator();
          //   await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newAccessToken');

          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return editUserPost(editPostModel);
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}

class GetTokensHere {
  AccessTokenGenerator accessTokenReGenerator = AccessTokenGenerator();
  SecureStorageService secureStorage = SecureStorageService();

  getAccessToken() async {
    return secureStorage.readSecureStorage('AccessToken');
  }

  getRefreshToken() async {
    return secureStorage.readSecureStorage('RefreshToken');
  }

  getAccessTokenRegenerator() async {
    String accessToken = await getAccessToken();
    String refreshToken = await getRefreshToken();
    return await accessTokenReGenerator.accessReGenerator(
        accessToken, refreshToken);
  }
}
