part of 'add_profile_picture_bloc.dart';

@immutable
abstract class AddProfilePictureState {}

class AddProfilePictureInitial extends AddProfilePictureState {}

class AddProfilePictureLoadingState extends AddProfilePictureState {}

class AddProfilePictureSuccessState extends AddProfilePictureState {}

class AddProfilePictureFaliureState extends AddProfilePictureState {
  final String error;

  AddProfilePictureFaliureState({required this.error});
}

class ImagePickState extends AddProfilePictureState {
  final File image;

  ImagePickState({required this.image});
}
