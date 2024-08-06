import 'package:flutter/material.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/data/shared_preference/shared_preference.dart';
import 'package:verbinden/presentation/pages/auth/LoginPage/login_page.dart';

import '../BottomNavigation/bottom_navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      final sharedPrefz = await SharedPreference.getboolValue();
      if (sharedPrefz != true) {
        // ignore: use_build_context_synchronously
        //knavigatorPush(context, LoginPage());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginPage()));
      } else {
        // ignore: use_build_context_synchronously
        //knavigatorPush(context,const  BottomNavigationScreen());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>const BottomNavigationScreen()));

      }
    });
    return Scaffold(
      body: Center(
          child: Container(
        height: 150,
        width: 140,
        decoration: BoxDecoration(
            color: ksnackbarGreen, borderRadius: BorderRadius.circular(19)),
        child: const Icon(
          Icons.connect_without_contact,
          size: 70, 
        ),
      )),
    );
  }
}

Future<void> knavigatorPush(BuildContext context, Widget screen) {
  return 
  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>screen));  
   Navigator.push(context, MaterialPageRoute(builder: (ctx) => screen));
}
 