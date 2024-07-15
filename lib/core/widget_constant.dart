//basic use colors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/core/colors_constant.dart';


SizedBox ksizedbox10 = const SizedBox(
  height: 10,
);
SizedBox ksizedbox30 = const SizedBox(
  height: 30,
);
SizedBox ksizedbox20 = const SizedBox(
  height: 20,
);
SizedBox ksizedbox90 = const SizedBox(
  height: 90,
);
//---------------------------------------------------
SizedBox kWsizedbox20 =const SizedBox(width: 20,);
SizedBox kWsizedbox10 =const SizedBox(width: 10,);






//--------------------------------------------------
TextStyle ksimpleStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);
TextStyle googleFabz =  GoogleFonts.aBeeZee();
TextStyle googleFabz20 =  GoogleFonts.aBeeZee(textStyle:const TextStyle(fontSize: 19,));
TextStyle googleFabz18 =  GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: 17,color: kgreyColor));

TextStyle gfontsize20=GoogleFonts.merriweather(textStyle:TextStyle(fontSize: 20));
TextStyle gfontsize30=GoogleFonts.merriweather(textStyle:TextStyle(fontSize: 30));
//-------------------------------------------------------
TextStyle gFaBeeZe(double size,Color color){
  return  GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: size,fontWeight: FontWeight.bold,color: color));
}