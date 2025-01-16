import 'package:ercomerce_app/repository/shop_repository.dart';
import 'package:ercomerce_app/screens/main/home/home.dart';
import 'package:ercomerce_app/screens/main/profile/profile.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0; // To track the current tab

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Home(),
      const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
      const Profile()
    ];

    return Scaffold(
      body: pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current tab index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
