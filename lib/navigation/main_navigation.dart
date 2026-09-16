import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/auth/auth_manager.dart';

import '../core/services/recipe_service.dart';
import '../screens/add_item/add_item.dart';
import '../screens/bookmark/bookmark.dart';
import '../screens/home/home.dart';
import '../screens/profile/profile.dart';
import '../screens/search/search.dart';
import '../screens/setting/setting_screen.dart';

class MainNavigation extends StatefulWidget {
  final AuthManager authManager;
  final RecipeService recipeService;
  const MainNavigation({super.key, required this.authManager, required this.recipeService});

  @override
  State<StatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final GlobalKey<AddItemState> _addItemKey = GlobalKey<AddItemState>();
  //
  // Why do we need a GlobalKey?
  //
  // Currently MainNavigation has the AddItem widget:
  //
  // AddItem()
  //
  // But the saveRecipe() method will belong to:
  //
  // _AddItemState
  //
  // We need a way for MainNavigation to say:
  //
  // "Hey, AddItem — run your save method."
  //
  // A GlobalKey gives the parent access to the State object of a StatefulWidget.

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _screens = [
    Home( authManager: widget.authManager,recipeService: widget.recipeService,),
    Search(),
    AddItem(key: _addItemKey,),
    Bookmark(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) =>Scaffold(
            appBar: _getAppBar(context,widget.authManager),
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
          )
        );
      }
    );
  }

  PreferredSizeWidget _getAppBar(BuildContext context,AuthManager authManager){
    switch(_selectedIndex){
      case 0 :
        return AppBar(
          title: Text("Recipe Box",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
        );
      case 1:
        return AppBar(
          title: Text("Search",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
        );

      case 2:
        return AppBar(
          title: Text("New Recipe",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
          actions: [
            TextButton(onPressed: () { _addItemKey.currentState?.saveRecipe(); }, child: Text("Save"),)
          ],
        );

      case 3:
        return AppBar(
          title: Text("Saved",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
        );

      case 4:
        return AppBar(
          title: Text("Profile",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen(authManager: authManager,)),
              );
            }, icon: Icon(Icons.settings))
          ],
        );

      default:
        return AppBar();

    }

  }
}
