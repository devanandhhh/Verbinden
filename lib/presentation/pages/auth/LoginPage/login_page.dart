import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/widget_constant.dart';
import 'package:verbinden/presentation/bloc/user_login/user_login_bloc.dart';
import 'package:verbinden/presentation/pages/BottomNavigation/bottom_navigation.dart';
import 'package:verbinden/presentation/pages/auth/SignupPage/signup_page.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/auth/widgets/validation_service.dart';

import '../../../../core/colors_constant.dart';
import '../ForgotPassword/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool obsureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ksizedbox90,
            const SizedBox(
              height: 360,
              // color: Colors.red,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  height: 190, width: 265,
                  //color: Colors.white60,
                  child: Center(
                    child: AuthTitle(
                      titleTxt: 'Welcome back to',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Email id',
                         
                          ),
                      validator: (value) =>
                          ValidationService.validateEmail(emailController.text),
                    ),
                    ksizedbox20,
                    TextFormField(
                      controller: passwordController,
                      obscureText: obsureText,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Password',
                           suffixIcon: IconButton(
                            icon: Icon(
                              obsureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obsureText = !obsureText;
                              });
                            },
                          ),),
                          
                      validator: (value) => ValidationService.validatePassword(
                          passwordController.text),
                    ),
                    ksizedbox10,
                    BlocConsumer<UserLoginBloc, UserLoginState>(
                      listener: (context, state) {
                        if (state is UserForgotPasswordState) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ForgotPasswordScreen()
                                  // OtpValidationF()
                                  ));
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                            onTap: () {
                              context
                                  .read<UserLoginBloc>()
                                  .add(UserForgotPasswordEvent());
                            },
                            child: authButtonText('Forgot Password?'));
                      },
                    ),
                    ksizedbox10,
                    BlocConsumer<UserLoginBloc, UserLoginState>(
                      listener: (context, state) {
                        if (state is UserLoginSuccessState) {
                          //snack bar green
                          ScaffoldMessenger.of(context).showSnackBar(kSnakbar(
                              text: 'Login successfully', col: ksnackbarGreen));
                          //push into homescreen
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => BottomNavigationScreen()),
                              (route) => false);
                        } else if (state is UserLoginFalirureState) {
                          //snack bar red
                          ScaffoldMessenger.of(context).showSnackBar(
                              kSnakbar(text: state.error, col: ksnackbarRed));
                        }
                      },
                      builder: (context, state) {
                        if (state is UserLoginLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GestureDetector(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                context.read<UserLoginBloc>().add(
                                    UserLoginSubmittedEvent(
                                        email: emailController.text,
                                        password: passwordController.text));
                              }
                            },
                            child: authButton('Login'));
                      },
                    ),
                    ksizedbox10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have any account? ",
                          style: TextStyle(color: kbluegreyColor),
                        ),
                        BlocConsumer<UserLoginBloc, UserLoginState>(
                          listener: (context, state) {
                            if (state is UserSignupState) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            }
                          },
                          builder: (context, state) {
                            return GestureDetector(
                                onTap: () {
                                  context
                                      .read<UserLoginBloc>()
                                      .add(UserSignupEvent());
                                },
                                child: authButtonText("Sign Up"));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
