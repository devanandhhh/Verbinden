import 'package:flutter/material.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/core/style.dart';

import 'package:verbinden/presentation/pages/following&followers/follow_Screen.dart';

import 'package:verbinden/presentation/pages/profile/profile_page.dart';
import 'package:verbinden/presentation/pages/setting/screens/about_screen.dart';
import 'package:verbinden/presentation/pages/setting/screens/help_screen.dart';
import 'package:verbinden/presentation/pages/setting/screens/privacy_screen.dart';
import 'package:verbinden/presentation/pages/setting/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../message/widgets/widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbarDecorate('Settings', false, true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSettingButton(
              context: context,
              title: 'Follower & Following',
              ontap: () {
                knavigatorPush(
                    context,
                    ConnectionsScreen(
                      name: nameofuser,
                    ));
              },
            ),
            h30,
            buildSettingButton(
              context: context,
              title: 'Privacy',
              ontap: () {
                knavigatorPush(
                  context,
                  const PrivacyScreen(),
                );
              },
            ),
            h30,
            buildSettingButton(
              context: context,
              title: 'Help',
              ontap: () {
                knavigatorPush(
                  context,
                  const HelpScreen(),
                );
              },
            ),
            h30,
            buildSettingButton(
              context: context,
              title: 'About',
              ontap: () {
                knavigatorPush(
                  context,
                  const AboutScreen(),
                );
              },
            ),
            h30,
            buildSettingButton(
              context: context,
              title: 'Logout',
              ontap: () {
                dialogForDelete(context);
              },
            ),
            buildVersionBox()
          ],
        ),
      ),
    );
  }

  GestureDetector buildSettingButton(
      {required context, required ontap, required title}) {
    return GestureDetector(
      onTap: ontap,
      child: textFontsize_20(title),
    );
  }

  SizedBox buildVersionBox() {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Version 1.0',
          style: googleFabz18,
        ),
      ),
    );
  }
}
