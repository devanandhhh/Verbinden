import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:like_button/like_button.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/others_Profile/othersProfile.dart';
import 'package:verbinden/presentation/pages/profile/widgets/comment_box.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../../../../core/colors_constant.dart';
import '../../../../core/style.dart';

class OthersPostContainer extends StatelessWidget {
  const OthersPostContainer(
      {super.key,
      required this.username,
      required this.time,
      required this.description,
      required this.postImage,
      required this.postId,
      required this.userId,
      required this.likeStatus,
      this.profileImage,
      this.likeCount,
      this.commentCount,
      required this.isEnabledPop});

  final String username;
  final String time;
  final String description;
  final String postImage;
  final String? profileImage;
  final int? likeCount;
  final int? commentCount;
  final int postId;
  final int userId;
  final bool likeStatus;
  final bool isEnabledPop;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                    buildUpperSession(context),
                    h10,
                    buildPostImage(context),
                    h10,
                    buildInteractionRow(context)
                  ],
                ),
              )
            ],
          ),
        ),
        kdivider()
      ],
    );
  }

  Row buildUpperSession(context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUsernamAndTimeRow(context),
          ],
        ),
        w10,
        buildPopupMenu(context)
      ],
    );
  }

  Widget buildUsernamAndTimeRow(context) {
    return SizedBox(
      width:
      MediaQuery.of(context).size.width*0.64,
      // 250,
      height:MediaQuery.of(context).size.height*.057 ,
      //40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                shortenString(username, 10),
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
        ],
      ),
    );
  }

  Widget buildInteractionRow(BuildContext context) {
    return Row(
      children: [
        w10,
        LikeButton(
          bubblesSize: 106,
          size: 30,
          isLiked: likeStatus,
          onTap: (isLiked) async {
            if (isLiked) {
              context.read<LikeUnlikeBloc>().add(UnlikeEvent(postId: postId));
            } else {
              context.read<LikeUnlikeBloc>().add(LikeEvent(postId: postId));
            }
            return !isLiked;
          },
          likeCount: int.tryParse(likeCount.toString()),
        ),
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
                    return CommentBox(postId: postId);
                  },
                );
              },
            );
          },
          child: SizedBox(
            height: 25,
            width: 25,
            child: Image.asset('lib/core/icons/bubble-chat.png'),
          ),
        ),
        w10,
        commentCount == null
            ? w10
            : Text(
                commentCount.toString(),
                style: gPoppines15,
              ),
      ],
    );
  }

  Widget buildPostImage(context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.4,//170,
      width://282,
       MediaQuery.of(context).size.width*0.72,
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
            //adding loading circle
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Text('😢'),
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
    );
  }

  Widget buildPopupMenu(context) {
    return SizedBox(
      width:30,
      height: 40,
      //color: kmain200,
      child: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              enabled: isEnabledPop,
              child: Text(
                'View Profile',
                style: gPoppines15,
              ),
              onTap: () {
                knavigatorPush(context, OthersProfilePage(userId: userId));
              },
            ),
          ];
        },
      ),
    );
  }

  // Row buildUsernameAndTimeRow() {
  //   return
  // }
}
