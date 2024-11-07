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

class FollowingsPage extends StatefulWidget {
  const FollowingsPage({super.key});

  @override
  State<FollowingsPage> createState() => _FollowingsPageState();
}

class _FollowingsPageState extends State<FollowingsPage> {
  @override
  void initState() {
    context.read<GetConnectionsBloc>().add(FollowingListFetchEvent());
    super.initState();
  }
  // void didChangeDependencies() {
  //   context.read<GetConnectionsBloc>().add(FollowingListFetchEvent());
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // context.read<GetConnectionsBloc>().add(FollowingListFetchEvent());
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return shimmerSecOne(context);
                },
                separatorBuilder: (context, index) => kdivider(),
                itemCount: 10);
          } else {
            return BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
              builder: (context, state) {
                if (state is GetConnectionLoadingState) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return shimmerSecOne(context);
                      },
                      separatorBuilder: (context, index) => kdivider(),
                      itemCount: 10);
                } else if (state is FollowingListFaliureState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is FollowingListLoadedState) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.followingList[index];
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
                      itemCount: state.followingList.length);
                } else {
                  return ksizedbox225Text(title: 'Nothing');
                }
              },
            );
          }
        },
      ),
    );
  }
}
