import 'dart:developer';
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
import 'package:verbinden/presentation/pages/following&followers/connection_screen.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';

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
Future<void> pickImageFromGallery(BuildContext context) async {
  final pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickImage != null) {
    // ignore: use_build_context_synchronously
    context
        .read<AddProfilePictureBloc>()
        .add(ImagePickEvent(image: File(pickImage.path)));
    pickImage;
  }
}

class ProfileSection1 extends StatelessWidget {
  const ProfileSection1({super.key, required this.model});
  final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProfilePictureBloc, AddProfilePictureState>(
      listener: (context, state) {
        if (state is AddProfilePictureSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            kSnakbar(text: 'Profile Photo Added', col: ksnackbarGreen),
          );
          // Refetch profile data
          context.read<ProfileBloc>().add(ProfileFetchDataEvent());
        } else if (state is AddProfilePictureFaliureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            kSnakbar(text: 'Image Size is to high ', col: ksnackbarRed),
          );
        }
      },
      builder: (context, state) {
        if (state is AddProfilePictureLoadingState) {
          return sizedboxWithCircleprogressIndicator();
        }

        return buildProfileContent(context);
      },
    );
  }

  Widget buildProfileContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .28,
      // 225,
      width: double.infinity,
      child: Column(
        children: [
          buildProfileHeader(context),
          h20,
          buildProfileButtons(context),
        ],
      ),
    );
  }

  Widget buildProfileButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
            onTap: () {
              final nameController =
                  TextEditingController(text: model.afterExecution.name);
              final usernameController =
                  TextEditingController(text: model.afterExecution.userName);
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Name'),
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
              log('ontap worked');

              knavigatorPush(
                  context,
                  ViewProfile(
                    model: model,
                  ));
            },
            child: profileButton('View Profile'))
      ],
    );
  }

  Widget buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        buildUserInfo(context),

        buildProfilePicture(context)

        // },
      ],
    );
  }

  GestureDetector buildProfilePicture(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showEditProfilePictureDialog(context);
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
                  model.afterExecution.userProfileImageURL == ""
                      ? unKnown
                      : model.afterExecution.userProfileImageURL,
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 100.0,
                  //adding loading here
                ),
              ),
      ),
    );
  }

  Future<dynamic> showEditProfilePictureDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<AddProfilePictureBloc, AddProfilePictureState>(
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
                          ? model.afterExecution.userProfileImageURL.isEmpty
                              ? const Icon(Icons.add_photo_alternate)
                              : ClipOval(
                                  child: Image.network(
                                    model.afterExecution.userProfileImageURL,
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
                        context.read<AddProfilePictureBloc>().add(
                            AddProfilePictureClickEvent(imagePath: imagePath));

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
  }

  Column buildUserInfo(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            // 160,
            width: MediaQuery.of(context).size.width * .6,
            //240,
            // color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shortenString(model.afterExecution.name, 10),
                        style: gPoppines33),
                    Text(
                      shortenString(model.afterExecution.userName, 9),
                      style: gfontRalewayFont18,
                    )
                  ],
                ),
                Text(
                  model.afterExecution.bio == ""
                      ? '+ Add Bio'
                      : shortenString(model.afterExecution.bio, 19),
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    knavigatorPush(
                        context, ConnectionsScreen(name: nameofuser));
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
    );
  }
}
