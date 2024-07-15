import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verbinden/presentation/pages/message/user_message/user_message.dart';

import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbarDecorate("Messages"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  knavigatorPush(
                      context,
                      const UserMessage(
                        nameofmessager: 'Suhail',
                      ));
                },
                child: const MessageBar(
                    name: 'Suhail', time: '11:43 PM', lastmsg: 'last msg')),
            MessageBar(name: 'Anandu', time: '02:32 PM', lastmsg: 'okay'),
            MessageBar(name: 'Hari', time: '03:32 PM', lastmsg: 'latest msg'),
            MessageBar(name: 'Kevin', time: '05:32 PM', lastmsg: 'okay')
          ],
        ),
      ),
    );
  }
}
