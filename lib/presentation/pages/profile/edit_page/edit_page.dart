import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

class Editpage extends StatelessWidget {
  const Editpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(fontSize: 24, color: kblackColor),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {},
            color: kmainColor,
            child: Text(
              'Done',
              style: gPoppines15,
            ),
          ),
          w20
        ],
        //automaticallyImplyLeading: backbutton,
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 280,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9), color: kgreyColor),

        ),
      ),
    );
  }
}
