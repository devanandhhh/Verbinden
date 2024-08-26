part of 'chat_history_bloc.dart';

@immutable
abstract class ChatHistoryState {}

class ChatHistoryInitial extends ChatHistoryState {}

class ChatHistoryLoadingState extends ChatHistoryState{}

class ChatHistoryLoadedState extends ChatHistoryState{
  final List<ChatMessage>? chatMessage;

  ChatHistoryLoadedState({required this.chatMessage, });
}

class ChatHistoryFaliureState extends ChatHistoryState{
  final String error;

  ChatHistoryFaliureState({required this.error});
  
}

class ChatEmptyState extends ChatHistoryState{}
// class ChatSummaryLoadingState extends ChatHistoryState{}
// class ChatSummarySuccessState extends ChatHistoryState{
//   List<ChatMessage
// }