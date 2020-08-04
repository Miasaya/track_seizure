import 'package:flutter/material.dart';
import 'screens/tracking_page.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_icons/flutter_icons.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens(){
    return[
      TrackingPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(){
    return [
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesome.home),
        title: 'Home',
        activeColor: Colors.purple[200],
        inactiveColor: Colors.grey[900]),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesome.align_justify),
        title: 'Log',
        activeColor: Colors.purple[200],
        inactiveColor: Colors.grey[900]),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesome.bar_chart),
        title: 'Stats',
        activeColor: Colors.purple[200],
        inactiveColor: Colors.grey[900]),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesome.cog),
        title: 'Settings',
        activeColor: Colors.purple[200],
        inactiveColor: Colors.grey[900]),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      screens: _buildScreens(),
      controller: _controller,
      items: _navBarItems(),
      backgroundColor: Colors.white,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      resizeToAvoidBottomInset: true,
      navBarStyle: NavBarStyle.style12,
    );
  }
}