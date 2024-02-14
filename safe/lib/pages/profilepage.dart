import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class UserProfilePage extends StatelessWidget {
  final User user; // Assuming you have a User object

  UserProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              // You can add an image here if you have the user's profile picture
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${user.name}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to navigate to a screen for updating the user's profile
                // Example: Navigator.pushNamed(context, '/edit_profile');
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfilePage(
      user: User(name: 'John Doe', email: 'john@example.com'),
    ),
  ));
}
