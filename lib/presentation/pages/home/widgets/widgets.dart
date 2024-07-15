
import 'package:flutter/material.dart';
import 'package:verbinden/core/widget_constant.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

import '../../../../core/colors_constant.dart';

class SectionOne extends StatelessWidget {
  const SectionOne({
    super.key,required this.userName
  });
final String userName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: double.infinity,
    //  color: ksnackbarGreen,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: ksnackbarRed,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 10), 
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                Text(userName,style:gFaBeeZe(16, kblackColor),), 
                Text("What's new?" ,style: gFaBeeZe(12, kgreyColor))
              ],),
            )
          ],
        ),
      ),
    );
  }
}

class OthersPostContainer extends StatelessWidget {
  const OthersPostContainer({
    super.key,required this.username,required this.time,required this.description
  });
final String username;
final String time;
final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 290, 
          width: double.infinity,
          //color: ksnackbarGreen,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ksnackbarRed,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                           username,
                            style: gFaBeeZe(16, kblackColor),
                          ),
                          kWsizedbox10,
                          Text( 
                           time,
                            style: gFaBeeZe(10, kbluegreyColor),
                          )
                        ],
                      ),
                      Text(description,
                          style: gFaBeeZe(14, kgreyColor)),
                      ksizedbox10,
                      Container(
                        height: 170,
                        width: 282,
                        decoration: BoxDecoration(
                            color: ksnackbarRed,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      ksizedbox10,
                      Row(
                        children: [
                          kWsizedbox10,
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset('lib/core/icons/love.png'),
                          ),
                          kWsizedbox20,
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                                'lib/core/icons/bubble-chat.png'),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        kdivider()
      ],
    );
  }
}

