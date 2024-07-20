import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/widget_constant.dart';
import 'package:verbinden/data/models/profile/edit_profile.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';
import 'package:verbinden/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:verbinden/presentation/pages/following&followers/follow_Screen.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';

import '../../../../data/models/getPost/get_post.dart';
import '../../../bloc/userPostFetch/user_post_fech_bloc.dart';
import '../../setting/setting_screen.dart';
import '../../splash/splash_screen.dart';
import '../../viewProfile/our_profile/viewProfile.dart';

TextStyle gfontRalewayFont18 =
    GoogleFonts.raleway(textStyle: TextStyle(fontSize: 18, color: kgreyColor));

Container profilebutton(String title) {
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

// ignore: must_be_immutable
class ProfileSection1 extends StatelessWidget {
  ProfileSection1({super.key, required this.model});
  ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 225,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                      ),
                      child: SizedBox(
                        height: 160,
                        width: 240,
                        // color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(model.afterExecution.name,
                                    style: gPoppines33),
                                Text(
                                  model.afterExecution.userName,
                                  style: gfontRalewayFont18,
                                )
                              ],
                            ),
                            Text(
                                model.afterExecution.bio == ""
                                    ? '+ Add Bio'
                                    : model.afterExecution.bio,
                                style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500))),
                            GestureDetector(
                              onTap: () {
                                knavigatorPush(context,
                                    ConnectionsScreen(name: nameofuser));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: kgreyColor,
                                  ),
                                  Text(
                                    " ${model.afterExecution.followersCount}"
                                    '  Followers',
                                    style: gfontRalewayFont18,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ksnackbarGreen,
                  backgroundImage:
                      model.afterExecution.userProfileImageURL == ""
                          ? null
                          : NetworkImage(
                              model.afterExecution.userProfileImageURL,
                            ),
                )
              ],
            ),
            ksizedbox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      final nameController = TextEditingController(
                          text: model.afterExecution.name);
                      final usernameController = TextEditingController(
                          text: model.afterExecution.userName);
                      final bioController = TextEditingController(
                          text: model.afterExecution.bio == ""
                              ? null
                              : model.afterExecution.bio);
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Edit Profile'),
                              content: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    backgroundImage: model.afterExecution
                                                .userProfileImageURL ==
                                            ""
                                        ? null
                                        : NetworkImage(
                                            model.afterExecution
                                                .userProfileImageURL,
                                          ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Name'),
                                      // ksizedbox10,
                                      TextFormField(
                                        controller: nameController,
                                      ),
                                      const Text('Username'),
                                      TextFormField(
                                        controller: usernameController,
                                      ),
                                      const Text('Bio'),
                                      TextFormField(
                                        controller: bioController,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      UserEditModel model = UserEditModel(
                                          name: nameController.text,
                                          username: usernameController.text,
                                          bio: bioController.text);
                                      context
                                          .read<EditProfileBloc>()
                                          .add(EditProfileSubmitted(model));

                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'))
                              ],
                              scrollable: true,
                            );
                          });
                    },
                    child: profilebutton('Edit Profile')),
                GestureDetector(
                    onTap: () {
                      print('ontap worked');

                      knavigatorPush(
                          context,
                          ViewProfile(
                            model: model,
                          ));
                    },
                    child: profilebutton('View Profile'))
              ],
            ),
          ],
        ));
  }
}

underlineDecoration() {
  return UnderlineTabIndicator(
      borderSide: BorderSide(width: 3.0, color: kbluegreyColor),
      borderRadius: BorderRadius.circular(6),
      insets: const EdgeInsets.symmetric(horizontal: 66.0));
}

TextStyle gPoppines33 = GoogleFonts.poppins(
    textStyle: const TextStyle(
  fontSize: 33,
));

class PostDialog extends StatelessWidget {
  final Post post;
  final Function onDelete;
  const PostDialog({super.key, required this.post, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(post.mediaUrl[0]),
          ksizedbox10,
          Text(post.caption ?? ''),
          ksizedbox10,
          ElevatedButton(
              onPressed: () {
                onDelete();
                Navigator.pop(context);
              },
              child: const Text('Delete'))
        ],
      ),
    );
  }
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
            showDialog(
                context: context,
                builder: (context) {
                  return PostDialog(
                      post: post,
                      onDelete: () {
                        context
                            .read<UserPostFechBloc>()
                            .add(DeletePostEvent(postId: post.postId));
                      });
                });
          },
          child: Container(
              decoration: BoxDecoration(
                color: ksnackbarGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                  child: Image.network(
                post.mediaUrl[0],
                fit: BoxFit.cover,
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
              ))));
      //  Container(
      //   decoration: BoxDecoration(
      //     color: ksnackbarGreen,
      //     borderRadius: BorderRadius.circular(4),
      //     image: DecorationImage(
      //       image: NetworkImage(post.mediaUrl[0]),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   height: 50,
      //   width: 50,
      // ),
      // );
    },
    itemCount: state.posts.length,
  );
}
