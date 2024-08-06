import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/bloc/otp_validation/otp_validation_bloc.dart';
import 'package:verbinden/presentation/pages/auth/LoginPage/login_page.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';

import '../../../../core/colors_constant.dart';
import '../widgets/validation_service.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key, required this.otp, required this.token});
  final String token;
  final String otp;
  final formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Password'),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'New Password'),
                validator: (value) => ValidationService.validatePassword(value!),
              ),
              h10,
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Confirm Password'),
                validator: (value) => ValidationService.validateConfirmPassword(
                    value!, passwordController.text),
              ),
              h30,
              BlocConsumer<OtpValidationBloc, OtpValidationState>(
                listener: (context, state) {
                  if (state is OtpResetSuccesstate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        kSnakbar(text: 'Verified', col: ksnackbarGreen));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => LoginPage()),
                        (route) => false);
                  } else if (state is OtpResetFaliurestate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        kSnakbar(text: 'Wrong ,try again', col: ksnackbarRed));
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          context.read<OtpValidationBloc>().add(
                              OtpResetSuccessEvent(
                                  otp: otp,
                                  password: passwordController.text,
                                  confirmpassword: confirmPasswordController.text,
                                  token: token));
                        }
                      },
                      child: kwidth90Button('Create'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
