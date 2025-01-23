import 'package:flutter/material.dart';

import 'chatbox.dart';
import 'homePage.dart';
import 'notification.dart';

class EditProfile2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share action
            },
          ),
        ],
        backgroundColor: Colors.brown, // Set app bar color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/icon3.png'), // Replace with your image asset
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          // Change picture action
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Change Picture',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              SizedBox(height: 20),

              // Form Fields
              buildTextField('Username', 'yANCHUI'),
              SizedBox(height: 16),
              buildTextField('Email I’d', 'yanchui@gmail.com'),
              SizedBox(height: 16),
              buildTextField('Phone Number', '+14987889999'),
              SizedBox(height: 16),
              buildTextField('Password', 'evFTbyVVCd', isPassword: true),
              SizedBox(height: 30),

              // Update Button
              ElevatedButton(
                onPressed: () {
                  // Update action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
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
                      MaterialPageRoute(builder: (context) => Chat()),
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
                      MaterialPageRoute(builder: (context) => NotificationPage()),
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
                    Navigator.push;
                  },
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
      ),
    );
  }

  Widget buildTextField(String label, String placeholder, {bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
