import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/websocket_repo/websocket_repo.dart';
import 'package:verbinden/data/models/chat_message/chat_message.dart';

import '../../../data/api/chat_one_to_one/chat_one_to_one_history.dart';

part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  List<ChatMessage>? allMessage = [];
  WebsocketService webservice =WebsocketService();
   ChatOneToOneHistoryService service =ChatOneToOneHistoryService();

  ChatHistoryBloc() : super(ChatHistoryInitial()) {
    
    on<FetchAllChatEvent>(onFetchAllChat);
    on<ChatSentEvent>(onChatSent);
// chat_history_bloc.dart

    on<ReceiveChatEvent>((event, emit) {
     // allMessage?.add(event.chatMessage);
allMessage?.insert(0, event.chatMessage); 
      emit(ChatHistoryLoadedState(chatMessage: List.from(allMessage!)));
    });

    on<SendChatEvent>(
      (event, emit) {
        //allMessage?.add(event.chatMessage);
        allMessage?.insert(0, event.chatMessage);
        emit(ChatHistoryLoadedState(chatMessage: allMessage!));
      },
    );

    on<OneChatFetchEvent>(
      (event, emit) async {
        try {
          final chats = await ChatOneToOneHistoryService()
              .getChatMessage(userid: event.id);
          allMessage = chats;
          emit(ChatHistoryLoadedState(chatMessage: List.from(allMessage!)));
        } catch (e) {
          log('Error fetching chat history: $e');
          emit(ChatHistoryFaliureState(error: 'Failed to fetch chat history'));
        }
      },
    );
   
  }
   
  FutureOr<void> onFetchAllChat(FetchAllChatEvent event, Emitter<ChatHistoryState> emit)async {
    emit(ChatHistoryLoadingState());
    try{
      //List<ChatMessage> chatList
       allMessage=await service.getChatMessage(userid: event.userid);
      log('chatmessages gotted $allMessage');
      emit(ChatHistoryLoadedState(chatMessage: allMessage));
    }catch(e){
      log('error $e');
      emit(ChatHistoryFaliureState(error: e.toString()));
    }
  }

  FutureOr<void> onChatSent(ChatSentEvent event, Emitter<ChatHistoryState> emit) async{
    emit(ChatHistoryLoadingState());
    try {
      webservice.sendMessage(event.userId, event.message);
      //allMessage?.add(event.message)
      log('message send');
      allMessage!.insert(0, ChatMessage(content: event.message, timeStamp: DateTime.now().toString())); // Add to the start
      //allMessage!.add(ChatMessage(content: event.message, timeStamp: DateTime.now().toString(),));
      emit(ChatHistoryLoadedState(chatMessage: allMessage));
    } catch (e) {
      log('error from onchatsent');
      emit(ChatHistoryFaliureState(error: 'errror'));
    }
  }
}
