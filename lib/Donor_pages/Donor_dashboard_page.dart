// ignore_for_file: file_names, prefer_const_constructors, use_super_parameters, avoid_print

import 'package:feed_the_needy/components/profile_percentCard.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
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
          isProfileComplete = data['name'] != null && data['emailId'] != null;
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
                      title: AppLocalizations.of(context)!.totalFoodUploads,
                      value: totalFoodUploads.toString()),
                  StatsCard(
                      title: AppLocalizations.of(context)!.totalServed,
                      value: totalServings.toString()),
                  StatsCard(
                      title: AppLocalizations.of(context)!.peopleFed,
                      value: totalPeopleFed.toString()),
                  StatsCard(
                      title: AppLocalizations.of(context)!.homesTrustsFed,
                      value: totalHomesFed.toString()),
                ],
              ),
              const SizedBox(height: 16),

              Text(
                AppLocalizations.of(context)!.whyFeedNeedy,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.feedNeedyDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                AppLocalizations.of(context)!.feedNeedyKeyPoints,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              
              Text(
                AppLocalizations.of(context)!.activeListings,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FoodListingCard(
                      title: 'Pasta',
                      status: AppLocalizations.of(context)!.pendingRequests,
                      date: AppLocalizations.of(context)!.listingDate( '15')),
                  FoodListingCard(
                      title: 'Sandwiches',
                      status: AppLocalizations.of(context)!.deliveryInProgress,
                      date: AppLocalizations.of(context)!.listingDate( '14')),
                  FoodListingCard(
                      title: 'Rice and Curry',
                      status: AppLocalizations.of(context)!.pendingApproval,
                      date: AppLocalizations.of(context)!.listingDate('13')),
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
