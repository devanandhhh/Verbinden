import 'package:flutter/material.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';
import 'package:verbinden/presentation/pages/viewProfile/others_Profile/othersProfile.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({super.key, required this.nameofmessager});
  final String nameofmessager;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: ksnackbarGreen,
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                knavigatorPush(context, const OthersProfilePage());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameofmessager,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Text(
                    'Last seen: 12:00 PM',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            //  Text('hello')
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Type a message',
                    //hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
