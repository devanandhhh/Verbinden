import 'dart:convert';
import 'dart:developer';

import 'package:verbinden/core/endpoints.dart';
import 'package:verbinden/data/api/profile_repo/section_2/profile_section_service.dart';
import 'package:verbinden/data/models/chat_summary/chat_summary.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class ChatSummaryService {
  GetTokensHere tokens = GetTokensHere();
  SecureStorageService storage = SecureStorageService();
  Future<List<ChatSummary>> getChatSummary() async {
    String? accessToken = await tokens.getAccessToken();
    String? refreshToken = await tokens.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      final url = Uri.parse(
          '${EndPoints.baseUrl}${EndPoints.chat}${EndPoints.recentChatProfiles}');

      try {
        final response = await http.get(url, headers: header);
        log('response ${response.body}');
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          List<ChatSummary> chatSummary = [];
          for (var item in data["after execution"]["ActualData"]) {
            log('item is $item');
            chatSummary.add(ChatSummary.fromJson(item));
          }
          return chatSummary;
        } else if (response.statusCode == 400) {
          String newAccessToken = await tokens.getAccessTokenRegenerator();
          log('$newAccessToken newaccesstoken');
          storage.writeSecureStorage('AccessToken', newAccessToken);
          accessToken = newAccessToken;
          return getChatSummary();
        }
        throw Exception('error in get chat summary');
      } catch (e) {
        log('error is $e');
        throw Exception('error by $e');
      }
    } else {
      throw Exception('tokens are missing');
    }
  }
}
