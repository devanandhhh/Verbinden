import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../bloc/get_connections/get_connections_bloc.dart';

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
                  tabs: const [
                    Tab(
                      text: 'Followers',
                    ),
                    Tab(
                      text: 'Followings',
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

class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetConnectionsBloc>().add(FollowersListFetchEvent());
    return Scaffold(
      body: BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
        builder: (context, state) {
          if (state is GetConnectionLoadingState) {
            return sizedboxWithCircleprogressIndicator();
          } else if (state is FollowerListLoadedState) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = state.followerList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: kmain200,
                      backgroundImage:
                          NetworkImage(data.userProfileImgUrl ?? unKnown),
                    ),
                    title: Text(data.name),
                    subtitle: Text(data.userName),
                  );
                },
                separatorBuilder: (context, index) {
                  return kdivider();
                },
                itemCount: state.followerList.length);
          } else if (state is FollowerListFaliureState) {
            return ksizedbox225Text(title: '${state.error} error');
          } else {
            return ksizedbox225Text(title: 'nothing');
          }
        },
      ),
    );
  }
}

class FollowingsPage extends StatelessWidget {
  const FollowingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
        builder: (context, state) {
          if (state is GetConnectionLoadingState) {
            return sizedboxWithCircleprogressIndicator();
          } else if (state is FollowerListLoadedState) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = state.followerList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: kmain200,
                      backgroundImage:
                          NetworkImage(data.userProfileImgUrl ?? unKnown),
                    ),
                    title: Text(data.name),
                    subtitle: Text(data.userName),
                  );
                },
                separatorBuilder: (context, index) {
                  return kdivider();
                },
                itemCount: state.followerList.length);
          } else {
            return ksizedbox225Text(title: 'Nothing');
          }
        },
      ),
    );
  }
}
