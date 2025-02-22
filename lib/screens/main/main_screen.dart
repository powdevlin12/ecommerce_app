import 'package:ercomerce_app/configs/colors.dart';
import 'package:ercomerce_app/screens/main/home/home.dart';
import 'package:ercomerce_app/screens/main/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0; // To track the current tab
  static const double sizeIcon = 36.0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Home(),
      const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
      const Profile(),
      const Profile(),
    ];

    return Scaffold(
      body: pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: _currentIndex,
        backgroundColor: backgroundColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current tab index
          });
        },
        selectedItemColor: primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/home.svg",
              width: sizeIcon,
              height: sizeIcon,
            ),
            activeIcon: SvgPicture.asset(
              "assets/home.svg",
              width: sizeIcon,
              height: sizeIcon,
              color: primaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/save.svg",
              width: sizeIcon,
              height: sizeIcon,
            ),
            activeIcon: SvgPicture.asset(
              "assets/save.svg",
              width: sizeIcon,
              height: sizeIcon,
              color: primaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/notification.svg",
              width: sizeIcon,
              height: sizeIcon,
            ),
            activeIcon: SvgPicture.asset(
              "assets/notification.svg",
              width: sizeIcon,
              height: sizeIcon,
              color: primaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/profile.svg",
              width: sizeIcon,
              height: sizeIcon,
            ),
            activeIcon: SvgPicture.asset(
              "assets/profile.svg",
              width: sizeIcon,
              height: sizeIcon,
              color: primaryColor,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
