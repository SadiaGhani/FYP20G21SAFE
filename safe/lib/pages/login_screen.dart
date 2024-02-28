import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:safe/pages/CaptureImage.dart';





import 'package:camera/camera.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  final LocalAuthentication _localAuth = LocalAuthentication();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _failedLoginAttempts = 0;

  Future<void> _authenticate(BuildContext context) async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuth.authenticate(
        biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true,
        localizedReason: 'Authenticate with Face',
      );
    } catch (e) {
      print('Error: $e');
    }

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/menu');
    } else {
      _showFailedLoginWarning(context);
    }
  }

  void _showFailedLoginWarning(BuildContext context) {
    _failedLoginAttempts++;
    if (_failedLoginAttempts >= 3) {
                Navigator.pop(context); 
                _captureAndDisplayImage(context, _emailController.text.trim());
       
    }
  }
Future<void> _captureAndDisplayImage(BuildContext context, String userEmail) async {
  print('image taking');
  final cameras = await availableCameras();
  final firstCamera = cameras.firstWhere(
    (camera) => camera.lensDirection == CameraLensDirection.front,
    
  );

  if (firstCamera == null) {
    print('No front camera found');
    // You can handle this case by showing a message or using a default camera
    return;
  }

  final controller = CameraController(
    firstCamera,
    ResolutionPreset.medium,
  );

  try {
    print('im in try ');
    await controller.initialize();
    final XFile imageFile = await controller.takePicture();
     saveCapturedImagePath(imageFile.path);
  } catch (e) {
    print('Error capturing image: $e');
  } finally {
    await controller.dispose(); // Dispose the camera controller
  }
}
Future<void> saveCapturedImagePath(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('capturedImagePath', path);
}

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      print('User logged in: ${credential.user?.email}');
      _authenticate(context);
      // Navigator.pushReplacementNamed(context, '/menu');
    } on FirebaseAuthException catch (e) {
      print('object');
      _showFailedLoginWarning(context);
      _showErrorDialog(context, 'Error signing in', 'Error occurred while signing in: ${e.code}');
    }
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: -15,
              top: 0,
              child: Image.asset(
                'assets/upr_corner.png',
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              right: 0,
              top: -30,
              child: Image.asset(
                'assets/safe_logo.png',
                width: 200,
                height: 200,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0XFF93BFCF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 50),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(184, 184, 210, 216),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.email),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(184, 184, 210, 216),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.lock),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _signInWithEmailAndPassword(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF6096B4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Log In",
                                style: TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Do not have an account? ",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
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
