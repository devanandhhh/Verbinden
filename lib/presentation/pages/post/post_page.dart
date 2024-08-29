import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/constant.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

import '../../bloc/upload_post/upload_post_bloc.dart';
import '../auth/widgets/validation_service.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  Future<void> pickImageFromGallery(BuildContext context) async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      // ignore: use_build_context_synchronously
      context.read<UploadPostBloc>().add(ImagePickEvent(File(pickImage.path)));
    }
  } 

   void validateAndSubmit(BuildContext context, File? image, String caption) {
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          kSnakbar(text: 'Please select an image', col: ksnackbarRed));
    } else if (caption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          kSnakbar(text: 'Please add a description', col: ksnackbarRed));
    } else {
      context.read<UploadPostBloc>().add(
            AddPostButtonClickEvent(
             
              caption: caption, imagepath: image,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final captionController = TextEditingController();
    return Scaffold(
      appBar: kAppbarDecorate('Add Post'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UploadPostBloc, UploadPostState>(
              builder: (context, state) {
                File? image;
                if(state is ImagePickState){
                  image=state.image; 
                }
                return Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: ksnackbarGreen,
                      borderRadius: BorderRadius.circular(18)),
                  child: InkWell(
                    onTap: ()=>pickImageFromGallery(context),
                    child: image == null
                        ? const Icon(
                            Icons.add_a_photo_rounded,
                            size: 60,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                );
              },
            ),
            h30,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextFormField(
                controller: captionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Add Description',
                ),
                validator: (value) =>
                    ValidationService.validateCaption(captionController.text),
              ),
            ),
            h20,
            BlocConsumer<UploadPostBloc, UploadPostState>(
              listener: (context, state) {
                if (state is UploadSucessState) {
                   captionController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                      kSnakbar(text: 'post Added', col: ksnackbarGreen));
                      
                } else if (state is UploadFaliureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      kSnakbar(text: 'Image size to big', col: ksnackbarRed));
                }
              },
              builder: (context, state) {
                if (state is UploadLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return InkWell(
                    onTap: () {
                      final currentState =context.read<UploadPostBloc>().state;
                      File? image;
                      if(currentState is ImagePickState){
                        image =currentState.image;
                      }
                      validateAndSubmit(context, image, captionController.text);
                            
                    },
                    child: kwidth90Button('Add post'));
              },
            )
          ],
        ),
      ),
    );
  }
}
