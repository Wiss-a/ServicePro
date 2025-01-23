import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Messages.dart';
import 'Profile.dart';
import '../User.dart';
import 'AdminDashboard.dart';
import 'Notification.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdminPage',
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatefulWidget {
  @override
  AdminHomePageState createState() => AdminHomePageState();
}
class Category {
  final String job_name;
  final String job_icon;

  Category({
    required this.job_name,
    required this.job_icon,
  });

  // Factory method to create a Category from a Firestore document
  factory Category.fromFirestore(Map<String, dynamic> data) {
    return Category(
      job_name: data.containsKey('job_name') ? data['job_name'] : 'Unknown',
      job_icon: data.containsKey('job_icon') ? data['job_icon'] : '',
    );
  }

}

class AdminHomePageState extends State<AdminHomePage> {
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  /*
  final List<ServiceCategory> categories = [
    ServiceCategory('Cleaning', 'assets/clean2.png', Colors.white),
    ServiceCategory('Plumbing', 'assets/plumber.png', Colors.white),
    ServiceCategory('Electrician', 'assets/electrician.png', Colors.white),
    ServiceCategory('Mechanic', 'assets/mechanic.png', Colors.white),
    ServiceCategory('Repairing', 'assets/repair.png', Colors.white),
    ServiceCategory('Gardening', 'assets/garden.png', Colors.white),
    ServiceCategory('Painting', 'assets/painter.png', Colors.white),
    ServiceCategory('Carpentry', 'assets/carpenter.png', Colors.white),
    ServiceCategory('Laundry', 'assets/laundry.png', Colors.white),
  ];
*/
  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('jobs').get();

      // Map Firestore data to a list
      setState(() {
        _categories = querySnapshot.docs
            .map((doc) => {
          'id': doc.id, // Document ID
          'job_name': doc['job_name'],
          'job_icon': doc['job_icon'], // Optional field
        })
            .toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('ServicePro'),
        backgroundColor: Colors.lime,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/servicepro_logo.png',
              width: 35,
              height: 35,
            ),
            SizedBox(width: 8),
            Text(
              ' Admin ',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.menu), // Replace the arrow with a menu icon
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AdminDashboard()));
          },
        ),
      ),
      body: Container(
        color: Color(0xFFF3F5FD),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Services'),
            const SizedBox(height: 16.0),

            // Grid of categories
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erreur de chargement des catégories'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Aucune catégorie trouvée'));
            }

            // Convert Firestore documents to Category objects
            final categories = snapshot.data!.docs.map((doc) {
              return Category.fromFirestore(doc.data() as Map<String, dynamic>);
            }).toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 cubes par ligne
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProvidersPage(categoryName: category.job_name),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Image.network(
                            category.job_icon,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return CircularProgressIndicator();
                            },
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 40),
                          ),


                        const SizedBox(height: 8.0),
                        Text(
                          category.job_name,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminHomePage()),
                    );
                  },
                  icon: Icon(Icons.home),
                  tooltip: 'Home',
                ),
                Text(
                  'Home',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            // Chat Button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Messages()),
                    );
                  },
                  icon: Icon(Icons.message),
                  tooltip: 'Chat',
                ),
                Text(
                  'Chat',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            // Notifications Button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()),
                    );
                  },
                  icon: Icon(Icons.notifications),
                  tooltip: 'Notifications',
                ),
                Text(
                  'Notifications',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            // Profile Button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen()),
                    );                  },
                  icon: Icon(Icons.person),
                  tooltip: 'Profile',
                ),
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Model for service category
class ServiceCategory {
  final String job_name;
  final String job_icon;

  ServiceCategory(this.job_name, this.job_icon);
}
