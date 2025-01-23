import 'package:flutter/material.dart';
import 'StartPage0.dart';


class StartPage extends StatefulWidget{
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();

    // Delay of 3 seconds before navigating to the next page
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the next page (replace StartPage with the next page)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace with your next page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
      ),
      body: Container(
        color: Colors.lime,
        child: Column(
          children: [
            // Espace flexible pour centrer le texte
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Centre les éléments verticalement
                  children: [
                    Image.asset(
                      'assets/servicepro_logo.png', // Chemin de l'image dans vos assets
                      height: 150.0, // Taille personnalisée de l'image
                      width: 150.0,
                      fit: BoxFit.cover, // Optionnel : ajustement de l'image
                    ),
                    SizedBox(height: 16.0), // Espacement entre l'image et le texte
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

