import 'package:flutter/material.dart';
import 'package:verbinden/core/colors_constant.dart';
import 'package:verbinden/core/widget_constant.dart';
import 'package:verbinden/presentation/pages/auth/widgets/authwidgets.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbarDecorate('Add Post'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  color: ksnackbarGreen,
                  borderRadius: BorderRadius.circular(18)),
              child: const Center(
                child: Icon(
                  Icons.add_a_photo_rounded,
                  size: 60,
                ),
              ),
            ),
            ksizedbox30,
            // Container(width: 300,height: 100,decoration: BoxDecoration(color: ksnackbarGreen,borderRadius: BorderRadius.circular(8)),child: Center(child: Text('Add Description here '),)),
            ksizedbox20,
            kwidth90Button('Add post')
          ],
        ),
      ),
    );
  }
}
