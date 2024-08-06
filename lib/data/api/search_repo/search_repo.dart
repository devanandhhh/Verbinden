import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/models/get_search_result/get_search_result.dart';

import '../../secure_storage/secure_storage.dart';
import '../profile_repo/section_2/profile_section_service.dart';
import 'package:http/http.dart' as http;

class SearchService {
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();
  //get search result
  Future<List<GetSearchResult>> getSearchList(
      {int limit = 5, int offset = 0, required String userName}) async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      final url = Uri.parse(
              '${EndPoints.baseUrl}${EndPoints.exploreSearchUser}$userName?')
          .replace(
        queryParameters: {
          'limit': limit.toString(),
          'offset': offset.toString()
        },
      );
      try {
        final response = await http.get(url, headers: header);
        print('search response $response');
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          List<GetSearchResult> getResult = [];
          for (var item in data['after execution']['SearchResult']) {
            getResult.add(GetSearchResult.fromJson(item));
          }
          return getResult;
        } else if (response.statusCode == 400) {
          String gResponse = await tokens.getAccessTokenRegenerator();
          log('$gResponse gresponse');
          secureStorage.writeSecureStorage('AccessToken', gResponse);

          accessToken = gResponse;
          return getSearchList(limit: limit, offset: 0, userName: userName);
        }
        throw Exception('error in getsearchresult');
      } catch (e) {
        log(
          e.toString(),
        );
        throw Exception('error $e getsearchresult');
      }
    } else {
      throw Exception('error on get all post');
    }
  }
}
