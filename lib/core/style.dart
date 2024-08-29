import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/core/colors_constant.dart';

final googleFabz = GoogleFonts.aBeeZee();
final googleFabz20 = GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 19,));
final googleFabz18 =GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 17, color: kgreyColor));

final gfontsize20 =GoogleFonts.merriweather(textStyle:const TextStyle(fontSize: 20));
final gfontsize30 =GoogleFonts.merriweather(textStyle:const TextStyle(fontSize: 30));
//-------------------------------------------------------
 gFaBeeZe(double size, Color color) {
  return GoogleFonts.aBeeZee(
      textStyle:
          TextStyle(fontSize: size, fontWeight: FontWeight.bold, color: color));
}   
final textWhiteMsgTime = GoogleFonts.aBeeZee(color: kwhiteColor);
final textblackMsgTime = GoogleFonts.aBeeZee(color: kblackColor);
