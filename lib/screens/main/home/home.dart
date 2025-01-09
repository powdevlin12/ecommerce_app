import 'package:ercomerce_app/configs/preferences.dart';
import 'package:ercomerce_app/repository/shop_repository.dart';
import 'package:ercomerce_app/routes/app_routes.dart';
import 'package:ercomerce_app/utils/alert_notification.dart';
import 'package:ercomerce_app/widgets/button_widget.dart';
import 'package:ercomerce_app/repository/shop_repository.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _handleLogOut() {
    UserPreferences.removeAccessToken().then((value) {
      if (value == true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      } else {
        showMyDialog(
          context: context,
          onPressed: () {
            Navigator.pop(context);
          },
          content: "Đăng xuất thất bại!",
        );
      }
    });
  }

  int _currentIndex = 0; // To track the current tab

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Center(
        child: ButtonWidget(
          text: "Logout",
          onPressed: () => _handleLogOut(),
        ),
      ),
      const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
      Center(
          child: Text(ShopRepository.userModel!.getName ?? "",
              style: const TextStyle(fontSize: 24))),
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
