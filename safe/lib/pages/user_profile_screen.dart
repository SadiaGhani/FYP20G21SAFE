import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
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
                    backgroundImage: AssetImage('assets/profile_pic.jpeg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bushra Farooq',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Software Engineer',
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
                      subtitle: Text('Bushra Farooq'),
                      onTap: () {
                        // Handle tile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Email'),
                      subtitle: Text('bushra69@gmail.com'),
                      onTap: () {
                        // Handle tile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Address'),
                      subtitle: Text('TajhBagh, Lahore'),
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
                      title: Text('Logout'),
                      subtitle: Text('see you again.!'),
                      onTap: () {
                        // Handle tile tap
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
