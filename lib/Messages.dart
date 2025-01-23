// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'Profile.dart';
import 'Notifications.dart';
import 'Menu.dart';
import 'homePage.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text('Messages'),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildMessageTile(
                sender: 'Elon',
                message:
                    "Can you confirm the repair service tomorrow at 10 am?",
                function: () {
                  print('Hello');
                }),
            _buildMessageTile(
                sender: 'Ali',
                message:
                    "Your reservation is confirmed. I'll arrive at the address on time.",
                function: () {
                  print('Hello');
                }),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home Button
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    icon: Icon(Icons.home),
                    tooltip: 'Home',
                  ),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
              // Chat Button
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Messages()),
                      );
                    },
                    icon: Icon(Icons.message),
                    tooltip: 'Chat',
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
              // Notifications Button
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()),
                      );
                    },
                    icon: Icon(Icons.notifications),
                    tooltip: 'Notifications',
                  ),
                  Text(
                    'Notifications',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
              // Profile Button
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );                  },
                    icon: Icon(Icons.person),
                    tooltip: 'Profile',
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ],
          ),
        ), // Messages tab
      ),
    );
  }

  Widget _buildMessageTile(
      {required String sender,
      required String message,
      required VoidCallback function}) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          sender,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
        leading: Icon(Icons.person),
        onTap: function,
      ),
    );
  }
}
