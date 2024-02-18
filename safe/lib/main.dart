import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safe/pages/alarms.dart';
import 'package:safe/pages/awarness.dart';
import 'package:safe/pages/contact_us_screen.dart';
import 'package:safe/pages/fake_shutdown_screen.dart';
import 'package:safe/pages/location.dart';
import 'package:safe/pages/login_screen.dart';
import 'package:safe/pages/main_menu/device_got_lost_screen.dart';
import 'package:safe/pages/main_menu/menu_screen.dart';
import 'package:safe/pages/notifications.dart';
import 'package:safe/pages/remoteWipeScreen.dart';
import 'package:safe/pages/settings.dart';
import 'package:safe/pages/sign_up_screen.dart';
import 'package:safe/pages/splash_screen.dart';
import 'package:safe/pages/threat.dart';
import 'package:safe/pages/upload_file.dart';
import 'package:safe/pages/user_profile_screen.dart';
import 'package:safe/pages/welcome_screen.dart';
import 'package:safe/pages/BiometricAuthenticationScreen.dart';
//import 'firebase_options.dart'

void main() async {
  print(" Before initilization ");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("Initialize completeeddddddddddddddddddddddddddddddddddddd");
  runApp(const MyApp());
}
// void main() async {
//   print(" Before initilization ");
//   WidgetsFlutterBinding.ensureInitialized();
// //  await Firebase.initializeApp(
// //   options: DefaultFirebaseOptions.currentPlatform,
// // );
//   print("Initialize completeeddddddddddddddddddddddddddddddddddddd");
//   runApp(const MyApp());
// }

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
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/uploadfiles': (context) => const UploadFileScreen(),
        '/menu': (context) => MenuPage(),
        '/awarness': (context) => const AwarenessPage(),
        '/alarms': (context) => AlarmsPage(),
        '/location': (context) => LocationTrackingPage(),
        // ignore: prefer_const_constructors
        '/devicegotlost': (context) => DeviceGotLostScreen(),
        '/fakeshutdown': (context) => const FakeShutdownScreen(),
        '/contactus': (context) => const ContactUsScreen(),
        '/userprofile': (context) => UserProfileScreen(name: '', email: '', picture: ''),
        '/remoteWipe': (context) => const RemoteWipeScreen(),
        '/notifications': (context) => NotificationsPage(),
        '/settings': (context) => SettingsPage(),
        '/threats': (context) => ThreatIntelligencePage(),
        '/auth':(context)=> BiometricAuthenticationScreen(),

      },
    );
  }
}
