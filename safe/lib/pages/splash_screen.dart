import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    // Start the animation after a delay.
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showLogo = true;
      });

      // Navigate to the welcome screen after the animation.
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/welcome');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.01,
            left: -screenWidth * 0.015,
            child: Image.asset(
              'assets/upr_corner.png',
              width: screenWidth * 0.1,
              height: screenHeight * 0.1,
            ),
          ),
          Positioned(
            bottom: -screenHeight * 0.01,
            right: -screenWidth * 0.015,
            child: Image.asset(
              'assets/btm_corner.png',
              width: screenWidth * 0.1,
              height: screenHeight * 0.1,
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _showLogo ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/safe_logo.png',
                width: screenWidth * 0.5,
                height: screenHeight * 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
