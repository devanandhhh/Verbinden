import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/bloc/otp_validation/otp_validation_bloc.dart';
import 'package:verbinden/presentation/pages/auth/NewPassword/create_newPassword.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

import '../../../../core/style.dart';

class OtpValidationPage extends StatelessWidget {
  OtpValidationPage(
      {super.key, required this.token, required this.trueorflase});

  //1
  final otpController = TextEditingController();
  final String token;
  final bool trueorflase;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OTP Verification',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We have sent a verification code to your email address',
              style: googleFabz,
            ),
            h30,

            //2
            SizedBox(
                child: Pinput(
              length: 4,
              controller: otpController,
            )),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocConsumer<OtpValidationBloc, OtpValidationState>(
                  listener: (context, state) {
                    if (state is OtpResendState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          kSnakbar(text: 'wait a moment ', col: kgreyColor));
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        //3
                        otpController.clear();

                        context.read<OtpValidationBloc>().add(OtpResentEvent());
                      },
                      child: authButtonS('Resend OTP'),
                    );
                  },
                ),
                BlocConsumer<OtpValidationBloc, OtpValidationState>(
                  listener: (context, state) async {
                    if (state is OtpSuccessState) {
                      if (trueorflase == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            kSnakbar(text: 'Verified', col: ksnackbarGreen));
                        knavigatorPush(
                            context,
                            CreateNewPasswordScreen(
                              otp: state.otp,
                              token: token,
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            kSnakbar(text: 'Verified', col: ksnackbarGreen));
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    } else if (state is OtpFaliureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          kSnakbar(text: 'Invalid OTP....', col: ksnackbarRed));
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                        onTap: () async {
                          context.read<OtpValidationBloc>().add(
                              OtpSubittedEvent(
                                  otp: otpController.text, tempToken: token));
                        },
                        child: authButtonS('Verify'));
                  },
                )
              ],
            )
            // bigButton('Verify')),
          ],
        ),
      ),
    );
  }

 
}
