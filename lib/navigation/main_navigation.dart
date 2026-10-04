import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/notifications/route_arguments.dart';
import 'package:recipe_box_app/navigation/main_navigation_controller.dart';

import '../core/features/add_recipe/add_recipe_controller.dart';
import '../core/features/add_recipe/add_recipe_state.dart';
import '../core/notifications/navigation_keys.dart';
import '../screens/add_item/add_item.dart';
import '../screens/bookmark/bookmark.dart';
import '../screens/home/home.dart';
import '../screens/profile/profile.dart';
import '../screens/recipe_page/recipe_page.dart';
import '../screens/search/search.dart';
import '../screens/setting/setting_screen.dart';

class MainNavigation extends ConsumerStatefulWidget {

  const MainNavigation({super.key});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {


  late final List<Widget> _screens = [
    Home(),
    Search(),
    AddItem(),
    Bookmark(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(mainNavigationProvider);

    return Navigator(
        key: mainNavigatorKey,
      observers: [
        HeroController(),
      ],
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: _getAppBar(context, selectedIndex),
                body: SafeArea(
                  child: _screens[selectedIndex],
                ),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    ref
                        .read(mainNavigationProvider.notifier)
                        .selectTab(index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_filled),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.add_box_outlined),
                      selectedIcon: Icon(Icons.add_box),
                      label: 'Add',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bookmark_outline_rounded),
                      selectedIcon: Icon(Icons.bookmark_rounded),
                      label: 'Saved',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_3_outlined),
                      selectedIcon: Icon(Icons.person_3_rounded),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            );

          case '/recipe':
            final args = settings.arguments as RecipeRouteArguments;

            return MaterialPageRoute(
              builder: (context) => RecipePage(
                id: args.id,
                initialImageUrl: args.initialImageUrl,
              ),
            );

          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: _getAppBar(context, selectedIndex),
                body: SafeArea(
                  child: _screens[selectedIndex],
                ),
              ),
            );
        }
      },
    );
  }

  PreferredSizeWidget _getAppBar(BuildContext context, int selectedIndex){
    switch(selectedIndex){
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
            Consumer(
              builder: (context, ref, child) {
                final status = ref.watch(
                  addRecipeProvider.select((state) => state.status),
                );

                return TextButton(
                  onPressed: status == AddRecipeStatus.saving
                      ? null
                      : () async {
                    final recipe =
                    await ref.read(addRecipeProvider.notifier).saveRecipe();

                    if (recipe == null) {
                      return;
                    }
                    ref.read(addRecipeProvider.notifier).reset();


                    // Success handling will come next.
                  },
                  child: status == AddRecipeStatus.saving
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(),
                  )
                      : const Text("Save"),
                );
              },
            ),
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
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            }, icon: Icon(Icons.settings))
          ],
        );

      default:
        return AppBar();

    }

  }
}
