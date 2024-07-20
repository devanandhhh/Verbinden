part of 'upload_post_bloc.dart';

@immutable
abstract class UploadPostState {}

class UploadPostInitial extends UploadPostState {}

class UploadLoadingState extends UploadPostState {}

class UploadSucessState extends UploadPostState {}

class UploadFaliureState extends UploadPostState {
  final String error;
  UploadFaliureState(this.error);
}
class ImagePickState extends UploadPostState{
  final File image;
  ImagePickState({required this.image});
}