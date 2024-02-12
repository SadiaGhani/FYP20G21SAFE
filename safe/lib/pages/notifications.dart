import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Add notification data and logic here, e.g.,
  List<Notification> notifications = [
    // ... populate with notification objects
  ];

  void dismissNotification(Notification notification) {
    // Remove notification from data and update UI
    setState(() {
      notifications.remove(notification);
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
                    'Notifications',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Display notifications in a list view
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return ListTile(
                          title: Text(notification.title),
                          subtitle: Text(notification.body),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => dismissNotification(notification),
                          ),
                        );
                      },
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

class Notification {
  final String title;
  final String body;

  Notification(this.title, this.body);
}
