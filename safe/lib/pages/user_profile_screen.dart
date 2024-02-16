//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:safe/pages/google_signin_api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<void> fetchData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final name = prefs.getString('name');
//   final email = prefs.getString('email');
//   final picture = prefs.getString('picture');

//   // Now you can use the retrieved data as needed.
//   print('Name: $name, Email: $email, Picture: $picture');
// import 'package:shared_preferences/shared_preferences.dart';

// class UserData {
//   final String name;
//   final String email;
//   final String picture;

//   UserData({
//     required this.name,
//     required this.email,
//     required this.picture,
//   });
  
// }

// Future<UserData> fetchData() async {
//   print("i am fectcccccccccccccccccccccccccccccccc");
//   final prefs = await SharedPreferences.getInstance();
//   final name = prefs.getString('name') ?? '';
//   final email = prefs.getString('email') ?? '';
//   final picture = prefs.getString('picture') ?? '';
//   print('Name: $name, Email: $email, Picture: $picture');
//   return UserData(name: name, email: email, picture: picture);
// }

class UserProfileScreen extends StatelessWidget {
  

  final String name;
  final String email;
  final String picture;
  final VoidCallback onNavigateToMenu;

  UserProfileScreen({required this.name, required this.email, required this.picture, VoidCallback? onNavigateToMenu})
      : onNavigateToMenu = onNavigateToMenu ?? (() {});  // Provide a default empty function if not provided
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6096B4), // Set the background color of the upper half to blue
      body: Column(
        children: [
          // Upper half with profile photo
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(picture),
                  ),
                  SizedBox(height: 10),
                   Text(
                     "Welcome",
                     style: TextStyle(
                     color: Colors.white,
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                      ),
                      ),
                  Text( 
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                     email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Lower half with tiles
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFFEEE9DA), // Set the background color of the lower half to match previous screens
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'User Profile',
                        style: TextStyle(
                          color: Colors.black, // Text color changed to black
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Add your tiles with heading, subheading, and icon here
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Name'),
                      subtitle: Text(name),
                      onTap: () {
                        // Handle tile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Email'),
                      subtitle: Text(email),
                      onTap: () {
                        // Handle tile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Address'),
                      subtitle: Text('Lahore, Pakistan'),
                      onTap: () {
                        // Handle tile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Package'),
                      subtitle: Text('Premium'),
                      onTap: () {
                        // Handle tile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout_outlined),
                      title: Text('Remove Google Account'),
                      subtitle: Text('see you again.!'),
                      onTap: () async{
                        try{
                        await GoogleSignInApi.logout();
                        print("User signed out successfully from Google");
                        Navigator.pushNamed(context, '/signup');
                        } catch (e) {
                         print("Error signing out: $e");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// void main(context) async {
//   // Assuming this is in an asynchronous function or a Flutter widget method

//   try {
//     UserData userData = await fetchData();
//     print("hyeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
//     // Now you can use the userData as needed
//     print('Name: ${userData.name}, Email: ${userData.email}, Picture: ${userData.picture}');

//     // You can navigate to the UserProfileScreen and pass the userData
//     Navigator.of(context).pushNamed('/userprofile', arguments: userData);

//   } catch (error) {
//     print('Erroryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy fetching user data: $error');
//     // Handle the error as needed
//   }
// }
