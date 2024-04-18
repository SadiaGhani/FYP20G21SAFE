import 'package:flutter/material.dart';
import 'package:safe/pages/alarms.dart';
import 'package:safe/pages/fake_shutdown_screen.dart';
import 'package:safe/pages/location.dart';
import 'package:safe/pages/remoteWipeScreen.dart';

class DeviceGotLostScreen extends StatelessWidget {
  const DeviceGotLostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0XFF6096B4),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align heading to the left
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
                      isScrollable: true, // Make tabs scrollable
                      tabs: <Widget>[
                      
                       
                        buildTab(context, 'Location'),
                        buildTab(context, 'Alarms'),
                        buildTab(context, 'Shutdown'),
                      ],
                    ),

                    // TabBarView
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          // RemoteWipeScreen(),
                          LocationTrackingPage(),
                          AlarmsPage(),
                          FakeShutdownScreen(),
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

  Widget buildTab(BuildContext context, String text) {
    return Tab(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width /
              5, // Adjust based on the number of tabs
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
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
