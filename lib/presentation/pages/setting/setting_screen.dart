import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/widget_constant.dart';
import 'package:verbinden/data/shared_preference/shared_preference.dart';
import 'package:verbinden/presentation/pages/following&followers/follow_Screen.dart';
import 'package:verbinden/presentation/pages/auth/LoginPage/login_page.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';
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
              onTap: (){
                knavigatorPush(context, ConnectionsScreen(name: nameofuser,));
              },
              child: textFontsize_20('Follower & Following')),
            ksizedbox30,
            textFontsize_20('Privacy'),
            ksizedbox30,
            textFontsize_20('Help'),
            ksizedbox30,
            textFontsize_20('About'),
            ksizedbox30,
            GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title:  Text('Do You Want to Logout',style:gFaBeeZe(22, kblackColor) ,),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'No',
                              style: googleFabz,
                            )),
                        TextButton(
                            onPressed: () async {
                              await SharedPreference.saveboolValue(false); 

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginPage()),
                                  (route) => false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  kSnakbar(
                                      text: 'LogOut succesfully',
                                      col: ksnackbarGreen));
                            },
                            child: Text(
                              'Yes',
                              style: googleFabz,
                            )),
                      ],
                    ),
                  );
                },
                child: textFontsize_20('LogOut')),
          ],
        ),
      ),
    );
  }

  Text textFontsize_20(String text,) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20,),
    );
  }
}
