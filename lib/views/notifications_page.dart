import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool pushNotifications = true; // FCM Firebase Cloud Messaging
  bool emailNotifications = false; // requires smtp configuration
  bool smsNotifications = true; // requires 3rd party api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Settings'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Push Notifications'),
              value: pushNotifications,
              onChanged: (value) {
                setState(() {
                  pushNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Email Notifications'),
              value: emailNotifications,
              onChanged: (value) {
                setState(() {
                  emailNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('SMS Notifications'),
              value: smsNotifications,
              onChanged: (value) {
                setState(() {
                  smsNotifications = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
