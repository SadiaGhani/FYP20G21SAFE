import 'package:flutter/material.dart';

class RemoteWipeScreen extends StatefulWidget {
  const RemoteWipeScreen({Key? key}) : super(key: key);

  @override
  _RemoteWipeScreenState createState() => _RemoteWipeScreenState();
}

class _RemoteWipeScreenState extends State<RemoteWipeScreen> {
  bool isToggled = false;

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
                      'Remote Wipe',
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
                    },
                    activeColor: const Color(0XFF6096B4),
                  ),

                  // Subheading when Toggle is On
                  if (isToggled)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Warning! Once you enable this button \n your data will be wiped from this device',
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
