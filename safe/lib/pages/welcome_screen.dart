// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA), // Background color
      body: Stack(
        children: <Widget>[
          // Image in top-left corner
          Positioned(
            left: -15,
            top: 0,
            child: Image.asset(
              'assets/upr_corner.png',
              width: screenSize.width *
                  0.12, // Adjust image size based on screen width
            ),
          ),

          // Image in bottom-right corner
          Positioned(
            bottom: -2,
            right: -15,
            child: Image.asset(
              'assets/btm_corner.png',
              width: screenSize.width *
                  0.14, // Adjust image size based on screen width
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to SAFE!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0), // Text color
                  ),
                ),
                const SizedBox(height: 50), // Use fractions for spacing
                Image.asset(
                  'assets/welcome.png',
                  width: screenSize.width *
                      0.6, // Adjust image size based on screen width
                ),
                const SizedBox(height: 100), // Use fractions for spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to "Sign In" page
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0XFF6096B4), // Change button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // No border radius
                        ),
                      ),
                      child: SizedBox(
                        width: screenSize.width *
                            0.7, // Adjust button width based on screen width
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Use fractions for spacing
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to "Sign Up" page
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0XFF6096B4), // Change button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // No border radius
                        ),
                      ),
                      child: SizedBox(
                        width: screenSize.width *
                            0.7, // Adjust button width based on screen width
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 0.1), // Use fractions for spacing
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
