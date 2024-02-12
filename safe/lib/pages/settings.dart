import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Add settings variables and logic here, e.g.,
  bool isNotificationsEnabled = true;
  String language = "English";
  bool isDarkModeEnabled = false;

  void updateSetting(String settingName, dynamic newValue) {
    // Update settings based on settingName and newValue
    setState(() {
      // Update corresponding state variables here
      if (settingName == "notifications") {
        isNotificationsEnabled = newValue;
      } else if (settingName == "language") {
        language = newValue;
      } else if (settingName == "darkMode") {
        isDarkModeEnabled = newValue;
      }
      // ... handle other settings
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEEE9DA),
      body: Stack(
        children: [
          // ... (existing code, if applicable)

          Center(
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                color: Color(0XFF93BFCF),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Add setting options here, e.g.,
                  ListTile(
                    title: Text('Notifications'),
                    trailing: Switch(
                      value: isNotificationsEnabled,
                      onChanged: (value) =>
                          updateSetting("notifications", value),
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: Text('Language'),
                    trailing: DropdownButton<String>(
                      value: language,
                      items: const [
                        DropdownMenuItem(
                          value: "English",
                          child: Text("English"),
                        ),
                        DropdownMenuItem(
                          value: "Spanish",
                          child: Text("Spanish"),
                        ),
                        // ... add other languages
                      ],
                      onChanged: (value) => updateSetting("language", value),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: Text('Dark Mode'),
                    trailing: Switch(
                      value: isDarkModeEnabled,
                      onChanged: (value) => updateSetting("darkMode", value),
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                  // ... add more settings options
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
