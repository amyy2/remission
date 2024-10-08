import 'package:flutter/material.dart';
import 'package:remission/colors.dart';
import 'package:remission/pages/home/home.dart';
import 'package:remission/pages/goals.dart';
import 'package:remission/pages/profile/profile.dart';
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
  return [const HomePage(), const GoalsPage(), const ExplorePage(), const ProfilePage()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: MyColors.darkBlue,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.check_circle_outline),
      title: ("Goals"),
      activeColorPrimary: MyColors.darkBlue,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.search),
      title: ("Explore"),
      activeColorPrimary: MyColors.darkBlue,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.account_circle_outlined),
      title: ("Profile"),
      activeColorPrimary: MyColors.darkBlue,
      inactiveColorPrimary: Colors.white,
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
      backgroundColor: MyColors.mediumBlue, // Default is Colors.white.
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
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style13,
    );
  }
}
