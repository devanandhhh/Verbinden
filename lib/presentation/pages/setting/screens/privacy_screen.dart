import 'package:flutter/material.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbarDecorate('Privacy', false, true),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            "In 'Verbinden,' our social media platform, your privacy and security are paramount. "
            "We are committed to protecting your personal information and providing you with a safe environment to share, connect, and communicate. "
            "The privacy screen in Verbinden outlines the key principles and practices we follow to safeguard your data.\n\n"
            "We collect only the necessary information to enhance your experience, such as your profile details, posts, comments, and interactions within the app, including likes and chats. "
            "This data is used to personalize your experience, facilitate communication, and provide you with relevant content.\n\n"
            "Your messages and images are securely transmitted and stored, with robust encryption protocols ensuring that your private conversations remain confidential. "
            "We do not share your personal data with third parties without your explicit consent, except when required by law or to protect the rights and safety of our users.\n\n"
            "In Verbinden, you have control over your data. You can manage your privacy settings, decide who can see your posts and interactions, and easily delete any content you no longer wish to share. "
            "Our platform is designed to empower you with the tools to safeguard your digital presence.\n\n"
            "By using Verbinden, you agree to our terms of service and privacy policy, which are designed to ensure a transparent, secure, and enjoyable experience for all users. "
            "We are continually working to enhance our privacy measures and welcome any feedback to make your experience safer and more secure.",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
