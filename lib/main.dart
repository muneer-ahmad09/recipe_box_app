import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:recipe_box_app/core/network/api_client.dart';
import 'package:recipe_box_app/core/storage/token_storage.dart';
import 'package:recipe_box_app/navigation/auth_navigation.dart';
import 'package:recipe_box_app/navigation/main_navigation.dart';

import 'core/auth/auth_manager.dart';
import 'core/auth/auth_service.dart';
import 'core/auth/auth_state.dart';
import 'core/network/auth_interceptor.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final refreshDio = Dio(
    BaseOptions(baseUrl: 'https://c14f-49-36-217-239.ngrok-free.app'),
  );
  final TokenStorage tokenStorage = TokenStorage();
  final AuthInterceptor authInterceptor = AuthInterceptor(
    tokenStorage,
    refreshDio,
  );
  final ApiClient apiClient = ApiClient(authInterceptor);
  final AuthService authService = AuthService(apiClient, tokenStorage);
  final AuthManager authManager = AuthManager(authService, tokenStorage);
  runApp(MyApp(authManager: authManager));
}

class MyApp extends StatefulWidget {
  final AuthManager authManager;

  const MyApp({super.key, required this.authManager});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.authManager.initialize().then((_){
      FlutterNativeSplash.remove();
    });
  }

  Future<void> _reInitialize() async{
    await widget.authManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: ListenableBuilder(
        listenable: widget.authManager,

        builder: (context, child) {
          if(widget.authManager.initializationError!=null){
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.authManager.initializationError!),
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
            if (widget.authManager.authState == AuthState.initializing) {
              return const SizedBox.shrink(); // means render noting
            } else if (widget.authManager.authState == AuthState.authenticated) {
              return const MainNavigation();
            } else {
              return AuthNavigation(authManager: widget.authManager,);
            }
          }
        },
      ),
    );
  }
}
