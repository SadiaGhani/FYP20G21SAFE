import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationTrackingPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationTrackingPage> {
  String? _latitude;
  String? _longitude;

  // Function to get the current location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      appBar: AppBar(
        title: Text('Location Tracking'),
        backgroundColor: const Color(0XFF93BFCF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Get Current Location'),
            ),
            SizedBox(height: 16),
            if (_latitude != null && _longitude != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Location:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.location_on),
                    Text(
                      'Latitude: $_latitude',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.location_on),
                    Text(
                      'Longitude: $_longitude',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
