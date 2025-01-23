import 'package:flutter/material.dart';
import 'package:projet2/notification.dart';

import 'chatbox.dart';
import 'homePage.dart';
import 'menu.dart';



class SettingsUI extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Setting UI',
            home: EditProfilePage(),
        );
    }
}

class EditProfilePage extends StatefulWidget {
    @override
    EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
    bool showPassword = false;
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                elevation: 1,
                leading: IconButton(
                    icon: Icon(
                        Icons.arrow_back,
                        color: Colors.green,
                    ),
                    onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MenuPage()));
                        },
                ),
               /* actions: [
                    IconButton(
                        icon: Icon(
                            Icons.menu,
                            color: Colors.green,
                        ),
                        onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => SettingsPage()));
                        },
                    ),
                ],*/
            ),
            body: Container(
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                    onTap: () {
                        FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                        children: [
                            SizedBox(height: 20),
                            // Profile Image Section
                            Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        ClipOval(
                                            child: Image.asset(
                                                'assets/icon3.png',
                                                height: 100,
                                                width: 100,
                                                //fit: BoxFit.cover,
                                            ),
                                        ),
                                        SizedBox(height: 10),
                                        TextButton.icon(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue,
                                            ),
                                            icon: Icon(Icons.upload, size: 18),
                                            label: const Text(
                                                'Upload Image',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            SizedBox(height: 35),

                            // Text Fields Section
                            TextField(
                                decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                    ),
                                ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                                decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    hintText: 'nom.prénom@gmail.com',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                    ),
                                ),
                                keyboardType: TextInputType.emailAddress, // Adds appropriate keyboard for email
                            ),
                            SizedBox(height: 10),
                            TextField(
                                obscureText: true, // For password input
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: '********',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                    ),
                                ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                                decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    hintText: '+212612345678',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                    ),
                                ),
                                keyboardType: TextInputType.phone, // Adds appropriate keyboard for phone numbers
                            ),
                            SizedBox(height: 10),
                            TextField(
                                decoration: InputDecoration(
                                    labelText: 'Location',
                                    hintText: 'Rabat, Maroc',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                    ),
                                ),
                            ),
                            SizedBox(height: 35),


                            // Buttons Section
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    // Cancel Button
                                    OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                            ),
                                            side: BorderSide(color: Colors.grey.shade300),
                                        ),
                                        child: const Text(
                                            'CANCEL',
                                            style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 1.5,
                                                color: Colors.black,
                                            ),
                                        ),
                                    ),

                                    // Save Button
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                            ),
                                        ),
                                        child: const Text(
                                            'SAVE',
                                            style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 1.5,
                                                color: Colors.white,
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),


        ),bottomNavigationBar: Padding(
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
                                        MaterialPageRoute(builder: (context) => Chat()),
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
                                    Navigator.push;
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

    Widget buildTextField(
        String labelText, String placeholder, bool isPasswordTextField) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: TextField(
                obscureText: isPasswordTextField ? showPassword : false,
                decoration: InputDecoration(

                    suffixIcon: isPasswordTextField
                        ? IconButton(
                        onPressed: () {
                            setState(() {
                                showPassword = !showPassword;
                            });
                        },
                        icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                        ),
                    )
                        : null,
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: labelText,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: placeholder,
                    hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade400

                    ),border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0), // Default border
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0), // Focused border
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                ),

            ),

        );
    }
}