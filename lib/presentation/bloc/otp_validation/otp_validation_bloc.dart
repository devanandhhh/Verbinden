import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/auth_repo/auth_service.dart';

part 'otp_validation_event.dart';
part 'otp_validation_state.dart';

class OtpValidationBloc extends Bloc<OtpValidationEvent, OtpValidationState> {
  OtpValidationBloc() : super(OtpValidationInitial()) {
    on<OtpSubittedEvent>(onOtpSubmitted);
    on<OtpResentEvent>(onOtpResent);
    on<OtpResetSuccessEvent>(onOtpResetSubmitted);
  }
  AuthService apiService = AuthService();
  Future<void> onOtpSubmitted(
      OtpSubittedEvent event, Emitter<OtpValidationState> emit) async {
    emit(OtpLoadingState());

    bool? response = await apiService.otpVerify(event.tempToken, event.otp);
    if (response) {
      emit(OtpSuccessState(event.otp));
    } else {
      emit(OtpFaliureState('wrong'));
    }
  }

  Future<void> onOtpResent(
      OtpResentEvent event, Emitter<OtpValidationState> emit) async {
    emit(OtpLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    //
    emit(OtpResendState());
  }

  Future<void> onOtpResetSubmitted(
      OtpResetSuccessEvent event, Emitter<OtpValidationState> emit) async {
    emit(OtpLoadingState());
    try {
      Response? response = await apiService.resetPassword(
          event.otp, event.password, event.confirmpassword, event.token);
      if (response != null || response!.statusCode == 200) {
        emit(OtpResetSuccesstate());
      } else {
        emit(OtpResetFaliurestate());
      }
    } catch (e) {
      emit(OtpResetFaliurestate());
    }
  }
}
