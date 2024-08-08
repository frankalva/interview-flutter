import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 35,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined, size: 35,),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: 35,),
          label: 'Profile',
        ),
      ],
      currentIndex: 1, // index
      selectedItemColor: Colors.blue,
      onTap: (index) {
        //to do
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}