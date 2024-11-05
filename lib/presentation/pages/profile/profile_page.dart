import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';

import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/home/widgets/shimmer.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';

import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../core/style.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/userPostFetch/user_post_fech_bloc.dart';

String nameofuser = 'username';
String imageOfUser = unknown;

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
            FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildShimmerProfile(context,);
                  }
                  return BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoadingState) {
                        return buildShimmerProfile(context,);
                      } else if (state is ProfileLoadedState) {
                        nameofuser = state.profileData.afterExecution.userName;
                        // imageOfUser=state.profileData.afterExecution.userProfileImageURL;
                        return ProfileSection1(model: state.profileData);
                      } else {
                        return ksizedbox225Text(
                            title: "Your session has expired. Please log in again to continue.");
                      }
                    },
                  );
                }),
            h10,
            kdivider(),
            Center(
              child: Text(
                'My Post',
                style: gFaBeeZe(20, Colors.black),
              ),
              //),
            ),
            kdivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child:
               BlocBuilder<UserPostFechBloc, UserPostFechState>(
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
                    })
                 
            )
          ],
        ),
      ),
    );
  }

 
}
 Widget buildShimmerProfile(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .28,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skelton(
                        height: MediaQuery.of(context).size.height * .04,
                        width: MediaQuery.of(context).size.width * .5),
                    h10,
                    Skelton(
                        height: MediaQuery.of(context).size.height * .03,
                        width: MediaQuery.of(context).size.width * .3),
                    h30,
                    Skelton(
                        height: MediaQuery.of(context).size.height * .062,
                        width: MediaQuery.of(context).size.width * .4),
                  ],
                ),
              ),
              Column(
                children: [
                  Skelton(
                    height: MediaQuery.of(context).size.height * .15,
                    width: MediaQuery.of(context).size.width * .3,
                  ),
                ],
              )
            ],
          ),
          h30,
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Skelton(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .42),
                Skelton(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .42)
              ],
            ),
          )
        ],
      ),
    );
  }