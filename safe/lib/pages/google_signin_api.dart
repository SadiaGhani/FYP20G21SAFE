import 'package:google_sign_in/google_sign_in.dart';
class GoogleSignInApi {
     static final _googleSignIn = GoogleSignIn();
     static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
     static Future logout() => _googleSignIn.disconnect();
}
//import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInApi {
//   static final _googleSignIn = GoogleSignIn();

//   // Perform Google Sign-In
//   static Future<GoogleSignInAccount?> login() async {
//     try {
//       // Attempt to sign in
//       return await _googleSignIn.signIn();
//     } catch (error) {
//       // Handle potential sign-in errors
//       print("Google Sign-In Error: $error");
//       return null;
//     }
//   }
///}
