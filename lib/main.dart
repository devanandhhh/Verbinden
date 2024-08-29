import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/presentation/bloc/chat_history/chat_history_bloc.dart';
import 'package:verbinden/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:verbinden/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:verbinden/presentation/bloc/others_posts/others_posts_bloc.dart';
import 'package:verbinden/presentation/bloc/profile/profile_bloc.dart';
import 'package:verbinden/presentation/bloc/user_login/user_login_bloc.dart';
import 'package:verbinden/presentation/cubit/passwordValidation/password_visibility_cubit.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import 'data/api/websocket_repo/websocket_repo.dart';
import 'presentation/bloc/add_profile_picture/add_profile_picture_bloc.dart';
import 'presentation/bloc/chat_summary/chat_summary_bloc.dart';
import 'presentation/bloc/like_unlike/like_unlike_bloc.dart';
import 'presentation/bloc/bottomNav/bottom_nav_cubit.dart';
import 'presentation/bloc/explore/explore_bloc.dart';
import 'presentation/bloc/get_connections/get_connections_bloc.dart';
import 'presentation/bloc/home_bloc/home_bloc.dart';
import 'presentation/bloc/others_profile/others_profile_bloc.dart';
import 'presentation/bloc/otp_validation/otp_validation_bloc.dart';
import 'presentation/bloc/post_comment/post_comment_bloc.dart';
import 'presentation/bloc/search/search_bloc.dart';
import 'presentation/bloc/upload_post/upload_post_bloc.dart';
import 'presentation/bloc/userPostFetch/user_post_fech_bloc.dart';
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
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => OtpValidationBloc()),
        BlocProvider(create: (context) => UserLoginBloc()),
        BlocProvider(create: (context) => ForgotPasswordBloc()),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => EditProfileBloc()),
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(create: (context) => UploadPostBloc()),
        BlocProvider(create: (context) => UserPostFechBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => AddProfilePictureBloc()),
        BlocProvider(create: (context) => ExploreBloc()),
        BlocProvider(create: (context) => OthersProfileBloc()),
        BlocProvider(create: (context) => OthersPostsBloc()),
        BlocProvider(create: (context) => GetConnectionsBloc()),
        BlocProvider(create: (context) => PostCommentBloc()),
        BlocProvider(create: (context) => LikeUnlikeBloc()),
        BlocProvider(create: (context) => ChatSummaryBloc()),
        BlocProvider(create: (context) => ChatHistoryBloc()),
        RepositoryProvider<WebsocketService>(
          create: (context) => WebsocketService(),
        ),
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
