import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/core/style.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';
import 'package:verbinden/presentation/pages/others_Profile/othersProfile.dart';

import '../../../bloc/search/search_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
        appBar: kAppbarDecorate('Search', false, true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  CupertinoSearchTextField(
                    controller: searchController,
                    onChanged: (value) {
                      context
                          .read<SearchBloc>()
                          .add(SearchTextChangeEvent(searchText: value));
                    },
                  ),
                  h20,
                  if (state is SearchLoadingState)
                    sizedboxWithCircleprogressIndicator()
                  else if (state is SearchListViewState)
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final getResult = state.getResult[index];
                          final userId = state.getResult[index].userId;

                          return GestureDetector(
                            onTap: () {
                              knavigatorPush(
                                  context,
                                  OthersProfilePage(
                                    userId: userId,
                                  ));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: kgreen400,
                                backgroundImage: NetworkImage(
                                    getResult.profileImageURL ?? unKnown),
                              ),
                              title: Text(
                                getResult.name,
                                style: gPoppines15,
                              ),
                            ),
                          );
                        },
                        itemCount: state.getResult.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    )
                  else if (state is SearchFaliureState)
                    ksizedbox225Text(title: 'no user available')
                  else
                    Center(
                      child: SizedBox(
                        height: 225,
                        child: Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search),
                              Text(
                                'Search Username ',
                                style: googleFabz20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        ));
  }
}
