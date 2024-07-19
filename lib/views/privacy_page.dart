import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool showProfilePicture = true;
  bool shareDataWithThirdParties = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Show Profile Picture'),
              value: showProfilePicture,
              onChanged: (value) {
                setState(() {
                  showProfilePicture = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Share Data with Third Parties'),
              value: shareDataWithThirdParties,
              onChanged: (value) {
                setState(() {
                  shareDataWithThirdParties = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
