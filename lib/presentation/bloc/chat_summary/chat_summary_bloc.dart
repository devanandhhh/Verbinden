import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/chat_summary/chat_summary.dart';
import 'package:verbinden/data/models/chat_summary/chat_summary.dart';

part 'chat_summary_event.dart';
part 'chat_summary_state.dart';

class ChatSummaryBloc extends Bloc<ChatSummaryEvent, ChatSummaryState> {
  ChatSummaryBloc() : super(ChatSummaryInitial()) {
    ChatSummaryService service =ChatSummaryService();
    on<ChatSummaryFetchEvent>((event, emit)async {
     emit(ChatSummaryLoadingState());
     try {
       final responsedata = await service.getChatSummary();
       log(responsedata.toString());
       emit(ChatSummaryLoadedState(chatSummary: responsedata));
     } catch (e) {
       log('error in bloc chatsummary $e');
       emit(ChatSummaryFailureState(error: e.toString()));
     }
    });
  }
}
