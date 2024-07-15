import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/widget_constant.dart';
import 'package:verbinden/presentation/bloc/otp_validation/otp_validation_bloc.dart';
import 'package:verbinden/presentation/pages/auth/NewPassword/create_newPassword.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

class OtpValidationPage extends StatelessWidget {
  OtpValidationPage({super.key, required this.token,required this.trueorflase});

  // final TextEditingController otp1Controller = TextEditingController();

  // final TextEditingController otp2Controller = TextEditingController();

  // final TextEditingController otp3Controller = TextEditingController();

  // final TextEditingController otp4Controller = TextEditingController();
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
            ksizedbox30,
      
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     buildOtpField(otp1Controller, true, context),
            //     buildOtpField(otp2Controller, false, context),
            //     buildOtpField(otp3Controller, false, context),
            //     buildOtpField(otp4Controller, false, context),
            //   ],
            //   //   );
            //   // },
            // ),
            //2
            SizedBox(
              child: Pinput(
                length: 4,
                controller: otpController,)
              ),
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
                        // otp1Controller.clear();
                        // otp2Controller.clear();
                        // otp3Controller.clear();
                        // otp4Controller.clear();

                        //3 
                        otpController.clear();
      
                        context
                            .read<OtpValidationBloc>()
                            .add(OtpResentEvent());
                      },
                      child: authButtonS('Resend OTP'),
                    );
                  },
                ),
                BlocConsumer<OtpValidationBloc, OtpValidationState>(
                  listener: (context, state) async {
                    if (state is OtpSuccessState) {
                      
                      if(trueorflase==true){
                        ScaffoldMessenger.of(context).showSnackBar(
                          kSnakbar(text: 'Verified', col: ksnackbarGreen));
                          knavigatorPush(context, CreateNewPasswordScreen(otp: state.otp,token: token,));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          kSnakbar(text: 'Verified', col: ksnackbarGreen));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      }
                      
                    } else if (state is OtpFaliureState) {
                      ScaffoldMessenger.of(context).showSnackBar(kSnakbar(
                          text: 'Invalid OTP....', col: ksnackbarRed));
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                        onTap: () async {

                          // final otp = otp1Controller.text +
                          //     otp2Controller.text +
                          //     otp3Controller.text +
                          //     otp4Controller.text;
      
                          context.read<OtpValidationBloc>().add(
                              OtpSubittedEvent(otp: otpController.text, tempToken: token));
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

  Widget buildOtpField(
      TextEditingController controller, bool autoFocus, BuildContext ctx) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(ctx).nextFocus();
          }
        },
      ),
    );
  }
}
