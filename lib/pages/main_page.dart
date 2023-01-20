import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:remission/pages/home.dart';
import 'package:remission/pages/goals.dart';
import 'package:remission/pages/profile.dart';
import 'package:remission/pages/explore.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainPage extends StatefulWidget {
  static String routeName = '/main-page';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

List<Widget> _buildScreens() {
  return [HomePage(), GoalsPage(), ExplorePage(), ProfilePage()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: Colors.blueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.check_circle_outline),
      title: ("Goals"),
      activeColorPrimary: Colors.blueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.search),
      title: ("Explore"),
      activeColorPrimary: Colors.blueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.account_circle_outlined),
      title: ("Profile"),
      activeColorPrimary: Colors.blueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style13,
    );
  }
}
