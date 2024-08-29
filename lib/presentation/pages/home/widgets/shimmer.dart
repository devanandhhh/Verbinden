import 'package:flutter/material.dart';
import 'package:verbinden/core/constant.dart';

Row shimmerSecOne(context) {
  return Row(
    children: [
      w20,
      const Skelton(height: 60, width: 60),
      w10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h30,
          Skelton(
              height: MediaQuery.of(context).size.height * .02,
              width: MediaQuery.of(context).size.width * .58),
          h10,
          Skelton(
              height: MediaQuery.of(context).size.height * .02,
              width: MediaQuery.of(context).size.width * .38),
              h20 
        ],
      )
    ],
  );
}

Column shimmerUserPost(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skelton(height: 60, width: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // buildUpperSession(context),
                  Skelton(
                      height: MediaQuery.of(context).size.height * .02,
                      width: MediaQuery.of(context).size.width * .48),
                  h10,
                  Skelton(
                      height: MediaQuery.of(context).size.height * .02,
                      width: MediaQuery.of(context).size.width * .28),
                  // buildPostImage(context),
                  h20,
                  Skelton(
                      height: MediaQuery.of(context).size.height * .42,
                      width: MediaQuery.of(context).size.width * .68),
                  // buildInteractionRow(context)
                ],
              ),
            )
          ],
        ),
      ),
      
    ],
  );
}
class Skelton extends StatelessWidget {
  const Skelton({super.key, required this.height, required this.width});
final double height,width;
  @override
  Widget build(BuildContext context) {
    return Container(height: height,width: width,padding:const EdgeInsets.all(8),decoration: BoxDecoration(color: Colors.black.withOpacity(0.04),borderRadius: BorderRadius.circular(16)));
   
  }
}