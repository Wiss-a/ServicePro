import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Profile.dart';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
        backgroundColor: Colors.lime,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching users: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No users found.'),
            );
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              // Safely access Firestore fields
              final data = user.data() as Map<String, dynamic>? ?? {};
              final isAdmin = data['is_admin'] ?? false;
              final isProvider = data['is_provider'] ?? false;
              final firstName = data['firstName'] ?? 'Unknown';
              final lastName = data['lastName'] ?? 'User';
              final email = data['email'] ?? 'No Email';

              // Determine the user's role
              String role = 'User';
              if (isAdmin) {
                role = 'Admin';
              } else if (isProvider) {
                role = 'Provider';
              }

              return ListTile(
                leading: Icon(
                  isAdmin ? Icons.admin_panel_settings : Icons.person,
                  color: isAdmin ? Colors.red : Colors.blue,
                ),
                title: Text('$firstName $lastName ($role)'), // Add role
                subtitle: Text(email),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'View') {
                      _viewUserProfile(user.id, email, '$firstName $lastName');
                    } else if (value == 'Delete') {
                      _confirmDeleteUser(user.id, '$firstName $lastName');
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'View', child: Text('View Profile')),
                    PopupMenuItem(value: 'Delete', child: Text('Delete')),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _viewUserProfile(String userId, String email, String fullName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userId: userId,
          userEmail: email,
          userName: fullName,
        ),
      ),
    );
  }

  void _confirmDeleteUser(String userId, String userName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete $userName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deleteUser(userId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$userName has been deleted.')),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting user: $e')),
      );
    }
  }
}
