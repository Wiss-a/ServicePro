import 'package:flutter/material.dart';

class AdminNotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {'title': 'New User Registration', 'body': 'User John Doe registered.'},
    {'title': 'Service Update', 'body': 'Service A has been updated.'},
    {'title': 'Message Received', 'body': 'You have a new message from User X.'},
    {'title': 'System Alert', 'body': 'Scheduled maintenance at midnight.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Notifications'),
        backgroundColor: Colors.lime,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.lime),
              title: Text(notification['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(notification['body']!),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Handle delete notification logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notification deleted')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
