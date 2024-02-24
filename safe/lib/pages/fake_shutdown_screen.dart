import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'dart:io';


String url = Platform.isAndroid ? 'http://192.168.100.233:3000' : 'http://localhost:3000';
class FakeShutdownScreen extends StatefulWidget {
  const FakeShutdownScreen({Key? key}) : super(key: key);

  @override
  _FakeShutdownScreenState createState() => _FakeShutdownScreenState();
}

class _FakeShutdownScreenState extends State<FakeShutdownScreen> {
  bool isToggled = false;

 Future<void> _callNodeJsServerApi() async {
    try {
      print('${url}/api/fake-shutdown');
      // Replace 'YOUR_NODEJS_SERVER_API_URL' with the actual API URL
      final response = await http.get(Uri.parse('${url}/api/fake-shutdown'));
     
      // Handle the response here
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Show a prompt if the response is received
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Connection Established'),
            content: Text('The connection to the Node.js server is established.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle other status codes if needed
        print('Failed to connect to the Node.js server: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Error calling Node.js server API: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Positioned(
          //   top: 0,
          //   left: -10,
          //   child: Image.asset(
          //     'assets/upr_corner.png',
          //     width: 100,
          //     height: 100,
          //   ),
          // ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/safe_logo.png',
              width: 150,
              height: 150,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100), // Added padding
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Subheading
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Fake Shutdown',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  // Toggle Button
                  Switch(
                    value: isToggled,
                    onChanged: (value) {
                      setState(() {
                        isToggled = value;
                      });
                        if (isToggled) {
                        _callNodeJsServerApi();
                      }
                    },
                    activeColor: const Color(0XFF6096B4),
                  ),
                  
                  // Subheading when Toggle is On
                  if (isToggled)
                     
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Warning! Once you enable this button \n screen will go black in 5 seconds',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                      
                  
                  // Image
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset(
                      'assets/fks_alarm.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  
                  // Text Subheading and Number Field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          'Enter your code send on recovery email',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 250,
                          height: 30,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // hintText: 'Enter a number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
