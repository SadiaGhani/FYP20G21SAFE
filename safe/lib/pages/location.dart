import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationTrackingPage extends StatefulWidget {
  LocationTrackingPage({Key? key}) : super(key: key);

  @override
  _LocationTrackingPageState createState() => _LocationTrackingPageState();
}

class _LocationTrackingPageState extends State<LocationTrackingPage> {
  bool isTracking = false;
  // ignore: unused_field
  late StreamSubscription<Position> _positionStream;

  // Function to handle the start tracking action
  void startTracking() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return;
      }

      // Request permission to use location
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        print('Location permission denied');
        return;
      }

      // ignore: prefer_const_constructors
      _positionStream = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.best,
      ).listen((Position position) {
        print('Location update: ${position.latitude}, ${position.longitude}');
        // You can handle the location updates here
      });

      setState(() {
        isTracking = true;
      });

      print('Location tracking started!');
    } catch (e) {
      print('Error starting location tracking: $e');
    }
  }

  // Function to handle the stop tracking action
  void stopTracking() {
    // Stop location tracking
    Geolocator.getPositionStream().listen((Position position) {}).cancel();

    setState(() {
      isTracking = false;
    });

    print('Location tracking stopped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: Stack(
        children: [
          Positioned(
            left: -15,
            top: 0,
            child: Image.asset(
              'assets/upr_corner.png', // Replace with your own image
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            right: -15,
            top: 0,
            child: Image.asset(
              'assets/safe_logo.png', // Replace with your own image
              width: 130,
              height: 130,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: startTracking,
                child: const Text('Start Tracking'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isTracking ? stopTracking : null,
                child: const Text('Stop Tracking'),
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 280,
                  decoration: BoxDecoration(
                    color: const Color(0XFF93BFCF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Track your Location now',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -15,
            bottom: 0,
            child: Image.asset(
              'assets/btm_corner.png', // Replace with your own image
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
