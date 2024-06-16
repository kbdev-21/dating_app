import 'package:facebook_clone/common/styles.dart';
import 'package:facebook_clone/common/theme.dart';
import 'package:facebook_clone/feature/home/home_page.dart';
import 'package:facebook_clone/feature/message/message_page.dart';
import 'package:facebook_clone/feature/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final List _pages = [const HomePage(), const MessagePage(), const ProfilePage()];

  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble_2_fill), label: 'Matched'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_fill), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/app_icon.png', width: 30, height: 30),
            SizedBox(
              width: 10,
            ),
            Text(
              'HeartBeat',
              style: AppStyles.bold26,
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      onTap: (int newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      },
      currentIndex: _currentIndex,
      items: _barItems,
      showSelectedLabels: false, // Disable showing labels for selected items
      showUnselectedLabels:
          false, // Disable showing labels for unselected items
      iconSize: 28,
      backgroundColor: Colors.white,
      //unselectedItemColor: AppTheme.grey2,
      selectedItemColor: AppTheme.primaryColor,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    );
  }
}
