import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

import '../../../../../core/style.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({
    super.key,
    required this.model,
  });
  final ProfileModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kAppbarDecorate('Profile View'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileHeader(),
            h20,
            buildTextSection(
              label: 'Bio',
              value: model.afterExecution.bio == ""
                  ? 'Bio not added'
                  : model.afterExecution.bio,
            ),
            h20,
            buildTextSection(
              label: 'Followers Count',
              value: model.afterExecution.followersCount == 0
                  ? 'No Followers'
                  : model.afterExecution.followersCount.toString(),
            ),
            h20,
            buildTextSection(
              label: 'Following Count',
              value: model.afterExecution.followingCount == 0
                  ? 'No Followings'
                  : model.afterExecution.followingCount.toString(),
            ),
            h20,
            buildTextSection(
              label: 'Post Count',
              value: model.afterExecution.postsCount == 0
                  ? 'No Post'
                  : model.afterExecution.postsCount.toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileHeader() {
    return Row(
      children: [
        buildProfileImage(),
        w10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextSection(label: 'Name', value: model.afterExecution.name),
            h20,
            buildTextSection(
                label: 'Username', value: model.afterExecution.userName)
          ],
        )
      ],
    );
  }

  Column buildTextSection({required label, required value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: gFaBeeZe(15, kgreyColor),
        ),
        Text(
          value,
          style: gfontsize20,
        ),
      ],
    );
  }

  Widget buildProfileImage() {
    return Container(
      height: 180,
      width: 150,
      decoration: BoxDecoration(
          color: kgrey200, borderRadius: BorderRadius.circular(9)),
      child: model.afterExecution.userProfileImageURL == ""
          ? const Icon(
              Icons.person,
              size: 39,
            )
          : InstaImageViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  model.afterExecution.userProfileImageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
