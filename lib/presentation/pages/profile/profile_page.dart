import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';

import 'package:verbinden/core/widget_constant.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

import 'package:verbinden/presentation/pages/profile/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/setting/setting_screen.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../../bloc/profile/profile_bloc.dart';

String nameofuser = 'username';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(ProfileFetchDataEvent());

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        IconButton(
            onPressed: () {
              knavigatorPush(context, const SettingScreen());
            },
            icon: const Icon(
              Icons.menu,
              size: 30,
            )),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return SizedBox(
                    height: 225,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kmain200,
                      ),
                    ),
                  );
                } else if (state is ProfileLoadedState) {
                  nameofuser = state.profileData.afterExecution.userName;
                  return ProfileSection1(model: state.profileData);   
                } else {
                  return const Center(
                    child: SizedBox(
                      height: 225,
                      child: Center(
                        child: Text('Error '),
                      ),
                    ),
                  );
                }
              },
            ),
            ksizedbox10,
            kdivider(),
            Center(
              child: Text(
                'My Post',
                style: gFaBeeZe(20, Colors.black),
              ),
            ),
            kdivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: 
              GridView.builder(
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: ksnackbarGreen,
                  height: 50,
                  width: 50,
                );
              },
              itemCount: 14, 
            ),
           
            )
          ],
        ),
      ),
    );
  }
}
