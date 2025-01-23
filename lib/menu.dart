import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'Contact_us.dart';
import 'Joinus.dart';
import 'LoginForm.dart';
import 'Messages.dart';
import 'Profile.dart';
import 'homePage.dart';
import 'Notifications.dart';

import 'custom_drawer.dart';
class MenuPage extends StatefulWidget {
@override
MenuPageState createState() => MenuPageState();

}

class MenuPageState extends State<MenuPage>{
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
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête du Drawer
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lime,            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu', // Remplacez par le titre souhaité
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Couleur du texte
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],

            ),
          ),
          // Liste des éléments du menu
          Expanded(
          child: Container(
            color: Color(0xFFFDFDFD),
            child: ListView(

              children: [
                _buildMenuItem(
                  icon: Ionicons.home,
                  title: 'Home',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),

                    );
                  },
                ),
                _buildMenuItem(
                  icon: Ionicons.person,
                  title: 'My Profile',
                  onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),

                  );},

                ),
                _buildMenuItem(
                  icon: Ionicons.mail,
                  title: 'Contact us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUsPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Ionicons.briefcase,
                  title: 'Become a worker',
                  onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Joinus(),
                    ),
                  );},
                ),

                Divider(),
                _buildMenuItem(
                  icon: Ionicons.notifications,
                  title: 'Notification',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Ionicons.chatbox,
                  title: 'Messages',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Messages(),
                      ),
                    );
                  },
                ),
                Divider(),
                _buildMenuItem(
                  icon: Ionicons.log_out,
                  title: 'Logout',
                  onTap: () {
                    logout(context);
                  },
                ),
              ],
            ),
          ),
          ),
        ],

      ),

    );
  }

    Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? backgroundColor,
    Color? iconColor,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white, // Couleur de fond par défaut
          borderRadius: BorderRadius.circular(0),

        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Colors.black),
            // Couleur de l'icône par défaut
            SizedBox(width: 16.0),
            Text(
              title,
              style: TextStyle(
                color: textColor ?? Colors.black, // Couleur du texte par défaut
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }}


  void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('ServicePro'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Content goes here'),
      ),
    ),
  ));
}
