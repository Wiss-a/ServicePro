// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'StartPage2.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 55, horizontal: 30),
          child: Column(
            children: <Widget>[
              Text(
                'Best Helping\nHands for you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.1,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'With Our On-Demand Services App,\nWe Give Better Services To You.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 25,
              ),
              Image.asset('assets/worker.png'),
              SizedBox(
                height: 42,
              ),
              SizedBox(
                width: 230,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Startpage2()),
                    );
                  },
                  child: Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
