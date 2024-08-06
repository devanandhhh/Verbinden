import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:verbinden/data/api/profile_repo/section_1/profile_service.dart';

part 'add_profile_picture_event.dart';
part 'add_profile_picture_state.dart';

class AddProfilePictureBloc
    extends Bloc<AddProfilePictureEvent, AddProfilePictureState> {
  AddProfilePictureBloc() : super(AddProfilePictureInitial()) {
    on<ImagePickEvent>(onImagePicked);
    on<AddProfilePictureClickEvent>(onAddProfilePicture);
  }

  FutureOr<void> onImagePicked(
      ImagePickEvent event, Emitter<AddProfilePictureState> emit) {
    emit(ImagePickState(image: event.image!));
  }

  FutureOr<void> onAddProfilePicture(AddProfilePictureClickEvent event,
      Emitter<AddProfilePictureState> emit) async {
    emit(AddProfilePictureLoadingState());
    try {
      final responseCode = await ProfileService().addUserProfilePhoto(
        event.imagePath.path
      );
      log('$responseCode is response code');
      if (responseCode == 200) {
        emit(AddProfilePictureSuccessState());
      } else {
        emit(AddProfilePictureFaliureState(error: 'status code is not 200'));
      }
    } catch (e) {
      print('Error is $e by onAddProfilePicture');
    }
  }
}
