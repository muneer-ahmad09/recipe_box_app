import 'package:flutter/material.dart';

import '../screens/add_item/add_item.dart';
import '../screens/bookmark/bookmark.dart';
import '../screens/home/home.dart';
import '../screens/profile/profile.dart';
import '../screens/search/search.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<StatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    Home(),
    Search(),
    AddItem(),
    Bookmark(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _getAppBar(),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_filled),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined),
            selectedIcon: Icon(Icons.add_box),
            label: "Add",
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline_rounded),
            selectedIcon: Icon(Icons.bookmark_rounded),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_3_outlined),
            selectedIcon: Icon(Icons.person_3_rounded),
            label: "Home",
          ),
        ],
      ),
    );
  }

  // PreferredSizeWidget _getAppBar(){
  //   switch(_selectedIndex){
  //     case 0 :
  //       return AppBar(
  //         title: Text("Home"),
  //       );
  //     case 1:
  //       return AppBar(
  //         title: Text("Search"),
  //       );
  //
  //     case 2:
  //       return AppBar(
  //         title: Text("Add"),
  //       );
  //
  //     case 3:
  //       return AppBar(
  //         title: Text("Bookmark"),
  //       );
  //
  //     case 4:
  //       return AppBar(
  //         title: Text("Profile"),
  //       );
  //
  //     default:
  //       return AppBar();
  //
  //   }
  //
  // }
}
