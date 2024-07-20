part of 'upload_post_bloc.dart';

@immutable
abstract class UploadPostEvent {}

class AddPostButtonClickEvent extends UploadPostEvent{
  final File imagepath;
  final String caption;
  AddPostButtonClickEvent({required this.imagepath,required this.caption});
}
class ImagePickEvent extends UploadPostEvent{
 final File image;
 ImagePickEvent(this.image);
 
}