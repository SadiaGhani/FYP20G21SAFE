import 'package:flutter/material.dart';

class TileList extends StatefulWidget {
  @override
  _TileListState createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  List<bool> switchValues = [false, false, false, false, false, false];

  final List<String> headings = [
    "Fake Shutdown",
    "Remote Wipe",
    "Track Location",
    "Alarm",
    "Device Lost",
    "Secure Sharing",
  ];

  final List<String> subheadings = [
    "Shuts down the device",
    "Wipe your device data",
    "Track location of your device",
    "Play sounds on your device",
    "Click to see features",
    "Share your data safely",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset('icons/image$index.jpg'), // Use images
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headings[index],
                style: TextStyle(
                  fontSize: 18.0, // Adjust the font size for heading text
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subheadings[index],
                style: TextStyle(
                  fontSize: 14.0, // Adjust the font size for subheading text
                ),
              ),
            ],
          ),
          trailing: Switch(
            value: switchValues[index],
            onChanged: (bool value) {
              setState(() {
                switchValues[index] = value;
              });
            },
          ),
        );
      },
    );
  }
}
