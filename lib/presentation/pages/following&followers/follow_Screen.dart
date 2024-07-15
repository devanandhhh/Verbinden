import 'package:flutter/material.dart';

class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key, required this.name});
final String name ;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(name),
            bottom:const TabBar(
              tabs: [
                Tab(
                  text: 'Follwers',
                ),
                Tab(
                  text: 'Followings',
                )
              ],
            ),
          ),
          body:const TabBarView(children: [
FollowersPage(),FollowingsPage()
          ],),
        ));
  }
}

class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Followers Page'),
    );
  }
}

class FollowingsPage extends StatelessWidget {
  const FollowingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Followings Page'),
    );
  }
}