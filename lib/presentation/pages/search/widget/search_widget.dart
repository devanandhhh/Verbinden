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
import '../../home/widgets/shimmer.dart';

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
                  buildSearchField(searchController, context),
                  h20,
                  buildSearchResult(state, context),
                ],
              );
            },
          ),
        ));
  }

  Widget buildSearchField(
      TextEditingController searchController, BuildContext context) {
    return CupertinoSearchTextField(
      controller: searchController,
      onChanged: (value) {
        context
            .read<SearchBloc>()
            .add(SearchTextChangeEvent(searchText: value));
      },
    );
  }
}

Widget buildSearchResult(SearchState state, BuildContext context) {
  if (state is SearchLoadingState) {
    return shimmerSearch();
  } else if (state is SearchListViewState) {
    return buildSearchListView(state);
  } else if (state is SearchFaliureState) {
    return ksizedbox225Text(title: 'no user available');
  } else {
    return buildSearchPlaceholder();
  }
}

Widget shimmerSearch() {
  return Expanded(
    child: ListView.separated(
        itemBuilder: (context, index) {
          return shimmerSecOne(context);
        },
        separatorBuilder: (context, index) => kdivider(),
        itemCount: 10),
  );
}

Widget buildSearchPlaceholder() {
  return Center(
    child: SizedBox(
      height: 225,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
  );
}

Widget buildSearchListView(SearchListViewState state) {
  return Expanded(
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
              backgroundImage:
                  NetworkImage(getResult.profileImageURL ?? unKnown),
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
  );
}
