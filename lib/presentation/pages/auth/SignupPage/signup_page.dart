

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:verbinden/presentation/bloc/user_signup/signup_bloc.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/auth/OtpVarificationS/otp_services.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/auth/widgets/validation_service.dart';

import '../../../../core/colors_constant.dart';
import '../../../../data/models/auth/user_model.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final cPasswordController = TextEditingController();  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            h30,
            h30,
            const SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: AuthTitle(
                  titleTxt: 'Welcome to',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            hintText: 'Full Name'),
                        validator: (value) =>
                            ValidationService.validateName(value!)),
                    h20,
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Username'),
                      validator: (value) =>
                          ValidationService.validateUsername(value!),
                    ),
                    h20,
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Email id'),
                      validator: (value) =>
                          ValidationService.validateEmail(value!),
                    ),
                    h20,
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Password'),
                      validator: (value) =>
                          ValidationService.validatePassword(value!),
                    ),
                    h20,
                    TextFormField(
                      controller: cPasswordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Confirm Password'),
                      validator: (value) =>
                          ValidationService.validateConfirmPassword(
                              passwordController.text, value!),
                    ),
                    h30,
                    BlocConsumer<SignupBloc, SignupState>(
                      listener: (context, state) {
                        if (state is SignupSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              kSnakbar(text:'OTP Sended', col: ksnackbarGreen));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => OtpValidationPage(trueorflase: false,
                                        token: state.token!,
                                      )));

                         
                        } else if (state is SignupFailureState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              kSnakbar(text: state.error, col: ksnackbarRed));
                        }
                      },
                      builder: (context, state) {
                        if (state is SignupLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GestureDetector(
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                UserModel model = UserModel(
                                    name: nameController.text,
                                    username: userNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword: cPasswordController.text);
                                context
                                    .read<SignupBloc>()
                                    .add(SignupSubmittedEvent(user: model));
                              }
                            },
                            child: authButton('Sign Up'));
                      },
                    ),
                    h20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: kbluegreyColor),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: authButtonText('Login'))
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
