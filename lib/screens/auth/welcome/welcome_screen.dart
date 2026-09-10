import 'package:flutter/material.dart';
import 'package:recipe_box_app/core/theme/app_colors.dart';

import '../../../core/auth/auth_manager.dart';
import '../login/login_screen.dart';
import '../register/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final AuthManager authManager;
  const WelcomeScreen({super.key, required this.authManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.petrolDark,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_icon_foreground.png',
                  width: 250,
                  height: 250,
                ),

                Text(
                  'Recipe Box',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),

                Text(
                  'Welcome to Recipe Box',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),

            Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen(authManager: authManager,)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mustard,
                    fixedSize: const Size(250, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 20,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(authManager: authManager,)),
                    );
                  },
                  child: Text(
                    'I already have an account',
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
