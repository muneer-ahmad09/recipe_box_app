import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/features/providers.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/auth/welcome/welcome_screen.dart';

class AuthNavigation extends StatelessWidget {

  const AuthNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => WelcomeScreen(
              ),
            );

          case '/login':
            return MaterialPageRoute(
              builder: (context) => LoginScreen(),
            );

          case '/register':
            return MaterialPageRoute(
              builder: (context) => RegisterScreen(
              ),
            );

          // case '/forgot-password':
          //   return MaterialPageRoute(
          //     builder: (context) => const ForgotPasswordScreen(),
          //   );

          default:
            return MaterialPageRoute(
              builder: (context) => WelcomeScreen(
              ),
            );
        }
      },
    );
  }
}