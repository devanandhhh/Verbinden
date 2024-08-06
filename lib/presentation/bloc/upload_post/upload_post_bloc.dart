import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/api/add_post/add_post.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  UploadPostBloc() : super(UploadPostInitial()) {
    on<AddPostButtonClickEvent>(onPostUpload);
    on<ImagePickEvent>(onImagePicked);
  }

  Future<void> onPostUpload(
      AddPostButtonClickEvent event, Emitter<UploadPostState> emit) async {
    emit(UploadLoadingState());
    try {
      final responseCode =
          await AddPostService().addPost(event.imagepath.path, event.caption);

      if (responseCode == 200) {
        
        emit(UploadSucessState());
       // emit(UploadPostInitial());
      } else {
        emit(UploadFaliureState('status code is not 200'));  
      }

      //emit(UploadFaliureState('response null'));
     // print('response is null');
    } catch (e) {
      print('Error is $e by onpostuploadbloc');
    }
  }

  FutureOr<void> onImagePicked(
      ImagePickEvent event, Emitter<UploadPostState> emit) async {
    emit(ImagePickState(image: event.image));
  }
}
