
import 'package:flutter/material.dart';
import 'package:verbinden/core/constant.dart';

import '../../../../core/colors_constant.dart';
import '../../../../core/style.dart';

class SectionOne extends StatelessWidget {
  const SectionOne({super.key, required this.userName, this.userImage});
  final String userName;
  final String? userImage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height:
       size.height*0.11, 
      //85,
      width: double.infinity ,
      //  color: ksnackbarGreen,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: ksnackbarRed,
              //backgroundImage:NetworkImage(userImage??unKnown,),
              child: ClipOval(
                child: Image.network(
                  userImage ?? unKnown,
                  fit: BoxFit.cover,
                  width: 50.0,
                  height: 50.0,
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child: Image.network(unKnown)
                          // Text('😢'),
                          ),
                  loadingBuilder: (context, child, loadingProgress) {
                    final totalBytes = loadingProgress?.expectedTotalBytes;
                    final bytesLoaded = loadingProgress?.cumulativeBytesLoaded;
                    if (totalBytes != null && bytesLoaded != null) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white70,
                          value: bytesLoaded / totalBytes,
                          color: kmain200,
                          strokeWidth: 5.0,
                        ),
                      );
                    } else {
                      return child;
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: gFaBeeZe(16, kblackColor),
                  ),
                  Text("What's new?", style: gFaBeeZe(12, kgreyColor))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
