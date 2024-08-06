import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/colors_constant.dart';
import '../../../../core/constant.dart';
import '../../../../core/style.dart';

AppBar kAppbarDecorate(String title,[bool notHomeScreen =false,bool backbutton =false]) {
  return AppBar(
    title: Text(
      title,
      style:notHomeScreen?GoogleFonts.anton(textStyle:TextStyle(fontSize: 34,color:kmainColor),): GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 33)),
    ),
    automaticallyImplyLeading: backbutton,
  );
}

class MessageBar extends StatelessWidget {
  const MessageBar(
      {super.key,
      required this.name,
      required this.time,
      required this.lastmsg});
  final String time;
  final String name; 
  final String lastmsg;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: double.infinity,
          child: Row(
            children: [
              w20,
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  image:const DecorationImage(image:NetworkImage(unKnown)),
                    color: ksnackbarRed,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: SizedBox(
                  width: 220,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: googleFabz20,
                      ),
                      Text(
                        lastmsg,
                        style: googleFabz18,
                      )
                    ],
                  ),
                ),
              ),
              Text(
                time,
                style: googleFabz,
              )
            ],
          ),
        ),
        kdivider()
      ],
    );
  }

 
}
 Padding kdivider() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Divider(),
      );
  }
