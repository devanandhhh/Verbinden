import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:verbinden/data/api/profile_repo/section_2/profile_section_service.dart';
import 'package:verbinden/data/secure_storage/secure_storage.dart';
import 'package:web_socket_channel/io.dart';

// import 'package:web_socket_channel/status.dart' as status;
//IOWebSocketChannel? channel;

class WebsocketService {
  static final WebsocketService _instance = WebsocketService._internal();
  IOWebSocketChannel? channel;

  factory WebsocketService() {
    return _instance;
  }

  WebsocketService._internal();

  // static final WebsocketService _instance = WebsocketService._internal();
  // factory WebsocketService() => _instance;
  // WebsocketService._internal();
  SecureStorageService secureStorage = SecureStorageService();
  GetTokensHere tokens = GetTokensHere();

  //IOWebSocketChannel? channel;
  // final StreamController streamController = StreamController.broadcast();

  // Stream get messageStream => streamController.stream;

  Future<void> toConnectChannel(BuildContext context) async {
    String? accessToken = await tokens.getAccessToken();
    //  String? refreshToken = await tokens.getRefreshToken();
    if (accessToken != null) {
      final url = Uri.parse('wss://k8s.ciao.ashkar.tech/chat/ws');
      final header = {
        'x-api-key': 'apikey@ciao',
        'x-access-token': accessToken
      };
      try {
        channel = IOWebSocketChannel.connect(url, headers: header);
        log('channel connected to $channel');
        channel?.stream.listen((message) {
          log('recevied message: $message');
          // final decodedMsg =jsonDecode(message);
          // final chat =ChatMessage.fromJson(decodedMsg);
          // streamController.add(chat);

          // context.read<ChatHistoryBloc>().add(ReceiveChatEvent(chatMessage: chat));
        }, onError: (error) {
          log('web socket error :$error');
          // handleWebSocketError(context, error);
        }, onDone: () {
          log('web connection lost');
          //reconnectWebSocket(context);
        });
      } catch (e) {
        log('error from to connect channel $e');
        if (e.toString().contains('400') || e.toString().contains('401')) {
          await handleTokenRegeneration(context);
        }
        throw Exception('failed to connect : $e');
      }
    }
  }

  Future<void> handleTokenRegeneration(BuildContext context) async {
    final newAccessToken = await tokens.getAccessTokenRegenerator();
    if (newAccessToken.isNotEmpty) {
      log('Regenerated access token: $newAccessToken');
      secureStorage.writeSecureStorage('AccessToken', newAccessToken);
      await toConnectChannel(context);
    } else {
      log('Failed to regenerate token');
    }
  }



  void sendMessage(String userId, String message) {
    if (channel != null && channel?.sink != null && message.isNotEmpty) {
      try {
        final formatMessage = {
          "RecipientId": userId,
          "Content": message,
          "Type": "OneToOne"
        };
        channel?.sink.add(jsonEncode(formatMessage));
      } catch (e) {
        log('Error sending message: $e');
      }
    } else {
      log('Cannot send message: Channel is null or message is empty');
    }
  }

  void closeConnection() {
    channel?.sink.close(); //for checking
    // channel?.sink.close(status.goingAway); // Indicate the reason for closing
    // streamController.close(); // Close the broadcast stream
    log('WebSocket connection closed manually.');
  }
}
