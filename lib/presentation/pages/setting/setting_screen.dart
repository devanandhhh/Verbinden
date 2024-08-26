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

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  knavigatorPush(
                      context,
                      ConnectionsScreen(
                        name: nameofuser,
                      ));
                },
                child: textFontsize_20('Follower & Following')),
            h30,
            GestureDetector(
                onTap: () {
                  knavigatorPush(context, const PrivacyScreen());
                },
                child: textFontsize_20('Privacy')),
            h30,
            GestureDetector(
                onTap: () {
                  knavigatorPush(context, const HelpScreen());
                },
                child: textFontsize_20('Help')),
            h30,
            GestureDetector(
                onTap: () {
                  knavigatorPush(context, const AboutScreen());
                },
                child: textFontsize_20('About')),
            h30,
            GestureDetector(
                onTap: () {
                  dialogForDelete(context);
                },
                child: textFontsize_20('LogOut')),
            SizedBox(
              height: 450,
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version 1.0',
                  style: googleFabz18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
