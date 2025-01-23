// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'Messages.dart';
import 'Profile.dart';
import 'menu.dart';
import 'homePage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  // Track the index of the selected bottom navigation item
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
                  MaterialPageRoute(builder: (context) => MenuPage()),
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
