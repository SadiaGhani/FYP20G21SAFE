import 'package:flutter/material.dart';

class DeviceGotLostScreen extends StatelessWidget {
  const DeviceGotLostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0XFFEEE9DA),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Blue Background Container with Rounded Tabs
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: const Color(0XFF6096B4),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                    bottom: Radius.circular(20), // Added bottom border radius
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align heading to the left
                  children: <Widget>[
                    // Main Heading
                    Text(
                      'DEVICE GOT LOST',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Tabs
                    TabBar(
                      indicatorColor: const Color(0XFFEEE9DA),
                      tabs: <Widget>[
                        Tab(text: 'Remote Wipe'),
                        Tab(text: 'Remote Access'),
                        Tab(text: 'Location Tracking'),
                        Tab(text: 'Alarms'),
                        Tab(text: 'Fake Shutdown'),
                      ],
                    ),

                    // TabBarView
                    Container(
                      height: MediaQuery.of(context).size.height - 220,
                      child: TabBarView(
                        children: <Widget>[
                          buildTabContent('Remote Wipe'),
                          buildTabContent('Remote Access'),
                          buildTabContent('Location Tracking'),
                          buildTabContent('Alarms'),
                          buildTabContent('Fake Shutdown'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabContent(String text) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
