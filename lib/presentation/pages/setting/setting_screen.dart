import 'package:flutter/material.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/data/shared_preference/shared_preference.dart';
import 'package:verbinden/presentation/pages/BottomNavigation/widgets/bottom_nav_widget.dart';
import 'package:verbinden/presentation/pages/following&followers/follow_Screen.dart';
import 'package:verbinden/presentation/pages/auth/LoginPage/login_page.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';
import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/setting/screens/about_screen.dart';
import 'package:verbinden/presentation/pages/setting/screens/help_screen.dart';
import 'package:verbinden/presentation/pages/setting/screens/privacy_screen.dart';
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
            h30,
            GestureDetector(
              onTap: (){
                knavigatorPush(context,const PrivacyScreen() );
              },
               child: textFontsize_20('Privacy')),  
            h30,
            GestureDetector( onTap: (){
              knavigatorPush(context, const HelpScreen());
            }, child: textFontsize_20('Help')),
            h30,  
            GestureDetector (
              onTap: (){
                knavigatorPush(context, const AboutScreen());
              }, 
              child: textFontsize_20('About')),
            h30,
            GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,   
                    builder: (BuildContext context) => AlertDialog(
                      title:  Text('Do You Want to Logout',style:gPoppines15  ,),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'No',
                              style: gPoppines15,
                            )),
                        TextButton(
                            onPressed: () async {
                              await SharedPreference.saveboolValue(false); 

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginPage()),
                                  (route) => false);
                                  selectedIndex=ValueNotifier<int> (0);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  kSnakbar(
                                      text: 'LogOut succesfully',
                                      col: ksnackbarGreen));
                            },
                            child: Text(
                              'Yes',
                              style: gPoppines15,
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
