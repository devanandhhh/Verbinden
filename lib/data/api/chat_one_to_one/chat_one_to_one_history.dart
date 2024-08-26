import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/api/profile_repo/section_2/profile_section_service.dart';
import 'package:verbinden/data/models/chat_message/chat_message.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';

class ChatOneToOneHistoryService {
  GetTokensHere token = GetTokensHere();
  SecureStorageService storage = SecureStorageService();
  Future<List<ChatMessage>> getChatMessage(
      {required String userid, int limit = 25, int offset = 0}) async {
    String? accessToken = await token.getAccessToken();
    String? refreshToken = await token.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      final url = Uri.parse(
              '${EndPoints.baseUrl}${EndPoints.chat}${EndPoints.onetoonechats}/$userid?')
          .replace(
        queryParameters: {
          'limit': limit.toString(),
          'offset': offset.toString()
        },
      );
      try {
        final response = await http.get(url, headers: header);
        if (response.statusCode == 200) {
          List<ChatMessage> chatMessage = [];
          final data = jsonDecode(response.body);
          for (var iteam in data['after execution']["Chat"]) {
            log('chatmessage ${iteam}');
            chatMessage.add(ChatMessage.fromJson(iteam));
           
          }
           return chatMessage;
        } else if (response.statusCode == 400) {
          String newAccessToken = await token.getAccessTokenRegenerator();
          log('$newAccessToken newaccesstoken');
          storage.writeSecureStorage('AccessToken', newAccessToken);
          accessToken = newAccessToken;
          return getChatMessage(userid: userid);
        }
        log(response.body);
        throw Exception('error in chat ontoone ');
      } catch (e) {
        log('error is $e ');
        throw Exception('error is $e');
      }
    } else {
      throw Exception('token expired');
    }
  }
}
