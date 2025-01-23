import 'package:flutter/material.dart';

class AdminMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Messages',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with message count
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Message from User $index'),
                      subtitle: Text('Message body preview...'),
                      onTap: () {
                        // Navigate to message details
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
