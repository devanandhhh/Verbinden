import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/presentation/pages/search/widget/others_post_view.dart';

import '../../../../data/models/allPost/all_post.dart';

class ExplorePostView extends StatelessWidget {
  const ExplorePostView({super.key, required this.post, required this.index});
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
            likeCount: post.likesCount,
            commentCount: post.commentsCount,
          ),
        ],
      ),
    );
  }
}