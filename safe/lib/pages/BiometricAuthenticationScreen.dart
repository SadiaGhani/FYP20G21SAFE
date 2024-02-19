import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthenticationScreen extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<void> _authenticate(BuildContext context) async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await localAuth.authenticate(
        biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true,
        // On iOS, you can customize the error message using `localizedReason`
        localizedReason: '',
      );
    } catch (e) {
      print('Error: $e');
    }

    if (isAuthenticated) {
      // Authentication successful, navigate to the next screen
      Navigator.pushReplacementNamed(context, '/menu');
    } else {
      // Authentication failed, stay on the authentication screen or show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Authentication Failed'),
          content: Text('Authentication failed. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Authentication'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _authenticate(context),
          child: Text(''),
        ),
      ),
    );
  }
}
