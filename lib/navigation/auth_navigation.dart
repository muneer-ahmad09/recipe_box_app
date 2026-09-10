import 'package:flutter/material.dart';

import '../core/auth/auth_manager.dart';
// import '../screens/auth/forgotPassword/forgot_password_screen.dart';
import '../screens/auth/login/login_screen.dart';
import '../screens/auth/register/register_screen.dart';
import '../screens/auth/welcome/welcome_screen.dart';

class AuthNavigation extends StatelessWidget {
  final AuthManager authManager;

  const AuthNavigation({
    super.key,
    required this.authManager,
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
                authManager: authManager,
              ),
            );

          case '/login':
            return MaterialPageRoute(
              builder: (context) => LoginScreen(
                authManager: authManager,
              ),
            );

          case '/register':
            return MaterialPageRoute(
              builder: (context) => RegisterScreen(
                authManager: authManager,
              ),
            );

          // case '/forgot-password':
          //   return MaterialPageRoute(
          //     builder: (context) => const ForgotPasswordScreen(),
          //   );

          default:
            return MaterialPageRoute(
              builder: (context) => WelcomeScreen(
                authManager: authManager,
              ),
            );
        }
      },
    );
  }
}