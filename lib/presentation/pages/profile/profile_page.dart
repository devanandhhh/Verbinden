import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';

import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';

import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../core/style.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/userPostFetch/user_post_fech_bloc.dart';

String nameofuser = 'username';
String imageOfUser =unknown;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileFetchDataEvent());
    context.read<UserPostFechBloc>().add(ProfileFetchPostEvent());

    return Scaffold(
      appBar: profileAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return sizedboxWithCircleprogressIndicator();
                } else if (state is ProfileLoadedState) { 
                  nameofuser = state.profileData.afterExecution.userName;
                  // imageOfUser=state.profileData.afterExecution.userProfileImageURL;
                  return ProfileSection1(model: state.profileData);
                } else {
                  return ksizedbox225Text(
                      title: 'There is some issue from serverside');
                }
              },
            ),
            h10,
            kdivider(),
            Center(
              // child: InkWell(
              //   onTap: () {
              //     knavigatorPush(context, AnimationSample());
              //   },
              child: Text(
                'My Post',
                style: gFaBeeZe(20, Colors.black),
              ),
              //),
            ),
            kdivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: BlocBuilder<UserPostFechBloc, UserPostFechState>(
                  builder: (context, state) {
                if (state is ProfilePostLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(  
                      color: kmain200,
                    ),
                  );
                } else if (state is ProfilePostsLoadedState) {
                  return userPostGridView(state);
                } else if (state is ProfilePostsFailureState) {
                  return ksizedbox225Text(title: 'No Post Available');
                }
                return const SizedBox(
                  child: Center(
                    child: Text('issue founded'),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
