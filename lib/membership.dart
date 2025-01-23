import 'dart:io';

import 'package:flutter/material.dart';
import 'Messages.dart';
import 'Notifications.dart';
import 'Profile.dart';
import 'attentePayment.dart';
import 'package:image_picker/image_picker.dart';
import 'subscription2.dart';
import 'homePage.dart';

class Membership extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Membership',
      home: MembershipPage(),
    );
  }
}
class MembershipPage extends StatefulWidget{
  @override
  MembershipPageState createState() => MembershipPageState();
  }

class MembershipPageState extends State<MembershipPage>{
  String fullName = '';
  String serviceType = '';
  String planType = '';
  String accountNumber = '';
  double amountPaid = 0.0;
  XFile? paymentReceipt;




  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected')));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Subscription()));
          },
        ),
      ),


          body: Stack(
            children: [
              // Main content wrapped in Padding or other widgets
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name:',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Account Number:',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your Account Number',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Text(
                      'Amount:',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter the amount paid',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Receipt :',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //SizedBox(width: 80.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_a_photo, size: 40),
                          onPressed: _pickImage,

                        ),
                        SizedBox(width: 8),

                      ],
                    ),
                    SizedBox(height: 20),

                    // Display the selected image (if any)
                    _image == null
                        ? Text('No image selected.')
                        : Image.file(
                      File(_image!.path),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),

              // Positioned ElevatedButton to be placed at the bottom
              Positioned(
                bottom: 16.0, // Adjust this for spacing from the bottom
                left: 0,
                right: 0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Attentepayment()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black87, // Set the font color to white
                    minimumSize: Size(double.infinity, 50), // Full width and a height of 50
                  ),
                  child: Text('Proceed',style: TextStyle(fontSize: 18,color: Colors.white)),
                ),
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
                      MaterialPageRoute(builder: (context) => NotificationPage()),
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
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
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


    );
  }

}