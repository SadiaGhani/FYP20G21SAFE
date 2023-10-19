import 'package:flutter/material.dart';
import 'package:safe/pages/main_menu/menu_screen.dart';
import 'package:safe/pages/sign_up_screen.dart';
import 'package:safe/pages/splash_screen.dart';
import 'package:safe/pages/upload_file.dart';
import 'package:safe/pages/welcome_screen.dart';
import 'package:safe/pages/login_screen.dart';
import 'package:safe/pages/awarness.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Set the initial route to your splash screen
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/uploadfiles': (context) => const UploadFileScreen(),
        '/menu': (context) => MenuPage(),
        '/awarness': (context) => const AwarenessPage(),
      },
    );
  }
}

