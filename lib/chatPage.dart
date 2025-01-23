import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final String providerId; // The ID of the provider's account
  final String currentUserId; // The ID of the currently logged-in user

  const ChatPage({super.key, required this.providerId, required this.currentUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch messages between the two users
  Stream<QuerySnapshot> _fetchMessages() {
    return _firestore
        .collection('chats')
        .doc(_getChatRoomId(widget.currentUserId, widget.providerId))
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  String _getChatRoomId(String user1, String user2) {
    List<String> users = [user1, user2];
    users.sort(); // Sort the users alphabetically
    return users.join('_'); // Join the sorted list with an underscore
  }


  // Send a message
  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    String chatRoomId = _getChatRoomId(widget.currentUserId, widget.providerId);
    await _firestore.collection('chats').doc(chatRoomId).collection('messages').add({
      'senderId': widget.currentUserId,
      'receiverId': widget.providerId,
      'message': _messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _fetchMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData = messages[index];
                    final isSentByCurrentUser =
                        messageData['senderId'] == widget.currentUserId;

                    return Align(
                      alignment:
                      isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSentByCurrentUser ? Colors.blue[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(messageData['message']),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
