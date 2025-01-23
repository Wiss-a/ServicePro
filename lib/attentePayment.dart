import 'package:flutter/material.dart';
import 'homePage.dart';
import 'menu.dart';

class Attentepayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attentepayment',
      home: AttentepaymentPage(),
    );
  }
}
class AttentepaymentPage extends StatefulWidget{
  @override
  AttentepaymentPageState createState() => AttentepaymentPageState();
}

class AttentepaymentPageState extends State<AttentepaymentPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('En Attente de Validation'),
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
              child: Text(
                'Paiement en cours de validation !', // Texte affiché au milieu
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bouton en bas de page
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyHomePage()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black87, // Couleur du texte
                minimumSize: Size(double.infinity, 50), // Largeur et hauteur du bouton
              ),
              child: Text('Continue',style: TextStyle(fontSize: 18,color: Colors.white)),
            ),
          ),
        ],
      ),
    );

    }
}