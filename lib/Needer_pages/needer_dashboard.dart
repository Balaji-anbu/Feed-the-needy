// ignore_for_file: file_names, prefer_const_constructors, use_super_parameters, avoid_print

import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodNeederDashboardPage extends StatefulWidget {
  const FoodNeederDashboardPage({super.key});

  @override
  State<FoodNeederDashboardPage> createState() =>
      _FoodNeederDashboardPageState();
}

class _FoodNeederDashboardPageState extends State<FoodNeederDashboardPage> {
  bool isLoading = true;
  int totalAvailableFood = 0;
  List<Map<String, dynamic>> foodListings = [];

  @override
  void initState() {
    super.initState();
    _fetchAvailableFood();
  }

  Future<void> _fetchAvailableFood() async {
    try {
      QuerySnapshot foodSnapshot =
          await FirebaseFirestore.instance.collection('food_available').get();

      List<Map<String, dynamic>> listings = foodSnapshot.docs.map((doc) {
        return {
          'title': doc['title'] ?? 'Untitled',
          'servings': doc['servings'] ?? 0,
          'date': doc['date'] ?? '',
        };
      }).toList();

      setState(() {
        totalAvailableFood = foodSnapshot.docs.length;
        foodListings = listings;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching available food: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Lottie.asset('assets/loading.json', height: 150, width: 150),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatsCard(
                    title: AppLocalizations.of(context)!.availableFood,
                    value: totalAvailableFood.toString()
                  ),
                  StatsCard(
                    title: AppLocalizations.of(context)!.claimedFood,
                    value: '12'
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Active Food Listings Section
              Text(
                AppLocalizations.of(context)!.activeFoodListings,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              foodListings.isEmpty
                  ? Text(
                      'No active listings available.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: foodListings.length,
                      itemBuilder: (context, index) {
                        final listing = foodListings[index];
                        return FoodListingCard(
                          title: listing['title'],
                          servings: listing['servings'].toString(),
                          date: listing['date'],
                        );
                      },
                    ),
              const SizedBox(height: 20),

              // Notifications Section
              Text(
                AppLocalizations.of(context)!.notifications,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              NotificationCard(
                title: AppLocalizations.of(context)!.requestApproved,
                message: AppLocalizations.of(context)!.deliveryInProgressMessage,
                date: 'Jan 10',
              ),
              NotificationCard(
                title: 'Food Delivery In Progress',
                message: 'Your requested food is on its way.',
                date: 'Jan 9',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Stats Card Widget
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
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffB2FEFA), Color(0xff0ED2F7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Food Listing Card Widget
class FoodListingCard extends StatelessWidget {
  final String title;
  final String servings;
  final String date;

  const FoodListingCard({
    required this.title,
    required this.servings,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.fastfood, color: Colors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Servings: $servings\nDate: $date'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detailed listing page
        },
      ),
    );
  }
}

// Notification Card Widget
class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String date;

  const NotificationCard({
    required this.title,
    required this.message,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(date, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
