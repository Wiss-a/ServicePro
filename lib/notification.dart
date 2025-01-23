import 'package:flutter/material.dart';
import 'menu.dart';

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification',
      home: NotificationPage(),
    );
  }
}
class NotificationPage extends StatefulWidget{
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MenuPage()));
          },
        ),
      ),
      body: Column(
        children: [
          // Espace flexible pour centrer le texte
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Centre les éléments verticalement
                children: [
                  Image.asset(
                    'assets/notif.png', // Chemin de l'image dans vos assets
                    height: 150.0, // Taille personnalisée de l'image
                    width: 150.0,
                    fit: BoxFit.cover, // Optionnel : ajustement de l'image
                  ),
                  SizedBox(height: 16.0), // Espacement entre l'image et le texte
                  Text(
                    'No Notifications Yet', // Texte affiché en bas
                    style: TextStyle(
                      fontSize: 20.0, // Taille de la police
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Couleur du texte
                    ),
                    textAlign: TextAlign.center, // Centrer le texte
                  ),
                ],
              ),
            ),

          ),


        ],
      ),
    );

  }
}