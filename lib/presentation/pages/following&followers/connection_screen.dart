import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';

import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';


import '../../bloc/get_connections/get_connections_bloc.dart';

import 'followers_screen.dart';
import 'following_screen.dart';

class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              name,
              style: gPoppines33,
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: SizedBox(
                height: 44,
                child: TabBar(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: kwhiteColor,
                  labelColor: kwhiteColor,
                  unselectedLabelColor: kblackColor,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kblackColor),
                  tabs: [
                    BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
                      builder: (context, state) {
                        if (state is GetConnectionLoadingState) {
                          return const Tab(
                            text: 'Followers ( )',
                          );
                        } else if (state is FollowerListLoadedState) {
                          return Tab(
                            text: 'Followers (${state.followerList.length})',
                          );
                        } else if (state is FollowerListFaliureState) {
                          return const Tab(
                            text: 'Follower(0)',
                          );
                        } else {
                          return const Tab(
                            text: 'Followers',
                          );
                        }
                      },
                    ),
                    BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
                      builder: (context, state) {
                        if (state is GetConnectionLoadingState) {
                          return const Tab(
                            text: 'Following ( )',
                          );
                        } else if (state is FollowingListLoadedState) {
                          return Tab(
                            text: 'Followings (${state.followingList.length})',
                          );
                        } else if (state is FollowingListFaliureState) {
                          return const Tab(
                            text: 'Following (0)',
                          );
                        } else {
                          return const Tab(
                            text: 'Followings',
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [FollowersPage(), FollowingsPage()],
          ),
        ));
  }
}


