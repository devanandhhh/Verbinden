// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pinput/pinput.dart';
// import 'package:verbinden/core/widget_constant.dart';
// import 'package:verbinden/presentation/bloc/otp_validation/otp_validation_bloc.dart';
// import 'package:verbinden/presentation/pages/auth/NewPassword/create_newPassword.dart';
// import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
// import 'package:verbinden/presentation/pages/splash/splash_screen.dart';

// class OtpValidationF extends StatelessWidget {
//   OtpValidationF({super.key, required this.temptoken});

//   final String temptoken;
//   final otpController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'OTP Validation',
//           style: fontsize20,
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ksizedbox20,
//             Text(
//               'We have sent a verification code to your email address',
//               style: googleFabz,
//             ),
//             ksizedbox20,
//             SizedBox(
//               child: Pinput(
//                 length: 4,
//                 controller: otpController,
//               ),
//             ),
//             ksizedbox10,
//             TextButton(onPressed: () {}, child: const Text('Resend OTP')),
//             ksizedbox30,
//             BlocConsumer<OtpValidationBloc, OtpValidationState>(
//               listener: (context, state) {
//                 if(state is OtpResetSubittedEvent){
//                   //  knavigatorPush(context,
//                   //         CreateNewPasswordScreen(otp: otpController.text));
//                 }
//               },
//               builder: (context, state) {
//                 return GestureDetector(
//                     onTap: () {
//                     // context.read<OtpValidationBloc().add()
//                     },
//                     child: authButtonS('Verify'));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
