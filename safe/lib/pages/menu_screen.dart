import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package: google_signin_api.dart';
import 'sign_up_screen.dart';

class MenuPage extends StatelessWidget {
  // final String name;
  // final String email;
  // final String picture;

  // MenuPage({required this.name, required this.email, required this.picture, required Type userProfileScreen});
  //final GoogleSignInAccount user;

  //MenuPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Sidebar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle home option
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings option
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Handle about option
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          const MenuOption(
            icon: Icons.arrow_forward,
            heading: 'Option 1',
            text: 'Description for Option 1',
          ),
          const MenuOption(
            icon: Icons.arrow_forward,
            heading: 'Option 2',
            text: 'Description for Option 2',
          ),
          const MenuOption(
            icon: Icons.arrow_forward,
            heading: 'Option 3',
            text: 'Description for Option 3',
          ),
          const MenuOption(
            icon: Icons.arrow_forward,
            heading: 'Option 4',
            text: 'Description for Option 4',
          ),
          const MenuOption(
            icon: Icons.arrow_forward,
            heading: 'Option 5',
            text: 'Description for Option 5',
          ),
        ],
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String text;

  const MenuOption({
    required this.icon,
    required this.heading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(heading),
      subtitle: Text(text),
      onTap: () {
        // Handle tap on menu option
      },
    );
  }
}
