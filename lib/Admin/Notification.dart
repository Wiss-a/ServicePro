// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'AdminHomePage.dart';
import 'Messages.dart';
import 'Profile.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  // Track the index of the selected bottom navigation item
  int _selectedIndex = 2;

  // Function to handle item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotificationPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Messages()),
      );
    }
  }

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
          title: Text('Notifications'),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            NotificationCard(
              title: "Abonnement",
              content:
                  "Votre abonnement arrive à expiration dans 3 jours. Renouvelez-le pour continuer à accéder aux services.",
            ),
            NotificationCard(
              title: "Demande De Service",
              content:
                  "Votre demande de service 'Plomberie' a été acceptée par Ahmed.",
            ),
            NotificationCard(
              title: "Abonnement",
              content:
                  "Votre abonnement est actif jusqu’au 15 août. Merci pour votre paiement !",
            ),
            NotificationCard(
              title: "Avis D'un Utilisateur",
              content:
                  "L’utilisateur Mehdi Doukkali a laissé un commentaire sur votre service : ‘Travail parfait !'",
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Messages',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String content;

  const NotificationCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(content),
        trailing: const Icon(Icons.close),
      ),
    );
  }
}
