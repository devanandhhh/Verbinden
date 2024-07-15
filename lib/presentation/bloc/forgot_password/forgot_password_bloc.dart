
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../data/api/auth_repo/auth_service.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmittedEvent>(onsubmitted);
  }
AuthService service = AuthService();


  Future<void> onsubmitted(ForgotPasswordSubmittedEvent event, Emitter<ForgotPasswordState> emit) async{
     emit(ForgotPasswordLoadingState());
  try{
   Response? response =await service.userForgotPassword(event.email);
   if(response!=null&&response.statusCode==200){
     String confirmToken =jsonDecode((response.body))['after execution']['Token'];
    emit(ForgotPasswordSuccessState(tempToken: confirmToken));
   }
  }catch(e){
   emit(ForgotPasswordFaliurState('not matching'));
  }
  }
}
