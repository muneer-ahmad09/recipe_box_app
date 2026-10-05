import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_box_app/navigation/auth_navigation.dart';
import 'package:recipe_box_app/navigation/main_navigation.dart';

import 'core/auth/auth_state.dart';

import 'core/features/providers.dart';
import 'core/notifications/notification_service.dart';
import 'core/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final authManager = ref.read(authManagerProvider);

  late final notificationService = ref.read(notificationServiceProvider);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await notificationService.initialize();
    await authManager.initialize();

    FlutterNativeSplash.remove();
  }

  Future<void> _reInitialize() async {
    await authManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: ListenableBuilder(
        listenable: authManager,

        builder: (context, child) {
          if (authManager.initializationError != null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(authManager.initializationError!),
                    ElevatedButton(
                      onPressed: () {
                        _reInitialize();
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            if (authManager.authState == AuthState.initializing) {
              return const SizedBox.shrink(); // means render noting
            } else if (authManager.authState == AuthState.authenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                notificationService.handlePendingNotification();
              });

              return MainNavigation();
            } else {
              return AuthNavigation();
            }
          }
        },
      ),
    );
  }
}
