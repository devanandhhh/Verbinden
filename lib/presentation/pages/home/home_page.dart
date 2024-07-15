import 'package:flutter/material.dart';

import 'package:verbinden/presentation/pages/message/widgets/widgets.dart';
import 'package:verbinden/presentation/pages/profile/profile_page.dart';

import 'widgets/widgets.dart';

// Screens for the different bottom navigation items

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: kAppbarDecorate('Verbinden', true),
      body: SingleChildScrollView(
        child: Column( 
          children: [
             SectionOne(
              userName: nameofuser,
            ),
            kdivider(),
            const OthersPostContainer(username:  'kevin_babu',time:  '2 days ago',description: 'description here ',), 
            const OthersPostContainer(username:  'kevin_babu',time:  '2 days ago',description: 'description here ',),
            const OthersPostContainer(username:  'kevin_babu',time:  '2 days ago',description: 'description here ',),
            const OthersPostContainer(username:  'kevin_babu',time:  '2 days ago',description: 'description here ',),
            const OthersPostContainer(username:  'kevin_babu',time:  '2 days ago',description: 'description here ',),
            
          ],
        ),
      ),
    );
  }
}
