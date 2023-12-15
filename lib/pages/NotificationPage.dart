import 'package:flutter/material.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Notifications',
          style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 24.0,
              ),
        ),
        // Customize the IconTheme for the back button
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.notifications,
              size: 100,
              color: Colors.blue, // Adjust the color as needed
            ),
            SizedBox(height: 20),
            Text(
              'This is the notification page!',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
