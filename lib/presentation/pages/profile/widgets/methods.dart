import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/data/models/getPost/get_post.dart';
import 'package:verbinden/presentation/pages/profile/widgets/post_viewer.dart';

import '../../../../core/colors_constant.dart';
import '../../../bloc/userPostFetch/user_post_fech_bloc.dart';
import '../../setting/setting_screen.dart';
import '../../splash/splash_screen.dart';

Container profileButton(String title) {
  return Container(
    height: 32,
    width: 160,
    decoration: BoxDecoration(
        color: kblackColor, borderRadius: BorderRadius.circular(8)),
    child: Center(
        child: Text(
      title,
      style: TextStyle(color: kwhiteColor, fontWeight: FontWeight.bold),
    )),
  );
}

underlineDecoration() {
  return UnderlineTabIndicator(
      borderSide: BorderSide(width: 3.0, color: kbluegreyColor),
      borderRadius: BorderRadius.circular(6),
      insets: const EdgeInsets.symmetric(horizontal: 66.0));
}

AppBar profileAppbar(BuildContext context) {
  return AppBar(automaticallyImplyLeading: false, actions: [
    IconButton(
        onPressed: () {
          knavigatorPush(context, const SettingScreen());     
        },
        icon: const Icon(
          Icons.menu,
          size: 30,
        )),
  ]);    
}

SizedBox sizedboxWithCircleprogressIndicator() {
  return SizedBox(
    height: 225,
    child: Center(
      child: CircularProgressIndicator(
        color: kmain200,
      ),
    ),
  );
}

Center ksizedbox225Text({required String title}) {
  return Center(
    child: SizedBox(
      height: 225,
      child: Center(
        child: Text(title),
      ),
    ),
  );
}

GridView userPostGridView(ProfilePostsLoadedState state) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
    ),
    itemBuilder: (context, index) {
      final post = state.posts[index];
      return GestureDetector(
        onTap: () {
          knavigatorPush(
              context,
              ProfilePostView(
                post: post,
                index: index,
              ));
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return KPostDialog(
          //           post: post,
          //           onDelete: () {
          //             context
          //                 .read<UserPostFechBloc>()
          //                 .add(DeletePostEvent(postId: post.postId));
          //           });
          //     });
        },
        child: Container(
          decoration: BoxDecoration(
            color: ksnackbarGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              post.mediaUrl[0],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>  Center(
                child:Image.network(unKnown)
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
      );
    },
    itemCount: state.posts.length,
  );
}

class ProfilePostView extends StatelessWidget {
  const ProfilePostView({super.key, required this.post, required this.index});
  final int index;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Posts',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(fontSize: 24, color: kblackColor),
          ),
        ),
      ),
      body: Column(
        children: [
          MyPostViewer(
            post: post,
            username: post.userName,
            time: post.postAge,
            description: post.caption ?? 'nothing',
            postImage: post.mediaUrl[0],
            profileImage: post.userProfileImgURL,
            likeCount: post.likesCount.toString(),
            commentCount: post.commentsCount.toString(),
          ),
        ],
      ),
    );
  }
}
