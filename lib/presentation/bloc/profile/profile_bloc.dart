import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/profile_repo/profile_service.dart';
import 'package:verbinden/data/models/profile/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileFetchDataEvent>(onProfiledatafeched);
   // on<ViewProfileClicked>(onViewProfilePage);
  }
  ProfileService service = ProfileService();
  // SecureStorageService secureStorage = SecureStorageService();

  Future<void> onProfiledatafeched(
      ProfileFetchDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      log('loading');
      ProfileModel? model = await service.getUserDetails();
      if (model != null) {
        emit(ProfileLoadedState(model));
      }
    } catch (e) {
      log('$e is error');
      emit(ProfileFaliureState(e.toString()));
    }
  }

  // Future<void> onViewProfilePage(
  //     ViewProfileClicked event, Emitter<ProfileState> emit) async {
  //   emit(ProfileViewLoading());
  //   try {
  //     log('loading');
  //     ProfileModel? model = await service.getUserDetails();
  //     if (model != null) {
  //       emit(ProfileViewLoaded(model));
  //     }
  //   } catch (e) {
  //     log('$e is error');   
  //     emit(ProfileViewFaliure(e.toString()));
  //   }
  // }
}
