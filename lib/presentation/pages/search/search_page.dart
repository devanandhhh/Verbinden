import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/widgets/methods.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/search/widget/explore_page.dart';
import 'package:verbinden/presentation/pages/search/widget/search_widget.dart';
import 'package:verbinden/presentation/pages/search/widget/shimmer.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../../../core/colors_constant.dart';
import '../../../core/constant.dart';
import '../../bloc/explore/explore_bloc.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ExploreBloc>().add(ExploreFetchEvent());
    return Scaffold(
      appBar: kAppbarDecorate('Explore'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSearchField(context),
              h10,
              buildExploreContent(),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<ExploreBloc, ExploreState> buildExploreContent() {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state is ExploreLoadingState) {
          log('loading');
          return const ShimmerLoadingGridView();
        } else if (state is ExploreLoadedState) {
          return buildGridViewPost(state);
        } else if (state is ExploreFaliureState) {
          log('faliure');
          return sizedboxWithCircleprogressIndicator();
        }

        log('nothing');
        return Center(child: Text('NetWork Issue', style: gPoppines15));
      },
    );
  }

  Widget buildGridViewPost(ExploreLoadedState state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index) {
        final post = state.exploreData[index];
        return GestureDetector(
          onTap: () {
            knavigatorPush(context, ExplorePostView(post: post, index: index));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                post.mediaUrl[0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text('😢'),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  final totalBytes = loadingProgress?.expectedTotalBytes;
                  final bytesLoaded = loadingProgress?.cumulativeBytesLoaded;
                  if (totalBytes != null && bytesLoaded != null) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white70,
                        value: bytesLoaded / totalBytes,
                        color: kmain200,
                        strokeWidth: 5.0,
                      ),
                    );
                  } else {
                    return child;
                  }
                },
              ),
            ),
          ),
        );
      },
      itemCount: state.exploreData.length,
    );
  }

  Widget buildSearchField(BuildContext context) {
    return CupertinoTextField(
      prefix: const Icon(Icons.search_sharp),
      placeholder: 'Click here to Search',
      readOnly: true,
      onTap: () {
        knavigatorPush(context, const SearchWidget());
      },
    );
  }
}
