part of 'chat_history_bloc.dart';

@immutable
abstract class ChatHistoryEvent {}

class ReceiveChatEvent extends ChatHistoryEvent {
  final ChatMessage chatMessage;

  ReceiveChatEvent({required this.chatMessage});
}

class FetchSummaryEvent extends ChatHistoryEvent {
  
}

class OneChatFetchEvent extends ChatHistoryEvent {
  final String id;

  OneChatFetchEvent({required this.id});
}

class SendChatEvent extends ChatHistoryEvent {
  final ChatMessage chatMessage;
  SendChatEvent({required this.chatMessage});
}
///============================================================
class FetchAllChatEvent extends ChatHistoryEvent {
  final String userid;

  FetchAllChatEvent({required this.userid});
}
class ChatSentEvent extends ChatHistoryEvent{
  final String userId;
  final String message;

  ChatSentEvent({required this.userId, required this.message});
  
}
