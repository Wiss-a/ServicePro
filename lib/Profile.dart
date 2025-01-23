// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'Menu.dart';
import 'Messages.dart';
import 'Notifications.dart';
import 'homePage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool _isPasswordVisible = false;
  String password = '';
  String _profileImageUrl = ''; // Default to an empty string

  File? _selectedImage;
  final picker = ImagePicker();

  // Replace with your Cloudinary details
  final String cloudinaryUploadUrl =
      'https://api.cloudinary.com/v1_1/dhjwrknx8/image/upload';
  final String uploadPreset = 'ServicePro'; // Optional, if configured

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  // Load user data from Firestore
  void loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
      await _firestore.collection('users').doc(user.uid).get();
      if (snapshot.exists) {
        setState(() {
          _firstnameController.text = snapshot['firstName'] ?? '';
          _lastnameController.text = snapshot['lastName'] ?? '';
          _cityController.text = snapshot['city'] ?? '';
          _phoneController.text = snapshot['phoneNumber'] ?? '';
          _emailController.text = user.email ?? '';
          _passwordController.text = snapshot['password'] ?? '';
          _profileImageUrl = snapshot['profileImageUrl'] ?? '';
        });

      }
      await _firestore.collection('providers').doc(user.uid).get();
      if (snapshot.exists) {
        setState(() {
          _firstnameController.text = snapshot['firstName'] ?? '';
          _lastnameController.text = snapshot['lastName'] ?? '';
          _cityController.text = snapshot['city'] ?? '';
          _phoneController.text = snapshot['phoneNumber'] ?? '';
          _emailController.text = user.email ?? '';
          _passwordController.text = snapshot['password'] ?? '';
          _profileImageUrl = snapshot['profileImageUrl'] ?? '';
        });

      }
    }
  }

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selected successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  // Upload the image to Cloudinary
  Future<String?> uploadImage(File image) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUploadUrl));
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        return jsonResponse['secure_url']; // Get the uploaded image URL
      } else {
        print('Upload failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Save changes to Firestore
  void saveChanges() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await uploadImage(_selectedImage!); // Upload the selected image
    }

    try {
      // Save user information in 'users' collection
      await _firestore.collection('users').doc(user.uid).update({
        'firstName': _firstnameController.text.trim(),
        'lastName': _lastnameController.text.trim(),
        'city': _cityController.text.trim(),
        'phoneNumber': _phoneController.text.trim(),
        'email':_emailController.text.trim(),
        'password': _passwordController.text.trim(),
        'profileImageUrl':_profileImageUrl.trim(),
        if (imageUrl != null) 'profileImageUrl': imageUrl, // Save the image URL
      });
      if (_passwordController.text.isNotEmpty) {
        await user.updatePassword(_passwordController.text);
      }
      // Save provider information in 'providers' collection
      await _firestore.collection('providers').doc(user.uid).update({
        'firstName': _firstnameController.text.trim(),
        'lastName': _lastnameController.text.trim(),
        'city': _cityController.text.trim(),
        'email':_emailController.text.trim(),
        'phoneNumber': _phoneController.text.trim(),
        'profileImageUrl':_profileImageUrl.trim(),

        if (imageUrl != null) 'profileImageUrl': imageUrl, // Save the image URL
      });

      if (_passwordController.text.isNotEmpty) {
        await user.updatePassword(_passwordController.text);
      }
    //SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
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
          title: Text('Profile'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MenuPage()));
            },
          ),
        ),

        body:SafeArea(
        child: SingleChildScrollView(
        child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              // Profile Picture Placeholder
         /*     ClipOval(
                child: _selectedImage == null
                    ? Image.asset(
                  'assets/icon3.png', // Placeholder image
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  _selectedImage!, // Display picked image
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),*/
              GestureDetector(
                onTap: _pickImage,
                child: _profileImageUrl.isNotEmpty
                    ? CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImageUrl),
                )
                    : CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50), // Default icon
                ),
              ),
              SizedBox(height: 10),
              TextButton.icon(
                onPressed: _pickImage,
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
              SizedBox(height: 20),
              Text('First Name:'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _firstnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Last Name:'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _lastnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Phone Number Field
              Text('Phone Number:'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Email Field
              Text('Email: (Read Only)'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller:_emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Password Field
              Text('Password:'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible, // Toggle visibility
                  onChanged: (value) {
                    setState(() {
                      password = value; // Update the password variable
                    });
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Save Changes Button
              ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
        ),
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
