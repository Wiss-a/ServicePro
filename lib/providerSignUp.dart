import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkerForm(),
    );
  }
}

class WorkerForm extends StatefulWidget {
  @override
  WorkerFormState createState() => WorkerFormState();
}
class Provider {
  final String fullName;
  final String phoneNumber;
  final String city;
  final String accountNumber;
  final String amountPaid;
  final String imageUrl;
  final String userId;

  Provider({
    required this.fullName,
    required this.phoneNumber,
    required this.city,
    required this.accountNumber,
    required this.amountPaid,
    required this.imageUrl,
    required this.userId,
  });

  // Factory constructor to create a Provider from a Map
  factory Provider.fromMap(Map<String, dynamic> data) {
    return Provider(
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      city: data['city'] ?? '',
      accountNumber: data['accountNumber'] ?? '',
      amountPaid: data['amountPaid'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}

class WorkerFormState extends State<WorkerForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _amountPaidController = TextEditingController();
  final TextEditingController _workcityController = TextEditingController();


  File? _selectedImage;
  String? imageUrl;

  // Cloudinary details
  final String cloudinaryUploadUrl =
      'https://api.cloudinary.com/v1_1/dhjwrknx8/image/upload';
  final String cloudinaryApiKey = '321145345136829';
  final String cloudinaryApiSecret = '5ndZE0LS_qM3SWVM1Kbmm12RO20';
  final String uploadPreset = 'ServicePro'; // Optional if configured

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Upload the image to Cloudinary
  Future<String?> _uploadImageToCloudinary() async {
    if (_selectedImage == null) return null;

    try {
      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUploadUrl));
      request.fields['upload_preset'] = uploadPreset;
      request.fields['api_key'] = cloudinaryApiKey;
      request.files.add(await http.MultipartFile.fromPath('file', _selectedImage!.path));
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

  // Save worker information including image URL to Firestore
  Future<void> _saveProviderInfo() async {
    if (_fullNameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _workcityController.text.isEmpty ||
        _accountNumberController.text.isEmpty ||
        _amountPaidController.text.isEmpty ||
        _selectedWorkType == null ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and upload an image')),
      );
      return;
    }


    final uploadedImageUrl = await _uploadImageToCloudinary();

    if (uploadedImageUrl != null) {
      setState(() {
        imageUrl = uploadedImageUrl;
      });

      try {
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await FirebaseFirestore.instance.collection('providers').doc(currentUser.uid).set({
            'fullName': _fullNameController.text.trim(),
            'phoneNumber': _phoneNumberController.text.trim(),
            'workcity': _workcityController.text.trim(),
            'accountNumber': _accountNumberController.text.trim(),
            'amountPaid': _amountPaidController.text.trim(),
            'imageUrl': imageUrl,
            'workType':_selectedWorkType,
            'userId': currentUser.uid,
            'is_provider': true,

          });
          await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
            'is_provider': true,
            'fullName': _fullNameController.text.trim(),
            'Workcity': _workcityController.text.trim(),
            'accountNumber': _accountNumberController.text.trim(),
            'amountPaid': _amountPaidController.text.trim(),
            'imageUrl': imageUrl,
            'workType':_selectedWorkType,
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user is currently logged in.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save worker information: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image to Cloudinary.')),
      );
    }

  }








  final List<Map<String, dynamic>> workTypes = [
    {'title': 'Plumbing', 'icon': 'assets/repair.png'},
    {'title': 'Cleaning', 'icon': 'assets/clean.png'},
    {'title': 'Carpentry', 'icon': 'assets/carpenter.png'},
    {'title': 'Electrician','icon': 'assets/electrician.png'},
    {'title': 'Repairing','icon': 'assets/repair.png'},
    {'title': 'Mechanic','icon': 'assets/mechanic.png'},
    {'title': 'Gardening','icon': 'assets/garden.png'},
    {'title': 'Painting','icon': 'assets/painter.png'},
    {'title': 'Laundry','icon': 'assets/laundry.png'},

  ];

  String? _selectedWorkType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: Text('Become a Worker'),
      ),
      body: SingleChildScrollView(
    child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _workcityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedWorkType,
              hint: Text('Select Work Type'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              ),
              items: workTypes.map((workType) {
                return DropdownMenuItem<String>(
                  value: workType['title'],
                  child: Row(
                    children: [
                      Image.asset(
                        workType['icon'], // Use Image.asset to display the image
                        width: 24, // Set an appropriate width
                        height: 24, // Set an appropriate height
                      ),
                      SizedBox(width: 10),
                      Text(workType['title']),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedWorkType = newValue; // Met à jour la valeur sélectionnée
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _accountNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(16), // Limit to 16 digits
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountPaidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount Paid',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
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
            if (_selectedImage != null)
              Image.file(_selectedImage!),

            SizedBox(
              width: 230,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  await _saveProviderInfo();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Subscribe',
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
