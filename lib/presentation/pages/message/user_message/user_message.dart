import 'package:flutter/material.dart';
import 'package:verbinden/core/colors_constant.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({super.key, required this.nameofmessager});
  final String nameofmessager;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbluegreyColor,
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
                  // knavigatorPush(context, const OthersProfilePage());
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              ListView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      color: kbluegreyColor,
                      width: MediaQuery.of(context).size.width - 65,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 6, bottom: 1, right: 4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19)),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Type something',
                              contentPadding: EdgeInsets.all(20)),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: kmain200,
                      child: const Icon(Icons.send),
                    )
                  ],
                ),
              )
            ],
          ),
        )
       
        );
  }
}
