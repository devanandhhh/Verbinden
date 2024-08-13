import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../../core/style.dart';
import '../../../bloc/post_comment/post_comment_bloc.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.postId});
  final int postId;
  @override
  Widget build(BuildContext context) {
    context.read<PostCommentBloc>().add(FetchAllCommentsEvent(postId: postId));
    //context.read<PostCommentBloc>().add(FetchCommentsCountEvent(postId: postId));
    final commentController = TextEditingController();
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: Container(
            color: Colors.grey[400],
            height: 300,
            // child: Stack(
            //   children: [
            //     Positioned(
            //       top: 8,
            //       left: 140,
            child: Column(
              children: [
                h10,
                Container(
                  width: 100,
                  height: 3,
                  color: kblackColor,
                ),
                h20,
                Text('Comments', style: gPoppines15),
                h20,
                Expanded(
                  child: BlocBuilder<PostCommentBloc, PostCommentState>(
                    builder: (context, state) {
                      if (state is PostCommentLoadingState) {
                        return sizedboxWithCircleprogressIndicator();
                        // } else if (state is PostCommentClickedState) {
                        //   return ksizedbox225Text(title: 'clicked');
                      } else if (state is CommentsFetchedState) {
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final data = state.modelComment[index];
                              //checking is the user
                              bool isUserTrue =
                                  nameofuser == data!.userName ? true : false;
                              return ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        data.userprofileimageUrl ?? unKnown),
                                    radius: 30),
                                title: Row(
                                  children: [
                                    Text(
                                      data.userName,
                                      style: gFaBeeZe(16, kblackColor),
                                    ),
                                    w10,
                                    Text(
                                      data.commentAge,
                                      style: gFaBeeZe(10, kbluegreyColor),
                                    )
                                  ],
                                ),
                                subtitle: Text(data.commentText),
                                trailing: isUserTrue
                                    ? PopupMenuButton(
                                        icon: const Icon(Icons.more_vert),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: const Text('Edit'),
                                              onTap: () {
                                                final commentController =
                                                    TextEditingController(
                                                        text: data.commentText);
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: Text(
                                                        'Edit Comment',
                                                        style: gPoppines33,
                                                      ),
                                                      content: Column(
                                                        children: [
                                                          h20,
                                                          TextFormField(
                                                            controller:
                                                                commentController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Cancel',
                                                              style:
                                                                  gPoppines15,
                                                            )),
                                                        TextButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    PostCommentBloc>()
                                                                .add(EditCommentEvent(
                                                                    commentId: data
                                                                        .commentId,
                                                                    commentText:
                                                                        commentController
                                                                            .text));
                                                            Navigator.pop(
                                                                context);
                                                            log('here');
                                                            context
                                                                .read<
                                                                    PostCommentBloc>()
                                                                .add(FetchAllCommentsEvent(
                                                                    postId: data
                                                                        .postId));
                                                          },
                                                          child: Text(
                                                            'Edit',
                                                            style: gPoppines15,
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                                // context.read<>()
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: const Text('Delete'),
                                              onTap: () {
                                                context
                                                    .read<PostCommentBloc>()
                                                    .add(DeleteCommentEvent(
                                                        commentId:
                                                            data.commentId,
                                                        postId: data.postId));
                                                context
                                                    .read<PostCommentBloc>()
                                                    .add(FetchAllCommentsEvent(
                                                        postId: data.postId));
                                              },
                                            )
                                          ];
                                        })
                                    : null,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return kdivider();
                            },
                            itemCount: state.commentCount);
                      } else if (state is CommentsFetchFaliureState) {
                        return const SizedBox(
                            height: 310,
                            width: double.infinity,
                            child: Center(
                              child: Text('No Comments'),
                            ));
                      } else if (state is PostCommentClickedState) {
                        context
                            .read<PostCommentBloc>()
                            .add(FetchAllCommentsEvent(postId: postId));
                      }
                      return ksizedbox225Text(title: 'nothing visible');
                      // return Expanded(
                      //     //fit: FlexFit.loose,
                      //     child: ListView.separated(
                      //         shrinkWrap: true,
                      //         itemBuilder: (context, index) {
                      //           return ListTile(
                      //             leading: const CircleAvatar(
                      //                 backgroundImage: NetworkImage(unKnown),
                      //                 radius: 30),
                      //             title: Text('Username $index'),
                      //             subtitle: Text('comment $index'),
                      //             trailing: const Icon(Icons.more_vert),
                      //           );
                      //         },
                      //         separatorBuilder: (context, index) {
                      //           return kdivider();
                      //         },
                      //         itemCount: 24));
                    },
                  ),
                )
                //],
                // ),
                //  ),
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                // child:
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      //color:kwhiteColor,
                      height: 45,
                      width: 380,
                      child: TextFormField(
                          controller: commentController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  context.read<PostCommentBloc>().add(
                                      AddCommentButtonClickEvent(
                                          postId: postId,
                                          comment: commentController.text));
                                  commentController.clear();
                                  context.read<PostCommentBloc>().add(
                                      FetchAllCommentsEvent(postId: postId));
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: 'Add Comment')),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       context.read<PostCommentBloc>().add(
                    //           AddCommentButtonClickEvent(
                    //               postId: postId,
                    //               comment: commentController.text));
                    //       commentController.clear();
                    //       context
                    //           .read<PostCommentBloc>()
                    //           .add(FetchAllCommentsEvent(postId: postId));
                    //     },
                    //     icon: const Icon(Icons.send))
                  ],
                ),
                // /      )
              ],
              //   ),
            )));
  }
}
