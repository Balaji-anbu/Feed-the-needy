// ignore_for_file: file_names, prefer_const_constructors, use_super_parameters, avoid_print

import 'package:feed_the_needy/components/profile_percentCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class DonorDashboardPage extends StatefulWidget {
  const DonorDashboardPage({super.key});

  @override
  State<DonorDashboardPage> createState() => _DonorDashboardPageState();
}

class _DonorDashboardPageState extends State<DonorDashboardPage> {
  bool isProfileComplete = true;
  bool isLoading = true;

  int totalFoodUploads = 0;
  int totalServings = 0;
  int totalPeopleFed = 0;
  int totalHomesFed = 0;

  @override
  void initState() {
    super.initState();
    _checkUserProfile();
    _fetchAppWideStats();
  }

  Future<void> _fetchAppWideStats() async {
    try {
      QuerySnapshot foodSnapshot =
          await FirebaseFirestore.instance.collection('food_available').get();

      int uploadsCount = foodSnapshot.docs.length;
      int servingsCount = foodSnapshot.docs.fold<int>(0, (total, doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return total + ((data['servings'] ?? 0) as int);
      });

      setState(() {
        totalFoodUploads = uploadsCount;
        totalServings = servingsCount;
        totalPeopleFed = (servingsCount * 1.5).toInt();
        totalHomesFed = (servingsCount / 50).ceil();
      });
    } catch (e) {
      print('Error fetching app-wide stats: $e');
    }
  }

  Future<void> _checkUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
          isProfileComplete = data['name'] != null &&
              data['organisationType'] != null &&
              data['organisationName'] != null &&
              data['doorNo'] != null &&
              data['street'] != null &&
              data['nearWhere'] != null &&
              data['city'] != null &&
              data['district'] != null &&
              data['pincode'] != null &&
              data['emailId'] != null;
        }
      }
    } catch (e) {
      print('Error checking user profile: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: Lottie.asset('assets/loading.json', height: 150, width: 150));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile completion card
              if (!isProfileComplete)
                GestureDetector(
                  onTap: () {
                    // Navigate to profile completion page
                  },
                  child: ProfileCompletionCard(
                      userId: FirebaseAuth.instance.currentUser?.uid ?? ''),
                ),
              const SizedBox(height: 16),

              // Stats Section
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StatsCard(
                      title: 'Total Food Uploads',
                      value: totalFoodUploads.toString()),
                  StatsCard(
                      title: 'Total Served', value: totalServings.toString()),
                  StatsCard(
                      title: 'People Fed', value: totalPeopleFed.toString()),
                  StatsCard(
                      title: 'Homes/Trusts Fed',
                      value: totalHomesFed.toString()),
                ],
              ),
              const SizedBox(height: 16),

              const Text(
                'Why Feed the Needy?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Feeding the needy is an act of kindness and generosity that helps ensure no one goes hungry. It not only nourishes those who are struggling but also contributes to a more compassionate and caring society. When we share what we have, we make the world a better place for everyone.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // List of captions or key points
              const Text(
                '• Ensures no one goes hungry.\n'
                '• Reduces food waste.\n'
                '• Builds a compassionate community.\n'
                '• Provides a sense of hope and dignity.\n'
                '• Helps create sustainable food systems.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Active Listings Section
              const Text(
                'Active Listings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  FoodListingCard(
                      title: 'Pasta',
                      status: 'Pending Requests',
                      date: 'Dec 15'),
                  FoodListingCard(
                      title: 'Sandwiches',
                      status: 'Delivery In Progress',
                      date: 'Dec 14'),
                  FoodListingCard(
                      title: 'Rice and Curry',
                      status: 'Pending Approval',
                      date: 'Dec 13'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder Widgets for Components
class StatsCard extends StatelessWidget {
  final String title;
  final String value;

  const StatsCard({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xffEAD6EE), Color(0xffA0F1EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodListingCard extends StatelessWidget {
  final String title;
  final String status;
  final String date;

  const FoodListingCard({
    required this.title,
    required this.status,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status\nDate: $date'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detailed listing page
        },
      ),
    );
  }
}