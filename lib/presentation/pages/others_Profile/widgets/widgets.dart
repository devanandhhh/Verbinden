import 'package:flutter/material.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../../../../core/colors_constant.dart';
import '../../../../core/constant.dart';
import '../../../bloc/others_posts/others_posts_bloc.dart';
import '../../search/widget/explore_page.dart';

GridView otherPostGridView(OthersPostLoadedState state) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
    ),
    itemBuilder: (context, index) {
      final post = state.othersPost[index];
      return GestureDetector(
        onTap: (){
          knavigatorPush(context, ExplorePostView(post: post, index: index));
        },
        child: Container(
          decoration: BoxDecoration(
            color: ksnackbarGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              post!.mediaUrl[0],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Center(child: Image.network(unKnown)
                      // Text('😢'),
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
    itemCount: state.othersPost.length, 
  );
}
