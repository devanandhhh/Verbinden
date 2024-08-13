import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/models/user_relation/user_relation.dart';

import '../../secure_storage/secure_storage.dart';
import '../profile_repo/section_2/profile_section_service.dart';
import 'package:http/http.dart' as http;

class RelationService {
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();
  Future<int> followRequest({required String userId}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      final url = Uri.parse(
          '${EndPoints.baseUrl}${EndPoints.relation}${EndPoints.follow}/$userId');
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      try {
        final response = await http.post(url, headers: header);
        if (response.statusCode == 200) {
          print('follow button clicked status code 200');
          return response.statusCode;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newtoken assigned');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return followRequest(userId: userId);
        }
      } catch (e) {
        log('$e error from follow request repo');
      }
    }
    return 00;
  }

  //unfollow button
  Future<int> unfollowRequest({required String userId}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      final url = Uri.parse(
          '${EndPoints.baseUrl}${EndPoints.relation}${EndPoints.unfollow}/$userId');
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      try {
        final response = await http.delete(url, headers: header);
        if (response.statusCode == 200) {
          return response.statusCode;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newtoken assigned');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);

          accessToken = newAccessToken;
          return unfollowRequest(userId: userId);
        }
      } catch (e) {
        log('$e error from unfollow request repo');
      }
    }
    return 00;
  }

  Future<List<UserRelation>> getFollowersList() async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      final url = Uri.parse(
          '${EndPoints.baseUrl}${EndPoints.profile}${EndPoints.followers}');
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      try {
        final response = await http.get(url, headers: header);
        log('get response ${response.body}');
        if (response.statusCode == 200) {
          final data =jsonDecode(response.body);
          print('helo');
          List<UserRelation> followersList = [];
         
          for (var item in data["after execution"]["UserData"]) {
            followersList.add(UserRelation.froJson(item));
          }
           print('helodd');
          //log('=============${followersList[0].name}');
          return followersList;
        } else if (response.statusCode == 400) {
          return [];
          //for test
          // String newAccessToken = await tokens.getAccessTokenRegenerator();
          // log('new accesstoken assigned');
          // secureStorage.writeSecureStorage('AccessToken', newAccessToken);
          // accessToken = newAccessToken;
          // return getFollowersList();
        }
        throw Exception('error in get followerlist ');
      } catch (e) {
        log(e.toString());
        throw Exception('error is $e');
      }
    } else {
      throw Exception('token is missing');
    }
  }

   Future<List<UserRelation>> getFollowingList() async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      final url = Uri.parse(
          '${EndPoints.baseUrl}${EndPoints.profile}${EndPoints.following}');
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      try {
        final response = await http.get(url, headers: header);
        log('get response ${response.body}');
        if (response.statusCode == 200) {
          final data =jsonDecode(response.body);
          print('helo');
          List<UserRelation> followeingList = [];
         
          for (var item in data["after execution"]["UserData"]) {
            followeingList.add(UserRelation.froJson(item));
          }
           print('helodd');
          //log('=============${followersList[0].name}');
          return followeingList;
        } else if (response.statusCode == 400) {
          return [];
          // String newAccessToken = await tokens.getAccessTokenRegenerator();
          // log('new accesstoken assigned');
          // secureStorage.writeSecureStorage('AccessToken', newAccessToken);
          // accessToken = newAccessToken;
          // return getFollowingList();
        }
        throw Exception('error in get followeingList ');
      } catch (e) {
        log(e.toString());
        throw Exception('error is $e');
      }
    } else {
      throw Exception('token is missing');
    }
  }
}
