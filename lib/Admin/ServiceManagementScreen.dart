import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ServiceManagementScreen extends StatefulWidget {
  @override
  _ServiceManagementScreenState createState() =>
      _ServiceManagementScreenState();
}

class _ServiceManagementScreenState extends State<ServiceManagementScreen> {
  File? _selectedImage;
  final picker = ImagePicker();
  String _profileImageUrl = '';
  // Replace with your Cloudinary details
  final String cloudinaryUploadUrl =
      'https://api.cloudinary.com/v1_1/dhjwrknx8/image/upload';
  final String uploadPreset = 'ServicePro'; // Optional, if configured
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Management'),
        backgroundColor: Colors.lime,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('jobs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching services: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No services found.'),
            );
          }

          final jobs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];

              // Safely access Firestore fields
              final data = job.data() as Map<String, dynamic>? ?? {};
              final job_name = data['job_name'] ?? 'Unnamed Service';
              final job_icon = data['job_icon'] ?? '';

              return ListTile(
                leading: Icon(
                  Icons.work,
                  color: Colors.blue,
                ),
                title: Text(job_name),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Edit') {
                      _showEditDialog(job.id, job_name);
                    } else if (value == 'Delete') {
                      _confirmDeleteJob(job.id, job_name);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'Edit', child: Text('Edit')),
                    PopupMenuItem(value: 'Delete', child: Text('Delete')),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddServiceDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.lime,
      ),
    );
  }

  void _showAddServiceDialog() {
    final TextEditingController _jobNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Service'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _jobNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Service Name',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _selectedImage != null
                      ? Image.file(
                    _selectedImage!,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : Text('No image selected'),
                  const SizedBox(height: 8.0),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _pickImage();
                      if (_selectedImage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Uploading image...')),
                        );
                        String? imageUrl = await uploadImage(_selectedImage!);
                        if (imageUrl != null) {
                          setState(() {
                            _profileImageUrl = imageUrl;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Image uploaded successfully!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Image upload failed.')),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.upload),
                    label: Text('Upload Image'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final jobName = _jobNameController.text.trim();
                    if (jobName.isNotEmpty && _profileImageUrl.isNotEmpty) {
                      // Add service to Firestore
                      await _firestore.collection('jobs').add({
                        'job_name': jobName,
                        'job_icon': _profileImageUrl,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Service added successfully!')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter all details.')),
                      );
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  void _showEditDialog(String job_name, String job_icon) {
    final TextEditingController _jobNameController =
    TextEditingController(text: job_name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Service'),
          content: TextField(
            controller: _jobNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Service Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newJobName = _jobNameController.text.trim();
                if (newJobName.isNotEmpty) {
                  await _firestore.collection('jobs').doc(job_name).update({
                    'job_name': newJobName,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Service updated successfully!')),
                  );
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteJob(String jobId, String job_name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Service'),
          content: Text('Are you sure you want to delete "$job_name"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deleteJob(jobId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Service "$job_name" deleted.')),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteJob(String jobId) async {
    try {
      await _firestore.collection('jobs').doc(jobId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting service: $e')),
      );
    }
  }
}
