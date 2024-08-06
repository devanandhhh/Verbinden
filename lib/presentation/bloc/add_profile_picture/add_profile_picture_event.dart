part of 'add_profile_picture_bloc.dart';

@immutable
abstract class AddProfilePictureEvent {}

class AddProfilePictureClickEvent extends AddProfilePictureEvent {
  final File imagePath;

  AddProfilePictureClickEvent({required this.imagePath});
}

class ImagePickEvent extends AddProfilePictureEvent {
   final File? image;

  ImagePickEvent(  {required  this.image} );
}
