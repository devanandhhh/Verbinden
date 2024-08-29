import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/core/style.dart';
import 'package:verbinden/presentation/pages/message/message_page.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';

import '../../../../data/api/websocket_repo/websocket_repo.dart';
import '../../../../data/models/chat_message/chat_message.dart';
import '../../../bloc/chat_history/chat_history_bloc.dart';
import '../../../bloc/chat_summary/chat_summary_bloc.dart';

class UserMessage extends StatelessWidget {
  UserMessage(
      {super.key,
      required this.nameofmessager,
      this.imageurl,
      this.lastSeen,
      required this.userId});
  final String nameofmessager;
  final String? imageurl;
  final String userId;
  final String? lastSeen;

  final TextEditingController messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WebsocketService().toConnectChannel(context); 
    // String lastShownDate = '';
    context.read<ChatHistoryBloc>().add(FetchAllChatEvent(userid: userId));
    return Scaffold(
      backgroundColor: kbluegreyColor,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          buildChatHistory(),
          buildMessageInputField(context),
        ],
      ),
    );
  }

  Align buildMessageInputField(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          buildMessageTextField(context),
          buildSentButton(context),
        ],
      ),
    );
  }

  GestureDetector buildSentButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (messageController.text.isNotEmpty) {
          context.read<ChatHistoryBloc>().add(
              ChatSentEvent(userId: userId, message: messageController.text));
          messageController.clear();
        } else {
          log('Message is empty, not sending.');
        }
      },
      child: CircleAvatar(
        radius: 27,
        backgroundColor: kmain200,
        child: const Icon(Icons.send),
      ),
    );
  }

  Container buildMessageTextField(BuildContext context) {
    return Container(
      color: kbluegreyColor,
      width: MediaQuery.of(context).size.width - 65,
      child: Card(
        margin: const EdgeInsets.only(left: 6, bottom: 10, right: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        child: TextFormField(
          controller: messageController,
          //maxLength: 10,
          decoration: const InputDecoration(
              hintText: 'Type something', contentPadding: EdgeInsets.all(20)),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          minLines: 1,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.read<ChatSummaryBloc>().add(ChatSummaryFetchEvent());
          Navigator.pop(context);
        },
      ),
      //actions: [buildPopupMenu()],
      backgroundColor: kbluegreyColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: ksnackbarGreen,
            backgroundImage: NetworkImage(imageurl ?? unKnown),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // knavigatorPush(context, const OthersProfilePage());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameofmessager,
                  style: gFaBeeZe(20, kblackColor),
                ),
                Row(
                  children: [
                    Text(
                      'Last Seen : ',
                      style: gFaBeeZe(12, kblackColor),
                    ),
                    Text(lastSeen ?? 'no Active',
                        style: gFaBeeZe(12, kblackColor)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildChatHistory() {
    return Expanded(
      child: BlocBuilder<ChatHistoryBloc, ChatHistoryState>(
        builder: (context, state) {
          if (state is ChatHistoryLoadedState) {
            //String lastShownDate = '';

            return buildChatBubble(state);
          } else if (state is ChatHistoryFaliureState) {
            return ksizedbox225Text(title: 'No Chat Available');
          }

          return sizedboxWithCircleprogressIndicator();
          //Container();
        },
      ),
    );
  }

  ListView buildChatBubble(ChatHistoryLoadedState state) {
    return ListView.builder(
      reverse: true,
      //separatorBuilder: (ctx,index)=>kdivider() ,
      controller: _scrollController,
      itemCount: state.chatMessage!.length,
      itemBuilder: (context, index) {
        ChatMessage chat = state.chatMessage![index];

        String time = chat.timeStamp ?? '';
        final formattedDate = getDate(time);
        final formattedTime = formatTime(time);
        formatDate(time);
        //  bool showDate = formattedDate != lastShownDate;
        // if (showDate) {
        //   lastShownDate = formattedDate; // Update the last shown date
        // }

        // Check if the date changes from the previous message
        bool showDate = index == state.chatMessage!.length - 1 ||
            getDate(state.chatMessage![index + 1].timeStamp ?? '') !=
                formattedDate;
        return Column(
          children: [
            h10,
            if (showDate)
              Text(convertDateFormat(formattedDate),
                  style: gFaBeeZe(12, kwhiteColor)),
            h20,
            Align(
              alignment: userId != chat.senderId
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: userId != chat.senderId ? kmainColor : kgrey200,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10),
                      bottomLeft: userId != chat.senderId
                          ? const Radius.circular(10)
                          : Radius.zero,
                      bottomRight: userId != chat.senderId
                          ? Radius.zero
                          : const Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(chat.content ?? '',
                            style: gFaBeeZe(
                                15,
                                userId != chat.senderId
                                    ? kblackColor
                                    : kwhiteColor)),
                      ),
                      w20,
                      Text(formattedTime,
                          style: userId == chat.senderId
                              ? textWhiteMsgTime
                              : textblackMsgTime)
                    ],
                  ),
                ),
              ),
            ),
            h20
          ],
        );
      },
    );
  }
}

String getDate(String timestamp) {
  DateTime parsedDateTime = DateTime.parse(timestamp.split(" ")[0]);
  return "${parsedDateTime.year}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')}";
}

String getTime(String timestamp) {
  DateTime parsedDateTime = DateTime.parse(timestamp.split(" ")[0]);
  // Format the time as HH:MM, excluding the seconds.
  return "${parsedDateTime.hour.toString().padLeft(2, '0')}:${parsedDateTime.minute.toString().padLeft(2, '0')}";
}
