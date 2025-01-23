import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId; // Optional
  final String? userEmail; // Optional
  final String? userName; // Optional

  const ProfileScreen({
    Key? key,
    this.userId,
    this.userEmail,
    this.userName,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
  bool isLoading = true;
  String _profileImageUrl = ''; // Default to an empty string
  bool _isPasswordVisible = false;
  File? _selectedImage;
  final picker = ImagePicker();

  // Replace with your Cloudinary details
  final String cloudinaryUploadUrl =
      'https://api.cloudinary.com/v1_1/dhjwrknx8/image/upload';
  final String uploadPreset = 'ServicePro'; // Optional, if configured
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final uid = widget.userId ??
          FirebaseAuth.instance.currentUser?.uid; // Fallback to current user ID

      if (uid != null) {
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();

        if (userDoc.exists) {
          setState(() {
            firstName = userDoc['firstName'] ?? '';
            lastName = userDoc['lastName'] ?? '';
            phoneNumber = userDoc['phoneNumber'] ?? '';
            email = widget.userEmail ?? userDoc['email'];
            password = userDoc['password'];
            _profileImageUrl =  userDoc['profileImageUrl'] ?? '';

            _firstNameController.text = firstName;
            _lastNameController.text = lastName;
            _phoneController.text = phoneNumber;
            _passwordController.text = password;


            isLoading = false;
          });
        } else {
          throw Exception('User data not found');
        }
      } else {
        throw Exception('User ID not provided or not logged in');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }
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
  Future<void> saveChanges() async {
    try {
      final uid = widget.userId ??
          FirebaseAuth.instance.currentUser?.uid; // Fallback to current user ID
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await uploadImage(_selectedImage!); // Upload the selected image
      }
      if (uid != null) {
        await _firestore.collection('users').doc(uid).update({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'phoneNumber': _phoneController.text,
          'password': _passwordController.text,
          if (imageUrl != null) 'profileImageUrl': imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        throw Exception('User ID not available for saving changes');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving changes: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName ?? 'Profile'), // Fallback title
        backgroundColor: Colors.lime,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

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
                  controller: _firstNameController,
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
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
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
              Text('Email: (Read Only)'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller:
                  TextEditingController(text: widget.userEmail ?? email),
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Password:'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: saveChanges,
                  child: Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
