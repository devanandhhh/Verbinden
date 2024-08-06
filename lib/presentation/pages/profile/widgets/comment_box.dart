import 'package:flutter/material.dart';
import 'package:verbinden/core/colors_constant.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key});

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: Container(
          color: Colors.grey[400],
          height: 300,
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 140,
                child: Container(
                  width: 100,
                  height: 3,
                  color: kblackColor,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: kwhiteColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: TextField(
                            controller: commentController,
                            maxLines: 4,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: 'Add Comment')),
                      ),
                      const Icon(Icons.send)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
