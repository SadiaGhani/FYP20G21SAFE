import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

Future<void> signInWithEmailAndPassword(String email, String password) async {
 // print("i am in function of sign innnnnnnnnnnnnnnnnnnn");
  try {
   // print("i am in truyyyyyyyyyyyyyyyyyyyyyyyy");
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // The user is now signed in
    print('User logged in: ${credential.user?.email}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      print('Error signing in: ${e.code}');
    }
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
                //Navigator.pushNamed(context, '/menu'); 
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
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA), // Background color
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double screenHeight = MediaQuery.of(context).size.height;
          // final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

          // Determine if it's a small or large screen based on height
          bool isSmallScreen = screenHeight < 0;

          // Adjust padding and font sizes for small screens
          EdgeInsets contentPadding = isSmallScreen
              ? const EdgeInsets.all(100.0)
              : const EdgeInsets.fromLTRB(10.0, 180.0, 10.0, 0.0);
          double welcomeTextFontSize = isSmallScreen ? 20.0 : 24.0;

          return SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                // Image in top-left corner
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
                  right: -15,
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
                      padding: contentPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: welcomeTextFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Image.asset(
                                  'assets/welcome.png',
                                  width: 100,
                                  height: 100,
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
                        color: Color(0XFF93BFCF), // Pink background
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
                                color: const Color.fromARGB(184, 184, 210,
                                    216), // Light blue background
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.email),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
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
                                color: const Color.fromARGB(184, 184, 210,
                                    216), // Light blue background
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.lock),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
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
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/menu'); 
                                print("i am in login in butonnnnnnnnnnnnnnnn");
                                String email = emailController.text;
                                String password = passwordController.text;
                                FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
                                .then((value) {
                                  print("Login Sucessfully");
                                  Navigator.pushNamed(context, '/menu');       
                                }
                                );
                               
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(
                                    0XFF6096B4), // Change button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), // No border radius
                                ),
                              ),
                              child: SizedBox(
                                width: screenSize.width *
                                    0.8, // Adjust button width based on screen width
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Do not have a account.No worries Just ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to the login page
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: const Text(
                                    "Signup",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0,
                                          0), // Customize the text color
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
          );
        },
      ),
    );
  }
}
