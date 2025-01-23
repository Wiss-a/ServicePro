import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'edit_profile.dart';
import 'forward_button.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ServicePro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Ionicons.chevron_back_outline),
          color: Colors.grey.shade300,
        ),
        elevation: 5, // Adds depth to the app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white54],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                _buildProfileCard(),
                const SizedBox(height: 20),
                _buildMenuItem(
                  title: 'Become a Provider',
                  icon: Ionicons.briefcase_outline,
                  //bgColor: Colors.grey.shade700,
                  bgColor: Colors.white60,

                  iconColor: Colors.black,
                  textColor: Colors.black,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  title: 'Contact Us',
                  icon: Ionicons.body,
                  //bgColor: Colors.brown.shade100,
                  bgColor: Colors.white60,

                  iconColor: Colors.brown,
                  textColor: Colors.brown.shade800,
                  onTap: () {},
                ),

                const SizedBox(height: 20),
                _buildMenuItem(
                  title: 'Share',
                  icon: Ionicons.share,
                  //bgColor: Colors.blueGrey,
                  bgColor: Colors.white60,

                  iconColor: Colors.black,
                  textColor: Colors.black,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  title: 'Rate',
                  icon: Ionicons.star,
                  //bgColor: Colors.grey.shade600,
                  bgColor: Colors.white60,

                  iconColor: Colors.black,
                  textColor: Colors.black,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  title: 'Log Out',
                  icon: Ionicons.log_out,
                  //bgColor: Colors.grey.shade800,
                  bgColor: Colors.white60,

                  iconColor: Colors.redAccent,
                  textColor: Colors.black,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/avatar.jpg'),
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Edit your profile details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Ionicons.chevron_forward_outline,
            color: Colors.grey.shade300,
          ),
          ForwardButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsUI(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          //borderRadius: BorderRadius.circular(15),


        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: iconColor.withOpacity(0.2),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const Spacer(),
            Icon(
              Ionicons.chevron_forward_outline,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
