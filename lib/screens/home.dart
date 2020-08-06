import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';


import 'tracking_page.dart';
import 'log_pages.dart';
import 'stats_pages.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<Widget> screenBuilder = [
    TrackingPage(),
    LogPage(),
    StatsPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Feather.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.align_justify),
            title: Text('Log'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.bar_chart),
            title: Text('Statistics'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF804CD9),
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.white70,
        onTap: _onItemTapped,
      ),
      body: screenBuilder[_selectedIndex],
      );
  }
}