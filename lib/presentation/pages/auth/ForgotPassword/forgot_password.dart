import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/auth/widgets/validation_service.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../OtpVarificationS/otp_services.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email id'),
                validator: (value) =>
                    ValidationService.validateEmail(emailcontroller.text),
              ),
              h30,
              BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        kSnakbar(text: 'OTP Send', col: ksnackbarGreen));
                    knavigatorPush(
                        context, OtpValidationPage(token: state.tempToken,trueorflase: true,));
                  } else if (state is ForgotPasswordFaliurState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        kSnakbar(text: 'OTP Error', col: ksnackbarRed));
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmittedEvent(email: emailcontroller.text)); 
                        }
                      },
                      child: kwidth90Button('Send OTP'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

 
}
