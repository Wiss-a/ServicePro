import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditItem extends  StatefulWidget {

  final Widget widget;
  final String title;
  const EditItem({
    super.key,
    required this.widget,
    required this.title,
  });
  @override
  EditItemState createState() => EditItemState();
}
class EditItemState extends State<EditItem> {
  File? _image; // To store the selected image
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  Future<void> _pickImage() async {
    // Pick an image from the gallery
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Save the image file
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            // Display the selected image or default avatar
            _image != null
                ? Image.file(
              _image!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/icon3.png',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            TextButton(
              onPressed: _pickImage, // Call the function to pick an image
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlueAccent,
              ),
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ],
    );
  }
}