// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'homePage.dart';
import 'LoginForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String firstName = '';
  String lastName = '';
  String city = '';
  String email = '';
  String password = '';
  String phoneNumber = '';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // First name
                Text(
                  'First name:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      firstName = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'e.g.: fistName',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                // Last Name
                Text(
                  'Last name:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'e.g.: lastName',
                    ),
                  ),
                ),



                SizedBox(
                  height: 8,
                ),
                Text(
                  'City:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      city = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'e.g.: Rabat',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                // Phone number
                Text(
                  'Phone Number (with country code):',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'e.g.: +212 6 12 34 56 78',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                // Email
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'e.g.: mail@example.com',
                    ),
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                // Password
                Text(
                  'Password:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
                    ),
                  ),
                ),



                SizedBox(
                  height: 14,
                ),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      print("All fields filled: $firstName, $lastName,$city ,$email, $password, $phoneNumber");
                      print("Creating user with email: $email");

                      final FirebaseAuth auth = FirebaseAuth.instance;
                      try {
                        if (firstName.isEmpty ||
                            lastName.isEmpty ||
                            email.isEmpty ||
                            city.isEmpty ||
                            password.isEmpty ||
                            phoneNumber.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Missing Information'),
                              content: Text('Please fill in all fields.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        final newUser =
                            await auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        if (newUser.user != null) {
                          print("Navigating to AuthSuccess...");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(newUser.user?.uid)
                              .set({
                            'firstName': firstName,
                            'lastName': lastName,
                            'phoneNumber': phoneNumber,
                            'city':city,
                            'email': email,
                            'password': password,
                            'is_provider': false,
                            'is_admin': false,
                            'profileImageUrl': '',
                            //'createdAt': FieldValue.serverTimestamp(),
                          });
                          await FirebaseFirestore.instance
                              .collection('providers')
                              .doc(newUser.user?.uid)
                              .set({
                            'firstName': firstName,
                            'lastName': lastName,
                            'phoneNumber': phoneNumber,
                            'city':city,
                            'email': email,
                            'password': password,
                            'is_provider': false,
                            'is_admin': false,
                            'profileImageUrl': '',
                            //'createdAt': FieldValue.serverTimestamp(),
                          });
                        }
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Sign Up Failed'),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginForm()),
                      );
                    },
                    child: Text(
                      'Log In',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Become worker things

// List<String> workType = [
//   'Plumber',
//   'Joiner',
//   'Blacksmith',
//   'Dyer',
//   'Mechanical'
// ];

// String dropdownValueWorkType = workType.first;

// Text(
//   'Work type',
//   style: TextStyle(
//     fontSize: 17,
//     fontWeight: FontWeight.w500,
//   ),
// ),
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
//   child: DropdownMenu<String>(
//     width: double.infinity,
//     initialSelection: workType.first,
//     onSelected: (String? value) {
//       setState(() {
//         dropdownValueWorkType = value!;
//       });
//     },
//     dropdownMenuEntries:
//         workType.map<DropdownMenuEntry<String>>((String value) {
//       return DropdownMenuEntry<String>(
//           value: value, label: value);
//     }).toList(),
//   ),
// ),

// ...InputForm(
//     'Years of experience', 'e.g.: 5', TextInputType.number),
