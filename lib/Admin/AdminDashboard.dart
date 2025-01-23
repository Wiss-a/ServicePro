import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../LoginForm.dart';
import 'UserManagementScreen.dart';
import 'ServiceManagementScreen.dart';
import 'AdminMessagesScreen.dart';
import 'AdminNotificationScreen.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}
final FirebaseAuth _auth = FirebaseAuth.instance;

void logout(BuildContext context) async {
  try {
    await _auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You\'ve been logged out!')),
    );
    // Navigate to the login screen after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginForm()),
    );
  } catch (e) {
    print('Error during logout: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error during logout!')),
    );
  }
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  // Screens for bottom navigation
  final List<Widget> _screens = [
    UserManagementScreen(),
    ServiceManagementScreen(),
    AdminMessagesScreen(),
    AdminNotificationScreen(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lime),
              child: Text(
                'Admin Menu',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('User Management'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 0; // Redirect to User Management
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('Service Management'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 1; // Redirect to Service Management
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminNotificationScreen()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex], // Show the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
