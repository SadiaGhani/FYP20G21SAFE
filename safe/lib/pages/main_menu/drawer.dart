import 'package:flutter/material.dart';
import 'package:safe/pages/awarness.dart';
import 'package:safe/pages/sign_up_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe/pages/google_signin_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:safe/pages/sign_up_screen.dart';
import 'package:safe/pages/user_profile_screen.dart';


Future<void> signOut(context) async {
  bool isGoogleUser = await GoogleSignIn().isSignedIn();
  try {
    //bool isGoogleUser = await checkGoogleSignInStatus();
    if (isGoogleUser) {
       try {
        await FirebaseAuth.instance.signOut();
                 print("User signed out successfully usignemail and password");
                 Navigator.pushNamed(context, '/signup');
                 } catch (e) {
                  print("Error signing out: $e");
                }
      
    } else {
      
      try {
        await GoogleSignInApi.logout();
                 print("User signed out successfully from Google");
                 Navigator.pushNamed(context, '/signup');
                 } catch (e) {
                  print("Error signing out: $e");
                }
      //Navigator.pushNamed(context, '/signup');
    }
  } catch (e) {
    print("Error signing out: $e");
  }
 
}






class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 251, 251, 251),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0XFF6096B4),
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(20), // Adjust the radius as needed
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20), // Adjust the radius as needed
                  topRight: Radius.circular(20), // Adjust the radius as needed
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User profile image or icon
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/user.jpg'), // Replace with the actual user image
                    radius: 30, // Adjust the radius as needed
                  ),
                  SizedBox(
                      height:
                          10), // Add some spacing between the image and user name
                  Text(
                    'User Name', // Replace with the user's name
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'user123@example.com', // Replace with the user's email or other info
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
             onTap: () async {
               //Navigator.pushNamed(context, '/userprofile');
               final user = await GoogleSignInApi.login();
               String name = user?.displayName ?? "N/A";
                String email = user?.email ?? "N/A";
               String picture = user?.photoUrl ?? "N/A";
              Navigator.push(
             context,
             MaterialPageRoute(
        builder: (context) => UserProfileScreen(
          name: name,
          email: email,
          picture: picture,
        ),
      ),
    );
  // Handle home option
  // final user = await signIn();  // Assuming signIn returns user data
  // Navigator.pushNamed(
  //   context,
  //   '/userprofile',
  //   arguments: {
  //     'name': user.displayName ?? "N/A",
  //     'email': user.email ?? "N/A",
  //     'picture': user.photoUrl ?? "N/A",
  //   },
  // );
},
            ),
            ListTile(
              leading: const Icon(
                Icons.notification_important,
                color: Colors.black,
              ),
              title: const Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/notifications');
                // Handle about option
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
                // Handle settings option
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shield,
                color: Colors.black,
              ),
              title: const Text(
                'Cyber Security Awarness',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/awarness');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: const Text(
                'Help and support',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/contactus');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.security,
                color: Colors.black,
              ),
              title: const Text(
                'Intruder Alert',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/intruder_alert');
                // Handle about option
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                await GoogleSignInApi.logout();
                print("Logout Successful");

                // After successful logout, navigate back to the sign-up page
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      SignupScreen(), // Replace SignUpPage with your actual sign-up page
                ));
                //signOut(context);
                try {
                await FirebaseAuth.instance.signOut();
                print("User signed out successfully");
                Navigator.pushNamed(context, '/signup');
               } catch (e) {
               print("Error signing out: $e");
               }
              //  try{
              //  await GoogleSignInApi.logout();
              //    print("User signed out successfully from Google");
              //    Navigator.pushNamed(context, '/signup');
              //    } catch (e) {
              //     print("Error signing out: $e");
              //   }
              },
            ),
          ],
        ),
      ),
    );
  }
}
