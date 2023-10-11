import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA), // Background color
      body: Center(
        // Center the entire content
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
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
              right: -15,
              bottom: 0,
              child: Image.asset(
                'assets/btm_corner.png',
                width: 100,
                height: 100,
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center horizontally
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center horizontally
                    children: <Widget>[
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0), // Text color
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          'assets/signup.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextFieldWithIcon(Icons.account_circle, 'Name'),
                      const SizedBox(height: 10),
                       const TextFieldWithIcon(Icons.phone, 'Phone Number'),
                      const SizedBox(height: 10),
                       const TextFieldWithIcon(FontAwesomeIcons.addressBook, 'Address'),
                      const SizedBox(height: 10),
                      const TextFieldWithIcon(Icons.email, 'Email'),
                      const SizedBox(height: 10),
                      const TextFieldWithIcon(Icons.lock, 'Password'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to "Sign In" page
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              const Color(0XFF6096B4), // Change button color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // No border radius
                          ),
                        ),
                        child: SizedBox(
                          width: screenSize.width *
                              0.8, // Adjust button width based on screen width
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Sign Up",
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
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the login page
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundedIconButton(
                            Icons.facebook,
                            const Color(0XFF6096B4),
                          ),
                          SizedBox(width: 20),
                          RoundedIconButton(
                            FontAwesomeIcons.google,
                            const Color(0XFF6096B4),
                          ),
                          SizedBox(width: 20),
                          RoundedIconButton(
                            FontAwesomeIcons.twitter,
                            const Color(0XFF6096B4),
                          ),
                        ],
                      ),
                    ],
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

class TextFieldWithIcon extends StatelessWidget {
  final IconData icon;
  final String hintText;

  const TextFieldWithIcon(this.icon, this.hintText, {Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width *
          0.9, // Adjust the field width based on screen width
      decoration: BoxDecoration(
        color: const Color.fromARGB(184, 184, 210, 216),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Icon(icon),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const RoundedIconButton(this.icon, this.color, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
