import 'package:flutter/material.dart';

import '../../../../core/colors_constant.dart';

ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, index, _) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index, 
          selectedItemColor: kblackColor,
          showSelectedLabels: false,
          showUnselectedLabels: false ,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            selectedIndex.value = index;
         
          },
          items: const [    
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 25,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.add,size: 30,), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), label: 'Message'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
   