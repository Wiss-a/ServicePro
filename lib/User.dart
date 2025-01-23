import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'providerProfile.dart';

class User {
  final String fullName;
  final String workType;
  final String phoneNumber;
  final String review;
  final String workcity;
  final String rating;
  final String userId;
  final String profileImageUrl;

  User({
    required this.fullName,
    required this.workType,
    required this.phoneNumber,
    required this.workcity,
    required this.rating,
    required this.review,
    required this.userId,
    required this.profileImageUrl,
  });

  // From Firestore document to Provider object
  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      fullName: data['fullName'] ?? '',
      workType: data['workType'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      workcity: data['workcity'] ?? '',
      rating: data['rating'] ?? '',
      review: data['review'] ?? '',
      userId: data['userId'] ?? '',
        profileImageUrl:data['profileImageUrl'] ?? '',
    );
  }
}

// Page for service providers in a category
class ProvidersPage extends StatelessWidget {
  final String categoryName;

  const ProvidersPage({super.key, required this.categoryName});

  Future<List<User>> _fetchProviders(String serviceType) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('workType', isEqualTo: serviceType)
        .get();

    return querySnapshot.docs
        .map((doc) => User.fromFirestore(doc))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$categoryName Providers',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: _fetchProviders(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No providers found.'));
          } else {
            final providers = snapshot.data!;

            return ListView.builder(
              itemCount: providers.length,
              itemBuilder: (context, index) {
                final provider = providers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        provider.fullName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        provider.phoneNumber,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProviderProfilePage(provider: provider),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'View Profile',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

          }
        },
      ),
    );
  }
}
