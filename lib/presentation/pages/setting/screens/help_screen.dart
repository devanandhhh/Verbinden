import 'package:flutter/material.dart';
import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbarDecorate('Help', false, true),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            "Need help with Verbinden? We’re here to assist you! Below are some common questions and tips to help you navigate our app.\n\n"
            "Getting Started:\n"
            "• How do I create an account? \n"
            "To create an account, download the Verbinden app from the app store, open it, and follow the on-screen instructions to sign up with your email or phone number.\n\n"
            "• How do I post an image? \n"
            "To post an image, tap on the camera icon in the app’s main screen, choose or capture an image, add a caption if desired, and then tap 'Post'.\n\n"
            "Troubleshooting:\n"
            "• I'm having trouble logging in. \n"
            "If you’re unable to log in, please check that you’re using the correct email or phone number and password. If you've forgotten your password, use the 'Forgot Password' option to reset it.\n\n"
            "• My app is crashing. \n"
            "If the app crashes, try restarting it or updating it to the latest version. If the problem persists, contact our support team.\n\n"
            "Contact Us:\n"
            "• If you have any other questions or need further assistance, feel free to reach out to our support team at support@verbinden.com. We're here to help you!\n\n"
            "We’re constantly working to make Verbinden better, and we value your feedback. Thank you for using Verbinden!",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
