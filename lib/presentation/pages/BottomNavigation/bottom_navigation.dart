import 'dart:developer';

import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../message/message_page.dart';
import '../post/post_page.dart';
import '../profile/profile_page.dart';
import '../search/search_page.dart';
import 'widgets/bottom_nav_widget.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final List<Widget> pages = const [
    HomePage(),
    Search(),
    PostScreen(),
    MessageScreen(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    log('rebuild here bottom navigation screen');
    return Scaffold(
      //2

      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, index, _) {
          return pages[index];
        },
      ),

      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
