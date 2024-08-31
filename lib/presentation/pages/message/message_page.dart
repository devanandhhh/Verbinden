import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/core/style.dart';
import 'package:verbinden/presentation/pages/home/widgets/shimmer.dart';

import 'package:verbinden/presentation/pages/message/user_message/user_message.dart';

import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../../bloc/chat_summary/chat_summary_bloc.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    context.read<ChatSummaryBloc>().add(ChatSummaryFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    context.read<ChatSummaryBloc>().add(ChatSummaryFetchEvent());
    return Scaffold(
      appBar: kAppbarDecorate("Messages"),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return shimmerSecOne(context); // Your shimmer widget
              },
              separatorBuilder: (context, index) => kdivider(),
              itemCount: 10,
            );
          } else {
            return BlocBuilder<ChatSummaryBloc, ChatSummaryState>(
                builder: (context, state) {
              if (state is ChatSummaryLoadingState) {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return shimmerSecOne(context);
                      },
                      separatorBuilder: (context, index) => kdivider(),
                      itemCount: 10),
                );
              } else if (state is ChatSummaryFailureState) {
                return Center(
                    child: Text(
                  'No Chat Yet',
                  style: gFaBeeZe(30, kgrey200),
                ));
              } else if (state is ChatSummaryLoadedState) {
                return
                    //  SingleChildScrollView(
                    //   child:
                    Column(
                  children: [
                    kdivider(),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final chatSummary = state.chatSummary[index];
                            final time =
                                formatTime(chatSummary.lastMessageTimeStamp);
                            final date =
                                getDate(chatSummary.lastMessageTimeStamp);

                            return GestureDetector(
                              onTap: () {
                                knavigatorPush(
                                    context,
                                    UserMessage(
                                      nameofmessager: chatSummary.userName,
                                      imageurl: chatSummary.userProfileURL,
                                      userId: chatSummary.userID,
                                      lastSeen: time,
                                    ));
                              },
                              child: MessageBar(
                                  imageurl: chatSummary.userProfileURL,
                                  name: chatSummary.userName,
                                  time: time,
                                  date: convertDateFormat(date),
                                  lastmsg: chatSummary.lastMessageContent),
                            );
                          },
                          separatorBuilder: (context, index) => w10,
                          itemCount: state.chatSummary.length),
                    ),
                  ],
                );
                // );
              }
              return const Center(
                child: Text('No text message yet'),
              );
            });
          }
        },
      ),
    );
  }
}

String? formatDate(String? timedata) {
  if (timedata != null) {
    String date = timedata.split(' ').sublist(0, 1).toString();
    // print(date);
    return date;
  }
  return '';
}

String formatTime(String? timestamp) {
  if (timestamp == null) return 'Invalid Time';
  try {
    String cleanedTimestamp = timestamp.split(' ').sublist(0, 2).join(' ');
    DateTime dateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(cleanedTimestamp);
    return DateFormat('hh:mm a').format(dateTime);
  } catch (e) {
    return 'Invalid Time';
  }
}
String convertDateFormat(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));

    // Check if the date is today
    if (parsedDate.year == today.year &&
        parsedDate.month == today.month &&
        parsedDate.day == today.day) {
      return 'Today';
    }

    // Check if the date is yesterday
    if (parsedDate.year == yesterday.year &&
        parsedDate.month == yesterday.month &&
        parsedDate.day == yesterday.day) {
      return 'Yesterday';
    }

    // Format the date if it's neither today nor yesterday
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    return formattedDate;
  } catch (e) {
    return 'Invalid Date';
  }
}
