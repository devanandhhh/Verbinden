
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/auth_repo/auth_service.dart';
import 'package:verbinden/data/models/auth/user_model.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    on<SignupSubmittedEvent>(onsignupSubimitted);
  }

  AuthService service = AuthService();

  void onsignupSubimitted(
      SignupSubmittedEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoadingState());
    try {
      Response? response = await service.userSigup(event.user!);
      if (response != null && response.statusCode == 200) {
        String confirmToken =
            jsonDecode((response.body))['after execution']['Token'];
        emit(SignupSuccessState(token: confirmToken));
      }else if(response != null && response.statusCode == 200){
        String errormsg =
            jsonDecode((response.body))['after execution']['ErrorMessage'];
        emit(SignupFailureState(error: errormsg)); 
      }else{
        print('hello error');
         String errormsg =
            jsonDecode((response!.body))['message'];
        emit(SignupFailureState(error: errormsg)); 
      }
      
    } catch (error) {
      emit(SignupFailureState(error: error.toString()));
    }
  }
}
