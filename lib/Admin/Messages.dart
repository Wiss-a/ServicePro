// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet2/Admin/AdminHomePage.dart';
import 'Profile.dart';
import 'Notification.dart';
import 'Menu.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotificationPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Messages()),
      );
    }
  }

  // firebase manipulation
  Future<List<Map<String, dynamic>>> getMessagesWithUserInfo(
      String senderId) async {
    List<Map<String, dynamic>> result = [];

    try {
      // Step 1: Query the messages collection where id_sender == senderId
      QuerySnapshot messagesSnapshot = await FirebaseFirestore.instance
          .collection('messages')
          .where('id_sender', isEqualTo: senderId)
          .get();

      print(messagesSnapshot.docs);

      for (var messageDoc in messagesSnapshot.docs) {
        Map<String, dynamic> messageData =
            messageDoc.data() as Map<String, dynamic>;

        // Step 2: Fetch the user information for each id_sender
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(messageData['id_sender'])
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          // Step 3: Combine the message and user data
          result.add({
            'message': messageData,
            'user': userData,
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    print('result d fetching 1: $result');
    return result;
  }

  void fetchData() async {
    String senderId = '1';
    List<Map<String, dynamic>> messagesWithUserInfo =
        await getMessagesWithUserInfo(senderId);

    for (var item in messagesWithUserInfo) {
      print('Message: ${item['message']['content']}');
      print('Sender: ${item['user']['name']}');
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
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text('Messages'),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(onPressed: fetchData, child: Text('Hello')),
            _buildMessageTile(
                sender: 'Elon',
                message:
                    "Can you confirm the repair service tomorrow at 10 am?",
                function: () {
                  print('Hello');
                }),
            _buildMessageTile(
                sender: 'Ali',
                message:
                    "Your reservation is confirmed. I'll arrive at the address on time.",
                function: () {
                  print('Hello');
                }),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Messages',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ), // Messages tab
      ),
    );
  }

  Widget _buildMessageTile(
      {required String sender,
      required String message,
      required VoidCallback function}) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          sender,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
        leading: Icon(Icons.person),
        onTap: function,
      ),
    );
  }
}
