part of 'chat_summary_bloc.dart';

@immutable
abstract class ChatSummaryState {}

class ChatSummaryInitial extends ChatSummaryState {}

class ChatSummaryLoadingState extends ChatSummaryState {}

class ChatSummaryLoadedState extends ChatSummaryState {
  final List<ChatSummary> chatSummary;
  ChatSummaryLoadedState({required this.chatSummary});
}

class ChatSummaryFailureState extends ChatSummaryState{
  final String error ;

  ChatSummaryFailureState({required this.error});

}