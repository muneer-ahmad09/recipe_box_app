import 'package:flutter/material.dart';
import 'package:recipe_box_app/navigation/main_navigation.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}
