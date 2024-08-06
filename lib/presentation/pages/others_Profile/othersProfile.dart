import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verbinden/presentation/bloc/others_profile/others_profile_bloc.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/others_Profile/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../core/colors_constant.dart';
import '../../../core/constant.dart';
import '../../../core/style.dart';
import '../../bloc/others_posts/others_posts_bloc.dart';
import '../profile/widgets/methods.dart';

class OthersProfilePage extends StatelessWidget {
  const OthersProfilePage({super.key, required this.userId});
  final int userId;
  @override
  Widget build(BuildContext context) {
    context
        .read<OthersProfileBloc>()
        .add(OthersProfileDataFetchEvent(userId: userId));

    context.read<OthersPostsBloc>().add(OthersPostsFetchEvent(userId: userId));
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 30,
            )),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<OthersProfileBloc, OthersProfileState>(
              builder: (context, state) {
                if (state is OthersProfileLoadingState) {
                  return sizedboxWithCircleprogressIndicator();
                } else if (state is OthersProfileLoadedState) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                state
                                                    .model!.afterExecution.name,
                                                style: gPoppines33),
                                            Text(
                                              state.model!.afterExecution
                                                  .userName,
                                              style: gfontRalewayFont18,
                                            )
                                          ],
                                        ),
                                        Text(
                                            state.model!.afterExecution.bio ==
                                                    ""
                                                ? ' Bio here'
                                                : state
                                                    .model!.afterExecution.bio,
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundColor: kgreyColor,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //knavigatorPush(context, ConnectionsScreen(name: state.model!.afterExecution.name,));
                                              },
                                              child: Text(
                                                "${state.model!.afterExecution.followersCount}"
                                                '  Followers',
                                                style: gfontRalewayFont18,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(state.model!
                                          .afterExecution.userProfileImageURL ==
                                      ""
                                  ? unKnown
                                  : state.model!.afterExecution
                                      .userProfileImageURL),
                            ),
                          ],
                        ),
                        h20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            state.model!.afterExecution.followingStatus ?? false
                                ? GestureDetector(
                                    onTap: () async {
                                      print('following button clicked');
                                      context.read<OthersProfileBloc>().add(
                                          UnfollowButtonClicked(
                                              userId: state.model!
                                                  .afterExecution.userId));

                                      // context.read<OthersProfileBloc>().add(
                                      //     OthersProfileDataFetchEvent(
                                      //         userId: userId));

                                      // await RelationService().unfollowRequest(
                                      //     userId: state
                                      //         .model!.afterExecution.userId
                                      //         .toString());
                                      // context.read<OthersProfileBloc>().add(
                                      //     OthersProfileDataFetchEvent(
                                      //         userId: userId));
                                    },
                                    child: profileButton('Following'))
                                : GestureDetector(
                                    onTap: () async {
                                      print('follow button clicked');
                                      context.read<OthersProfileBloc>().add(
                                          FollowButtonClicked(
                                              userId: state.model!
                                                  .afterExecution.userId));
                                      // context.read<OthersProfileBloc>().add(
                                      //     OthersProfileDataFetchEvent(
                                      //         userId: userId));
                                    },
                                    child: profileButton('Follow')),
                            profileButton('Message')
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text('network issue'),
                );
              },
            ),
            h10,
            kdivider(),
            Center(
              child: Text(
                'Post',
                style: gFaBeeZe(20, Colors.black),
              ),
            ),
            kdivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: BlocBuilder<OthersPostsBloc, OthersPostsState>(
                builder: (context, state) {
                  if (state is OthersPostsLoadingState) {
                    return sizedboxWithCircleprogressIndicator();
                  } else if (state is OthersPostLoadedState) {
                    return otherPostGridView(state);
                  } else if (state is OthersPostsFaliureState) {
                    return ksizedbox225Text(title: 'BAck End issue');
                  }
                  return const SizedBox(
                    child: Center(
                      child: Text('issue Error'),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
