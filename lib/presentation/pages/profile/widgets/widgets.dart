import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/following&followers/follow_Screen.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';

import '../../../../data/models/getPost/get_post.dart';

import '../../../../data/models/profile/edit_profile.dart';
import '../../../bloc/add_profile_picture/add_profile_picture_bloc.dart';
import '../../../bloc/edit_profile/edit_profile_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../splash/splash_screen.dart';
import '../../viewProfile/viewProfile.dart';

TextStyle gfontRalewayFont18 =
    GoogleFonts.raleway(textStyle: TextStyle(fontSize: 18, color: kgreyColor));

TextStyle gPoppines33 = GoogleFonts.poppins(
    textStyle: const TextStyle(
  fontSize: 33,
));
TextStyle gPoppines15 = GoogleFonts.poppins(
    textStyle: const TextStyle(
  fontSize: 15,
));

class ProfileSection1 extends StatelessWidget {
  const ProfileSection1({super.key, required this.model});
  final ProfileModel model;

  Future<void> pickImageFromGallery(BuildContext context) async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      print('${pickImage.path} image path');
      context
          .read<AddProfilePictureBloc>()
          .add(ImagePickEvent(image: File(pickImage.path)));
      pickImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<AddProfilePictureBloc, AddProfilePictureState>(
        listener: (context, state) {
      if (state is AddProfilePictureSuccessState) {
        // model.afterExecution.userProfileImageURL=state.
        ScaffoldMessenger.of(context).showSnackBar(
          kSnakbar(text: 'Profile Photo Added', col: ksnackbarGreen),
        );
        // Refetch profile data
        context.read<ProfileBloc>().add(ProfileFetchDataEvent());
      } else if (state is AddProfilePictureFaliureState) {
        ScaffoldMessenger.of(context).showSnackBar(
          kSnakbar(
              text: 'NetWork Issue try again please later', col: ksnackbarRed),
        );
      }
    }, builder: (context, state) {
      if (state is AddProfilePictureLoadingState) {
        return sizedboxWithCircleprogressIndicator();
      }

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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocBuilder<AddProfilePictureBloc,
                            AddProfilePictureState>(
                          builder: (context, state) {
                            File? imagePath;
                            if (state is ImagePickState) {
                              imagePath = state.image;
                            }

                            return AlertDialog(
                              scrollable: true,

                              title: Text(
                                'Edit Profile Photo',
                                style: gPoppines15,
                              ),
                              content: Column(
                                children: [
                                  h20,
                                  InkWell(
                                    onTap: () async {
                                      await pickImageFromGallery(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: kmain200,
                                      // backgroundImage: ,
                                      radius: 50,
                                      child: imagePath == null
                                          ? model.afterExecution
                                                  .userProfileImageURL.isEmpty
                                              ? const Icon(
                                                  Icons.add_photo_alternate)
                                              : ClipOval(
                                                  child: Image.network(
                                                    model.afterExecution
                                                        .userProfileImageURL,
                                                    fit: BoxFit.cover,
                                                    width: 100.0,
                                                    height: 100.0,
                                                  ),
                                                )
                                          : ClipOval(
                                              child: Image.file(
                                                imagePath,
                                                fit: BoxFit.cover,
                                                width: 100.0,
                                                height: 100.0,
                                              ),
                                            ),
                                    ),
                                  )
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: gPoppines15,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      if (imagePath != null) {
                                        context
                                            .read<AddProfilePictureBloc>()
                                            .add(AddProfilePictureClickEvent(
                                                imagePath: imagePath));

                                        // context.read<ProfileBloc>().add(ProfileFetchDataEvent());
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      'Save',
                                      style: gPoppines15,
                                    )),
                              ],
                              //   },
                              // ),
                            );
                          },
                        );
                      },
                    );
                    // pickImageFromGallery(context);
                  },
                  //child:,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: ksnackbarGreen,
                    child: model.afterExecution.userProfileImageURL == ""
                        ? ClipOval(
                            child: Image.network(unKnown),
                          )
                        : ClipOval(
                            child: Image.network(
                              model.afterExecution.userProfileImageURL,
                              fit: BoxFit.cover,
                              height: 100.0,
                              width: 100.0,
                              //adding loading here
                            ),
                          ),
                  ),
                )

                // },
              ],
            ),
            h20,
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
                                  // CircleAvatar(
                                  //   radius: 55,
                                  //   backgroundImage: model.afterExecution
                                  //               .userProfileImageURL ==
                                  //           ""
                                  //       ? null
                                  //       : NetworkImage(
                                  //           model.afterExecution
                                  //               .userProfileImageURL,
                                  //         ),
                                  // ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Name'),
                                      // ksizedbox10,
                                      TextFormField(
                                        controller: nameController,
                                      ),
                                      h10,
                                      const Text('Username'),
                                      TextFormField(
                                        controller: usernameController,
                                      ),
                                      h10,
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
                                      context
                                          .read<ProfileBloc>()
                                          .add(ProfileFetchDataEvent());
                                    },
                                    child: const Text('Save'))
                              ],
                              scrollable: true,
                            );
                          });
                    },
                    child: profileButton('Edit Profile')),
                GestureDetector(
                    onTap: () {
                      print('ontap worked');

                      knavigatorPush(
                          context,
                          ViewProfile(
                            model: model,
                          ));
                    },
                    child: profileButton('View Profile'))
              ],
            ),
          ],
        ),
      );
    });
  }
}

class KPostDialog extends StatelessWidget {
  final Post post;
  final Function onDelete;
  const KPostDialog({super.key, required this.post, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              post.mediaUrl[0],
            ),
          ),
          h10,
          Text(
            post.caption ?? '',
            style: gPoppines15,
          ),
          h10,
          MaterialButton(
              color: kmainColor,
              textColor: kwhiteColor,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        scrollable: true,
                        content: Column(
                          children: [
                            Text(
                              'Do You Want to Delete the Post?',
                              style: gPoppines15,
                            )
                          ],
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: kmainColor,
                            child: Text(
                              'Cancel',
                              style: gPoppines15,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              onDelete();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            color: kmainColor,
                            child: Text(
                              'Delete',
                              style: gPoppines15,
                            ),
                          )
                        ],
                      );
                    });
                // onDelete();
                // Navigator.pop(context);
              },
              child: const Text('Delete'))
        ],
      ),
    );
  }
}
