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
    textStyle: TextStyle(
  fontSize: 33,
));
