import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';

import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../data/api/websocket_repo/websocket_repo.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../profile/widgets/methods.dart';
import 'widgets/section_one.dart';
import 'widgets/others_post_container.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    context.read<HomeBloc>().add(HomeFetchPostEvent());
    context.read<ProfileBloc>().add(ProfileFetchDataEvent());
    // WebsocketService websocketService =WebsocketService();
    //  websocketService.toConnectChannel(context);
    return Scaffold(
      appBar: kAppbarDecorate('Verbinden', true),
      body: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
              return sizedboxWithCircleprogressIndicator();
              } else if (state is ProfileLoadedState) {
                nameofuser = state.profileData.afterExecution.userName;
                imageOfUser =
                    state.profileData.afterExecution.userProfileImageURL;
                 WebsocketService().toConnectChannel(context);
              }
              return SectionOne(
                userName: nameofuser,
                userImage: imageOfUser,
              );
            },
          ),
          kdivider(),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return sizedboxWithCircleprogressIndicator();
              } else if (state is HomeLoadedState) {
                WebsocketService().toConnectChannel(context);
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.othersPost.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = state.othersPost[index];

                      return OthersPostContainer(
                        username: post.userName,
                        time: post.postAge,
                        description: post.caption ?? 'No caption',
                        postImage: post.mediaUrl[0],
                        profileImage: post.userProfileImgUrl,
                        postId: post.postId,
                        likeCount: post.likesCount,
                        commentCount: post.commentsCount,
                        userId: post.userId,
                        likeStatus: post.likeStatus,
                        isEnabledPop: true,
                      );
                    },
                  ),
                );
              } else if (state is HomeFaliureState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const OthersPostContainer(
                      username: 'Unknown User',
                      time: '2 days ago',
                      description: 'description here ',
                      postImage: unKnown,
                      profileImage: unKnown,
                      postId: 1,
                      userId: 1,
                      likeStatus: true,
                      isEnabledPop: false,
                    ),
                    Center(
                      child: Text(
                        'No Post availabe ,Do Follow Your friends',
                        style: gPoppines15,
                      ),
                    ),
                  ],
                );
                // return ksizedbox225Text(title: state.error);
              } else {
                return OthersPostContainer(
                  likeStatus: true,
                  isEnabledPop: false,
                  userId: 1,
                  username: 'kevin_babu',
                  time: '2 days ago',
                  description: 'description here ',
                  postImage: imageDemo,
                  profileImage: imageDemo,
                  postId: 1,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
