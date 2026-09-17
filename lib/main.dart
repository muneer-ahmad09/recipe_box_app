import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box_app/core/services/recipe_service.dart';

import 'package:recipe_box_app/navigation/auth_navigation.dart';
import 'package:recipe_box_app/navigation/main_navigation.dart';

import 'core/auth/auth_manager.dart';
import 'core/auth/auth_state.dart';
import 'core/dependencies/app_dependencies.dart';

import 'core/features/providers.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );


  runApp(
     ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {

  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final authManager = ref.read(authManagerProvider);


  @override
  void initState() {
    super.initState();
    authManager.initialize().then((_){
      FlutterNativeSplash.remove();
    });
  }

  Future<void> _reInitialize() async{
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
          if(authManager.initializationError!=null){
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(authManager.initializationError!),
                    ElevatedButton(
                      onPressed: (){_reInitialize();},
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          else{
            if (authManager.authState == AuthState.initializing) {
              return const SizedBox.shrink(); // means render noting
            } else if (authManager.authState == AuthState.authenticated) {
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
