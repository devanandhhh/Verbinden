import 'package:flutter/material.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

import '../../../../core/colors_constant.dart';
import '../../../../core/style.dart';

class SectionOne extends StatelessWidget {
  const SectionOne({super.key, required this.userName, this.userImage});
  final String userName;
  final String? userImage;
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
              //backgroundImage:NetworkImage(userImage??unKnown,),
              child: ClipOval(
                child: Image.network(
                  userImage ?? unKnown,
                  fit: BoxFit.cover,width: 50.0,height: 50.0,
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

class OthersPostContainer extends StatelessWidget {
  const OthersPostContainer(
      {super.key,
      required this.username,
      required this.time,
      required this.description,
      required this.postImage,
      this.profileImage,
      this.likeCount,
      this.commentCount});

  final String username;
  final String time;
  final String description;
  final String postImage;
  final String? profileImage;
  final String? likeCount;
  final String? commentCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 290,
          width: double.infinity,
          //color: ksnackbarGreen,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ksnackbarRed,
                  backgroundImage: NetworkImage(
                    profileImage ?? unKnown,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            username,
                            style: gFaBeeZe(16, kblackColor),
                          ),
                          w10,
                          Text(
                            time,
                            style: gFaBeeZe(10, kbluegreyColor),
                          )
                        ],
                      ),
                      Text(description, style: gFaBeeZe(14, kgreyColor)),
                      h10,
                      Container(
                        height: 170,
                        width: 282,
                        decoration: BoxDecoration(
                          color: ksnackbarRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            postImage,
                            fit: BoxFit.cover,
                            //adding loading circle
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Text('😢'),
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              final totalBytes =
                                  loadingProgress?.expectedTotalBytes;
                              final bytesLoaded =
                                  loadingProgress?.cumulativeBytesLoaded;
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
                      h10,
                      Row(
                        children: [
                          w10,
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset('lib/core/icons/love.png'),
                          ),
                          likeCount == null ? w20 : Text(likeCount.toString()),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child:
                                Image.asset('lib/core/icons/bubble-chat.png'),
                          ),
                          commentCount == null
                              ? w20
                              : Text(commentCount.toString())
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
