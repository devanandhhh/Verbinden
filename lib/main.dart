import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:verbinden/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:verbinden/presentation/bloc/profile/profile_bloc.dart';
import 'package:verbinden/presentation/bloc/user_login/user_login_bloc.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import 'presentation/bloc/bottomNav/bottom_nav_cubit.dart';
import 'presentation/bloc/otp_validation/otp_validation_bloc.dart';
import 'presentation/bloc/user_signup/signup_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
        BlocProvider<OtpValidationBloc>(create: (context) => OtpValidationBloc()),
        BlocProvider<UserLoginBloc>(create: (context) => UserLoginBloc(),),
        BlocProvider<ForgotPasswordBloc>(create: (context) => ForgotPasswordBloc(),),
        BlocProvider<BottomNavCubit>(create: (context) => BottomNavCubit(),),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
        BlocProvider(create: (context)=>EditProfileBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
          cursorColor: kmainColor,
        )),
        home: const SplashScreen(),
      ),
    );
  }
}
