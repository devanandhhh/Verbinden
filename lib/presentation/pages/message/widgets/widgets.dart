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
      {super.key,this.imageurl,
      required this.name,
      required this.time,
      required this.lastmsg,required this.date});
  final String time;
  final String name; 
  final String lastmsg;
 final String? imageurl;
 final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //kdivider(),
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
                  image: DecorationImage(image:NetworkImage(imageurl??unKnown,),fit: BoxFit.cover),
                    color: ksnackbarRed,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: SizedBox(
                  width: 200,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shortenString(name, 20),
                        style: googleFabz20,
                      ),
                      Text(
                        shortenString(lastmsg,20),
                        style: googleFabz18,
                      )
                    ],
                  ),
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style:  gFaBeeZe(12, kgreyColor) , 
                  ), 
                   Text(
                    time,
                    style: googleFabz, 
                  ),
                ],
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
String shortenString(String input,int range) { 
  if (input.length > range) {
    return '${input.substring(0, range)}...';
  } else {
    return input;
  }
}