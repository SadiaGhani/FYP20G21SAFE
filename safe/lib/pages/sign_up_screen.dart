import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignupScreen extends StatelessWidget {
  //const SignupScreen({Key? key});

  // googleLogin() async {
  //   print("Google Login function");
  //   GoogleSignIn _googleSignIn = GoogleSignIn( 
  //     clientId: '36466737574-dut5h5ale50o89sn861i1hrpkcklk0bk.apps.googleusercontent.com',
  //   );
  //   try {
  //   var result = await _googleSignIn.signIn();
  //   print(result);
  // } catch (error) {
  //   print(error);
  // }

  

  Future<bool> googleLogin() async {
  print("Google Login functioneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '36466737574-dut5h5ale50o89sn861i1hrpkcklk0bk.apps.googleusercontent.com',
    
  );

  try {
    var result = await _googleSignIn.signIn();

    if (result != null) {
      // navigator();
      print(" i am in trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(result);
      return true;
    } else {
      // User canceled the Google sign-in
      return false;
    }
  } catch (error) {
    // Handle any errors during the sign-in process
    print(" i am in errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    print(error);
    return false;
  }
}



void signUpWithEmailAndPassword(String email, String password, BuildContext context) {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) {
        // Account creation successful
        _showConfirmationDialog(context);
      })
      .catchError((error) {
        // Account creation failed
        print("Error: ${error.toString()}");
        // You may want to display an error message to the user
      });
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Account Created'),
        content: Text('Your account has been created successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushNamed(context, '/menu'); // Navigate to the menu page
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}




 void showAlertDialog(BuildContext context, String title, String message) {
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

  bool isValidPhoneNumber(String phoneNumber) {
  // Implement your phone number validation logic. This is a basic example.
  // You might want to use regular expressions or other methods for more robust validation.
  return phoneNumber.length == 11 && phoneNumber.startsWith('0');
  }


  bool isValidPassword(String password) {
  // Basic check for a minimum length of the password. You can customize this based on your requirements.
  return password.length >= 6;
  }

  bool isValidEmail(String email) {
  // Basic check for a valid email address using a simple regular expression.
  // You might want to use a more sophisticated email validation library.
  final emailRegExp = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  return emailRegExp.hasMatch(email);
  }

  bool isValidName(String value) {
  // Basic check for alphabets only. You can customize this based on your requirements.
  final RegExp alphaRegExp = RegExp(r'^[a-zA-Z ]+$');
  return alphaRegExp.hasMatch(value);
}




  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


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
                      
                      TextFieldWithIcon(Icons.account_circle, 'Name', nameController),
                      const SizedBox(height: 10),
                      TextFieldWithIcon(Icons.phone, 'Phone Number', phoneNumberController),
                      const SizedBox(height: 10),
                      TextFieldWithIcon(FontAwesomeIcons.addressBook, 'Address', addressController),
                      const SizedBox(height: 10),
                      TextFieldWithIcon(Icons.email, 'Email', emailController),
                      const SizedBox(height: 10),
                      TextFieldWithIcon(Icons.lock, 'Password', passwordController, obscureText: true),
                      const SizedBox(height: 10),
                      TextFieldWithIcon(Icons.lock, 'Confirm Password', confirmPasswordController, obscureText: true),

                      ElevatedButton(
                        
                        onPressed: () {
                          String name = nameController.text;
                          String phoneNumber = phoneNumberController.text;
                          String address = addressController.text;
                          String email = emailController.text;
                          String password = passwordController.text;
                          String confirmPassword = confirmPasswordController.text;
                          
                          if (name.isEmpty || phoneNumber.isEmpty || address.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                            String title = "All Feilds are required";
                            String msg = "Please fill out all the asked information";
                            showAlertDialog(context,title,msg);
                            } else if (!isValidName(name)) {
                            String title = "Invalid Name";
                            String msg = "Your name should contains only alphabets";
                            showAlertDialog(context,title,msg);
                            }
                            else if (!isValidEmail(email)) {
                            String title = "Invalid Email";
                            String msg = "Please enter a Valid Email Address";
                            showAlertDialog(context,title,msg);
                            }  
                            else if (!isValidPhoneNumber(phoneNumber)) {
                            String title = "Invalid Phone Number";
                            String msg = "Please Enter the Valid phone Number of 11 digits";
                            showAlertDialog(context,title,msg);
                            } else if (!isValidPassword(password)) {
                            String title = "Password Error";
                            String msg = "You Password should be at least6 character long and contains atleast 1 Special Character";
                            showAlertDialog(context,title,msg);
                            } 
                            else if (password != confirmPassword) {
                            String title = "Password Mismatch error";
                            String msg = "Your Password and Confirm Password did not Match";
                            showAlertDialog(context,title,msg);
                            } 
                            else {
                            // All data is valid, proceed with sign-up
                            signUpWithEmailAndPassword(email, password, context);
                            }
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
                      ElevatedButton(
                        onPressed: () async {
                          print("I am in Google button");

                          bool loginSuccess = await googleLogin();

                          if (loginSuccess) {
                          // Navigate to "Sign In" page only if Google login was successful
                          Navigator.pushNamed(context, '/menu');
                         }
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
                              "Sign Up With Google",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // const Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     RoundedIconButton(
                      //       Icons.facebook,
                      //       const Color(0XFF6096B4),
                      //     ),
                      //     SizedBox(width: 20),
                      //     RoundedIconButton(
                      //       FontAwesomeIcons.google,
                      //       const Color(0XFF6096B4),
                            
                      //     ),
                      //     SizedBox(width: 20),
                      //     RoundedIconButton(
                      //       FontAwesomeIcons.twitter,
                      //       const Color(0XFF6096B4),
                      //     ),
                      //   ],
                      // ),
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
  final TextEditingController controller;
  final bool obscureText;

  const TextFieldWithIcon(this.icon, this.hintText, this.controller, {this.obscureText = false});

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
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $hintText';
                  }
                  // You can add more specific validation logic here if needed
                  return null;
                },
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




//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: const Color(0XFFEEE9DA), // Background color
//       body: Center(
//         // Center the entire content
//         child: Stack(
//           children: <Widget>[
//             // Image in top-left corner
//             Positioned(
//               left: -15,
//               top: 0,
//               child: Image.asset(
//                 'assets/upr_corner.png',
//                 width: 100,
//                 height: 100,
//               ),
//             ),
//             Positioned(
//               right: -15,
//               top: -30,
//               child: Image.asset(
//                 'assets/safe_logo.png',
//                 width: 150,
//                 height: 150,
//               ),
//             ),
//             Positioned(
//               right: -15,
//               bottom: 0,
//               child: Image.asset(
//                 'assets/btm_corner.png',
//                 width: 100,
//                 height: 100,
//               ),
//             ),

//             Column(
//               mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//               crossAxisAlignment:
//                   CrossAxisAlignment.center, // Center horizontally
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.center, // Center horizontally
//                     children: <Widget>[
//                       const Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 0, 0, 0), // Text color
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Center(
//                         child: Image.asset(
//                           'assets/signup.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                       ),
//                       // const SizedBox(height: 10),
//                       // const TextFieldWithIcon(Icons.account_circle, 'Name'),
//                       // const SizedBox(height: 10),
//                       //  const TextFieldWithIcon(Icons.phone, 'Phone Number'),
//                       // const SizedBox(height: 10),
//                       //  const TextFieldWithIcon(FontAwesomeIcons.addressBook, 'Address'),
//                       // const SizedBox(height: 10),
//                       // const TextFieldWithIcon(Icons.email, 'Email'),
//                       // const SizedBox(height: 10),
//                       // const TextFieldWithIcon(Icons.lock, 'Password'),
//                       // const SizedBox(height: 10),
//                       // const SizedBox(height: 10),
                         
//                          //TextFieldWithIcon(Icons.account_circle, 'Name', nameController),
// //                       TextFieldWithIcon(Icons.phone, 'Phone Number', phoneNumberController),
// //                       const SizedBox(height: 10),
// //                       TextFieldWithIcon(FontAwesomeIcons.addressBook, 'Address', addressController),
// //                       const SizedBox(height: 10),
// //                       TextFieldWithIcon(Icons.email, 'Email', emailController),
// //                       const SizedBox(height: 10),
// //                       TextFieldWithIcon(Icons.lock, 'Password', passwordController, obscureText: true),
// //                       const SizedBox(height: 10),
// //                       TextFieldWithIcon(Icons.lock, 'Confirm Password', confirmPasswordController, obscureText: true),
//                       // TextFieldWithIcon(Icons.account_circle, 'Name', nameController),
//                       // const SizedBox(height: 10),
//                       // TextFieldWithIcon(Icons.phone, 'Phone Number', phoneNumberController),
//                       // const SizedBox(height: 10),
//                       // TextFieldWithIcon(FontAwesomeIcons.addressBook, 'Address', addressController),
//                       // const SizedBox(height: 10),
//                       // TextFieldWithIcon(Icons.email, 'Email', emailController),
//                       // const SizedBox(height: 10),
//                       // TextFieldWithIcon(Icons.lock, 'Password', passwordController, obscureText: true),
//                       // const SizedBox(height: 10),
//                       // TextFieldWithIcon(Icons.lock, 'Confirm Password', confirmPasswordController, obscureText: true),
//                       ElevatedButton(
//                       onPressed: () {

//                           //FirebaseAuth.instance.createUserWithEmailAndPassword(email: Email, password: password)
//                           // Navigate to "Main Menu" Page
//                           Navigator.pushNamed(context, '/menu');
//                         },
                          
//                         style: ElevatedButton.styleFrom(
//                           primary:
//                               const Color(0XFF6096B4), // Change button color
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(20), // No border radius
//                           ),
//                         ),
//                         child: SizedBox(
//                           width: screenSize.width *
//                               0.8, // Adjust button width based on screen width
//                           child: const Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Sign Up",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           const Text(
//                             "Already have an account? ",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               // Navigate to the login page
//                               Navigator.pushNamed(context, '/login');
//                             },
//                             child: const Text(
//                               "Sign In",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           print("I am in Google buttonnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");

//                           bool loginSuccess = await googleLogin();

//                           if (loginSuccess) {
//                          // Navigate to "Sign In" page only if Google login was successful
//                           print("i am in ifffffffffffffffffffffffffffffffffffffffff");
//                           Navigator.pushNamed(context, '/login');
//                           }
//                         },
                          
//                         style: ElevatedButton.styleFrom(
//                           primary:
//                               const Color(0XFF6096B4), // Change button color
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(20), // No border radius
//                           ),
//                         ),
//                         child: SizedBox(
//                           width: screenSize.width *
//                               0.8, // Adjust button width based on screen width
//                           child: const Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Sign Up With Google",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // const SizedBox(height: 20),
//                       // const Row(
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: <Widget>[
//                       //     RoundedIconButton(
//                       //       Icons.facebook,
//                       //       const Color(0XFF6096B4),
//                       //     ),
//                       //     SizedBox(width: 20),
//                       //     RoundedIconButton(
//                       //       FontAwesomeIcons.google,
//                       //       const Color(0XFF6096B4),
                            
//                       //     ),
//                       //     SizedBox(width: 20),
//                       //     RoundedIconButton(
//                       //       FontAwesomeIcons.twitter,
//                       //       const Color(0XFF6096B4),
//                       //     ),
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TextFieldWithIcon extends StatelessWidget {
//   final IconData icon;
//   final String hintText;

//   const TextFieldWithIcon(this.icon, this.hintText, {Key? key});

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     return Container(
//       width: screenSize.width *
//           0.9, // Adjust the field width based on screen width
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(184, 184, 210, 216),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Row(
//           children: <Widget>[
//             Icon(icon),
//             const SizedBox(width: 10),
//             Expanded(
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: hintText,
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoundedIconButton extends StatelessWidget {
//   final IconData icon;
//   final Color color;

//   const RoundedIconButton(this.icon, this.color, {Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: Icon(
//           icon,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
