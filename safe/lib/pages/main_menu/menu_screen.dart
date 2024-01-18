import 'package:flutter/material.dart';

import 'drawer.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: Stack(
        children: <Widget>[
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
            top: 0,
            child: Image.asset(
              'assets/safe_logo.png',
              width: 130,
              height: 130,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          ' Secure your\nandroid device\nnow by safe',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Positioned(
                          child: Image.asset(
                            'assets/welcome.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: screenSize.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/uploadfiles');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0XFF6096B4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FractionallySizedBox(
                                widthFactor: 0.6,
                                child: Image.asset(
                                  'assets/upfile.png',
                                  height: 80,
                                ),
                              ),
                              const Text(
                                'Upload Files',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0XFF6096B4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FractionallySizedBox(
                              widthFactor: 0.6,
                              child: Image.asset(
                                'assets/dlost.png',
                                height: 80,
                              ),
                            ),
                            const Text(
                              'Device lost',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0XFF6096B4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FractionallySizedBox(
                              widthFactor: 0.6,
                              child: Image.asset(
                                'assets/raccess.png',
                                height: 80,
                              ),
                            ),
                            const Text(
                              'Remote Access',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0XFF6096B4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FractionallySizedBox(
                              widthFactor: 0.6,
                              child: Image.asset(
                                'assets/intruder.png',
                                height: 80,
                              ),
                            ),
                            const Text(
                              'Intruder Alert',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/alarms');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0XFF6096B4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FractionallySizedBox(
                                widthFactor: 0.6,
                                child: Image.asset(
                                  'assets/malarm.png', // Add the path to your alarms image
                                  height: 80,
                                ),
                              ),
                              const Text(
                                'Alarms',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/location');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0XFF6096B4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FractionallySizedBox(
                                widthFactor: 0.6,
                                child: Image.asset(
                                  'assets/location.png', // Add the path to your location tracking image
                                  height: 80,
                                ),
                              ),
                              const Text(
                                'Location Tracking',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 100,
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
