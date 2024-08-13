import 'package:flutter/material.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbarDecorate('About', false, true),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            "Welcome to Verbinden, the social media platform designed to connect you with the world around you. "
            "Verbinden is more than just a platform—it's a community where you can share your thoughts, images, and ideas freely and safely.\n\n"
            "Our mission is to bring people together, fostering meaningful conversations and interactions. "
            "Whether you're posting a photo, commenting on a friend's post, or engaging in a chat, Verbinden is here to make your social experience seamless and enjoyable.\n\n"
            "Key Features:\n"
            "> CHAT : Instantly connect with your friends and family through our secure messaging system. Your conversations are encrypted and private.\n"
            "> IMAGE SHARING : Share your favorite moments by posting images. Let others like and comment, creating a space for interaction and expression.\n"
            "> LIKE AND COMMENT : Engage with content by liking posts and leaving comments. Verbinden allows you to express yourself and connect with others in a meaningful way.\n\n"
            "Our commitment is to continuously improve your experience by adding new features and enhancing existing ones. We value your feedback and encourage you to reach out with suggestions on how we can make Verbinden even better.\n\n"
            "Thank you for being a part of Verbinden. Together, we create a vibrant, connected world.",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
