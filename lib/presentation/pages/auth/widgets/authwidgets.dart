import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/core/widget_constant.dart';

import '../../../../core/colors_constant.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    this.titleTxt,
  });
  final String? titleTxt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleTxt!,
          style: GoogleFonts.merriweather(
              textStyle: TextStyle(
                  color: Colors.blueGrey[600],
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
        Text(
          'Verbinden',
          style: GoogleFonts.outfit(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kmainColor,
                  fontSize: 53)),
        )
      ],
    );
  }
}

Text authButtonText(String title) {
  return Text(
    title,
    style: TextStyle(
        color: kmainColor,
        decorationColor: kmainColor,
        fontWeight: FontWeight.bold),
  );
}

Container authButton(String? text) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: kmainColor,
    ),
    child: Center(
        child: Text(
      text!,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    )),
  );
}

SnackBar kSnakbar({required String text, Color col = Colors.grey}) {
  return SnackBar(
    duration: const Duration(milliseconds: 1400),
    content: Text(text,
        style: GoogleFonts.mukta(textStyle: const TextStyle(fontSize: 17))
        // TextStyle(color: kwhiteColor, fontWeight: FontWeight.w300,),
        ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: col,
  );
}

Container authButtonS(String text) {
  return Container(
    height: 50,
    width: 120,
    decoration: BoxDecoration(
        color: kmainColor, borderRadius: BorderRadius.circular(10)),
    child: Center(
        child: Text(
      text,
      style: ksimpleStyle,
    )),
  );
}

Container kwidth90Button(String title) => Container(
      height: 40,
      width: 90,
      decoration: BoxDecoration(
          color: kmainColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      )),
    );
