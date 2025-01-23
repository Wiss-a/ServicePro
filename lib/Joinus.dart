// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'menu.dart';
import 'subscription2.dart';


class Joinus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(

          child: Column(

            children: <Widget>[
            Stack(
            children: [
        // Image widget
        Image.asset(
        'assets/worker2.jpg',
        width: double.infinity,
        fit: BoxFit.fitWidth,
          ),
          // Close icon in front of the image
          Positioned(
          top: 20, // Adjust the distance from the top
          left: 20, // Adjust the distance from the left
          child: IconButton(
          onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MenuPage(),
          ));
          },
          icon: Icon(
          Icons.close,
          color: Colors.black,
          size: 30, // Adjust icon size as needed
          ),
          ),
          ),
        ]),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 22, horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      'BECOME WITH US?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Join Our Workforce Today',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/clock.png',
                          width: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Increased Job Opportunities',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Expand your client base and enjoy flexible working hours.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/medal.png',
                          width: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Enhanced Professional Reputation',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Build credibility through user reviews and showcase your work.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/wallet.png',
                          width: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Convenient Business Management',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Enjoy a hassle-free payment process, with secure and direct earnings deposited into your account.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      width: 230,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // background color
                          foregroundColor: Colors.white, // text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Subscription()),
                          );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Subscription()),
                        );
                      },
                      child: Text(
                        'View Subscription Plans',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],

          ),
        ),
      ),
    );
  }
}
