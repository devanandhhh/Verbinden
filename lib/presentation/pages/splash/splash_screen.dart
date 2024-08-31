import 'package:flutter/material.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/data/shared_preference/shared_preference.dart';
import 'package:verbinden/presentation/pages/auth/LoginPage/login_page.dart';
// import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';

import '../../../core/constant.dart';
import '../../../core/style.dart';
import '../BottomNavigation/bottom_navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds:3), () async {
      final sharedPrefz = await SharedPreference.getboolValue();
      if (sharedPrefz != true) {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (ctx) => LoginPage()));
      } else {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
                builder: (ctx) => const BottomNavigationScreen()));
      }
    });
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: Image.asset(
                'assets/icons/newIconVerbinden.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          h30,
          Text('Verbinden',style:gFaBeeZe(26, kblackColor),)
        ],
      )),
    );
  }
}

Future<void> knavigatorPush(BuildContext context, Widget screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (ctx) => screen));
}
