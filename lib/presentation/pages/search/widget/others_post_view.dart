
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/data/models/allPost/all_post.dart';
import 'package:verbinden/presentation/pages/profile/widgets/comment_box.dart';

import '../../../../core/constant.dart';
import '../../../../core/style.dart';
import '../../message/widgets/widgets.dart';
import '../../profile/widgets/widgets.dart';

class OthersPostView extends StatelessWidget {
  const OthersPostView({super.key, required this.post, required this.index});
  final int index;
  final OthersPost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Post',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(fontSize: 24, color: kblackColor),
          ),
        ),
      ),
      body: Column(
        children: [
          OthersPostListViewWidget(
            post: post,
            username: post.userName,
            time: post.postAge,
            description: post.caption ?? 'nothing',
            postImage: post.mediaUrl[0],
            profileImage: post.userProfileImgUrl,
            likeCount: post.likesCount.toString(),
            commentCount: post.commentsCount.toString(),
          ),
        ],
      ),
    );
  }
}

class OthersPostListViewWidget extends StatelessWidget {
  const OthersPostListViewWidget(
      {super.key,
      required this.post,
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
  final OthersPost   post;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 290,
          width: double.infinity,
          // color: ksnackbarGreen,
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
                          SizedBox(
                            width: 250,
                            height: 40,
                            //color: kredColor,
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
                                Text(description,
                                    style: gFaBeeZe(14, kgreyColor)),
                              ],
                            ),
                          ),
                          w10,
                          SizedBox(
                            width: 30,
                            height: 40,
                            //color: kmain200,
                            child: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Text(
                                      'View Profile',
                                      style: gPoppines15,
                                    ),
                                    onTap: () {
                                     
                                    },
                                  ),
                                  // PopupMenuItem(
                                  //   child: Text(
                                  //     'Delete',
                                  //     style: gPoppines15,
                                  //   ),
                                  //   onTap: () {
                                      
                                  //   },
                                  // )
                                ];
                              },
                            ),
                          )
                        ],
                      ),
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
                          ),
                        ),
                      ),
                      h10,
                      Row(
                        children: [
                          w10,
                          LikeButton(size: 30,likeCount:int.tryParse(likeCount.toString()) ,),
                          // SizedBox(
                          //   height: 20,
                          //   width: 20,
                          //   child: Image.asset('lib/core/icons/love.png'),
                          // ),
                          // likeCount == null ? w20 : w10,
                          // Text(
                          //   likeCount.toString(),
                          //   style: gPoppines15,
                          // ),
                          w10,
                          
                          GestureDetector(
                            onTap: (){
                              showBottomSheet(backgroundColor: Colors.transparent,
                                context: context, builder: (context){
                                
                                return DraggableScrollableSheet(
                                  initialChildSize: 0.6,minChildSize: 0.2,maxChildSize: 0.6,
                                  builder: (context, scrollController) {
                                  return CommentBox();
                                },);
                              });
                            },
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child:
                                  Image.asset('lib/core/icons/bubble-chat.png'),
                            ),
                          ),
                          // commentCount.toString()=='null' ? w20 :
                          //  w10,
                          // Text(commentCount.toString(), style: gPoppines15),
                          w10
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
