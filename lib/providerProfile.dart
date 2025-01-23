import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For phone calls and messages
import 'User.dart';


class ProviderProfilePage extends StatelessWidget {
  final User provider;

  const ProviderProfilePage({super.key, required this.provider});

  // Method to initiate a phone call
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch $phoneNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Provider Profile',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lime,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile image
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(provider.profileImageUrl),
              ),

              const SizedBox(height: 20),

              // Provider name
              Text(
                provider.fullName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Work type
              Text(
                provider.workType,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Buttons for message and contact
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to the chat page
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(provider: provider),
                        ),
                      );*/
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Message'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Call the provider's phone number
                      _makePhoneCall(provider.phoneNumber);
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('Contact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),

              // Additional details


            ],
          ),
        ),
      ),
    );
  }
}
