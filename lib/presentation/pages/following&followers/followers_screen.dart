import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/others_Profile/othersProfile.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../../../core/colors_constant.dart';
import '../../../core/constant.dart';
import '../../bloc/get_connections/get_connections_bloc.dart';
import '../auth/widgets/authwidgets.dart';
import '../home/widgets/shimmer.dart';
import '../profile/widgets/methods.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}


class _FollowersPageState extends State<FollowersPage> {
  @override
  void initState() {
   context.read<GetConnectionsBloc>().add(FollowersListFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    context.read<GetConnectionsBloc>().add(FollowersListFetchEvent());
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return shimmerSecOne(context);
                  },
                  separatorBuilder: (context, index) => kdivider(),
                  itemCount: 10),
            );
          } else {
            return BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
              builder: (context, state) {
                if (state is GetConnectionLoadingState) {
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return shimmerSecOne(context);
                        },
                        separatorBuilder: (context, index) => kdivider(),
                        itemCount: 10),
                  );
                } else if (state is FollowerListFaliureState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is FollowerListLoadedState) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.followerList[index];
                        final userId = data.userId;
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: kmain200,
                            backgroundImage:
                                NetworkImage(data.userProfileImgUrl ?? unKnown),
                          ),
                          title: Text(data.name),
                          subtitle: Text(data.userName),
                          trailing: GestureDetector(
                              onTap: () {
                                knavigatorPush(
                                    context, OthersProfilePage(userId: userId));
                              },
                              child: kwidth90Button('View Profile')),
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
            );
          }
        },
      ),
    );
  }
}