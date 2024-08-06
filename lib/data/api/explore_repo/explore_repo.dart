import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/api/profile_repo/section_2/profile_section_service.dart';
import 'package:verbinden/data/models/allPost/all_post.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';
import 'package:http/http.dart'as http;
class ExploreService{
  GetTokensHere tokensHere =GetTokensHere();
  SecureStorageService secureStorage=SecureStorageService();
  Future<List<OthersPost>> getExplore({int limit=20,int offset =0})async{
    String? accessToken =await tokensHere.getAccessToken();
    String? refreshToken =await tokensHere.getRefreshToken();
    if(accessToken!=null&&refreshToken!=null){
    final header = {'x-api-key': 'apikey@ciao', 'x-access-token': accessToken};
    final url =Uri.parse('${EndPoints.baseUrl}${EndPoints.explore}?').replace(queryParameters: {'limit':limit.toString(),'offset':offset.toString()});
    try {
      final response = await http.get(url,headers: header);
      print('response from getExplore $response');
      if(response.statusCode==200){
        final data =jsonDecode(response.body);
        List<OthersPost> explorePost =[];
        for(var item in data['after execution']['PostsData']){
          explorePost.add(OthersPost.fromJson(item));
        }
        return explorePost;
      }else if(response.statusCode==400){
         String newAccessToken = await tokensHere.getAccessTokenRegenerator();
          // await accessTokenReGenerator.accessReGenerator(accessToken, refreshToken);
          log('$newAccessToken newaccesstoken');
          secureStorage.writeSecureStorage('AccessToken', newAccessToken);
          accessToken = newAccessToken;
          return getExplore(limit: 1,offset: 0);
      }
      throw Exception('error is getexplore');
    } catch (e) {
      log('$e error by get xplore');
     throw Exception('error is $e');
    }
    }else{
      throw Exception('tokens are missing');
    }
  }
}