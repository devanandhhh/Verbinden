import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:like_button/like_button.dart';
import 'package:verbinden/data/models/edit_post/edit_post.dart';
import 'package:verbinden/presentation/pages/profile/widgets/comment_box.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../../core/colors_constant.dart';
import '../../../../core/constant.dart';
import '../../../../core/style.dart';
import '../../../../data/models/getPost/get_post.dart';
import '../../../bloc/userPostFetch/user_post_fech_bloc.dart';
import '../../message/widgets/widgets.dart';

class MyPostViewer extends StatelessWidget {
  const MyPostViewer(
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
  final Post post;
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
                                      'Edit',
                                      style: gPoppines15,
                                    ),
                                    onTap: () {
                                      final captionController =
                                          TextEditingController(
                                              text: post.caption);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: Text(
                                                'Edit Caption',
                                                style: gPoppines33,
                                              ),
                                              content: Column(
                                                children: [
                                                  h20,
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6))),
                                                    controller:
                                                        captionController,
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      final model = EditPostModel(
                                                          caption:
                                                              captionController
                                                                  .text,
                                                          postId: post.postId
                                                              .toString());
                                                      context
                                                          .read<
                                                              UserPostFechBloc>()
                                                          .add(EditPostEvent(
                                                              model: model));
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Edit'))
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      'Delete',
                                      style: gPoppines15,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Do You Want to Delete?',
                                                style: gPoppines15,
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              UserPostFechBloc>()
                                                          .add(DeletePostEvent(
                                                              postId:
                                                                  post.postId));
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Delete'))
                                              ],
                                            );
                                          }

                                          // return KPostDialog(
                                          //     post: post,
                                          //     onDelete: () {
                                          //       context
                                          //           .read<UserPostFechBloc>()
                                          //           .add(DeletePostEvent(
                                          //               postId: post.postId));

                                          );
                                    },
                                  )
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
                        child: InstaImageViewer(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              postImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      h10,
                      Row(
                        children: [
                          w10,
                          LikeButton(
                            size: 30,
                            likeCount: int.tryParse(likeCount.toString()),
                          ),
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
                            onTap: () {
                              showBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return DraggableScrollableSheet(
                                      initialChildSize: 0.6,
                                      minChildSize: 0.2,
                                      maxChildSize: 0.6,
                                      builder: (context, scrollController) {
                                        return CommentBox(
                                          postId: post.postId,
                                        );
                                      },
                                    );
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
