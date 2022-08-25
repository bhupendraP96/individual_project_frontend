import 'package:flutter/material.dart';
import 'package:android_assignment/screens/posts.dart';
import 'package:android_assignment/screens/profile.dart';
import 'package:android_assignment/screens/uploadimage.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [
    Posts(),
    UploadImage(),
    ViewProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          selectedFontSize: 12,
          iconSize: 26,
          showUnselectedLabels: false,
          selectedItemColor: Color.fromARGB(255, 245, 245, 245),
          unselectedItemColor: Color.fromARGB(255, 170, 170, 170),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.menu),
            //   label: "Home",
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_sharp,
                size: 32,
              ),
              label: "Upload",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.access_time_filled_sharp),
            //   label: "Home",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
