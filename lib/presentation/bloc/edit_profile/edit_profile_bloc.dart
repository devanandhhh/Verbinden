import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:verbinden/data/api/profile_repo/profile_service.dart';
import 'package:verbinden/data/models/profile/edit_profile.dart';


part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileSubmitted>(onEditprofilesubmitted);
  }
ProfileService service = ProfileService();
  Future<void> onEditprofilesubmitted(EditProfileSubmitted event, Emitter<EditProfileState> emit) async{
    emit(EditProfileLoadingState());
    try{
    int? responsecode=  await service.editUserDetails(event.model);
    if(responsecode==200){
      emit(EditProfileSuccessState());
      log('succes state ');
    }else if(responsecode ==400){
      emit(EditProfileFaliureState());
    }
    }catch(e){
       emit(EditProfileErrorState(e.toString()));
    }
  }
}
