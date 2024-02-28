import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ImageFromPathScreen extends StatefulWidget {
  @override
  _ImageFromPathScreenState createState() => _ImageFromPathScreenState();
}

class _ImageFromPathScreenState extends State<ImageFromPathScreen> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    loadImagePath();
  }

  // Function to load the image path from shared preferences
  Future<void> loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('capturedImagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image From Path'),
      ),
      body: Center(
        child: _imagePath != null
            ? Image.file(
                File(_imagePath!),
                fit: BoxFit.cover,
              )
            : Text('Image not found'),
      ),
    );
  }
}
