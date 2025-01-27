// ignore_for_file: file_names, prefer_const_constructors, use_super_parameters, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class DeliveryPartnerDashboardPage extends StatefulWidget {
  const DeliveryPartnerDashboardPage({super.key});

  @override
  State<DeliveryPartnerDashboardPage> createState() =>
      _DeliveryPartnerDashboardPageState();
}

class _DeliveryPartnerDashboardPageState
    extends State<DeliveryPartnerDashboardPage> {
  bool isLoading = true;

  int totalDeliveries = 0;
  int pendingDeliveries = 0;
  int completedDeliveries = 0;

  @override
  void initState() {
    super.initState();
    _fetchDeliveryStats();
  }

  Future<void> _fetchDeliveryStats() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        QuerySnapshot deliverySnapshot = await FirebaseFirestore.instance
            .collection('delivery_orders')
            .where('deliveryPartnerId', isEqualTo: user.uid)
            .get();

        int total = deliverySnapshot.docs.length;
        int pending = deliverySnapshot.docs
            .where((doc) =>
                (doc.data() as Map<String, dynamic>)['status'] == 'Pending')
            .length;
        int completed = total - pending;

        setState(() {
          totalDeliveries = total;
          pendingDeliveries = pending;
          completedDeliveries = completed;
        });
      }
    } catch (e) {
      print('Error fetching delivery stats: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Lottie.asset('assets/loading.json', height: 150, width: 150),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Delivery Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vertical Stats Section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  VerticalStatsCard(
                      title: 'Total Deliveries',
                      value: totalDeliveries.toString(),
                      icon: Icons.delivery_dining,
                      color: Colors.green),
                  VerticalStatsCard(
                      title: 'Pending Deliveries',
                      value: pendingDeliveries.toString(),
                      icon: Icons.hourglass_top,
                      color: Colors.orange),
                  VerticalStatsCard(
                      title: 'Completed Deliveries',
                      value: completedDeliveries.toString(),
                      icon: Icons.check_circle,
                      color: Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Motivational Carousel
            Container(
              height: 150,
              child: PageView(
                controller: PageController(viewportFraction: 0.85),
                children: [
                  MotivationCard(
                    title: 'Making a Difference',
                    content:
                        'Every delivery ensures food reaches someone in need. You are creating an impact!',
                  ),
                  MotivationCard(
                    title: 'Timely Assistance',
                    content:
                        'Your dedication ensures food is delivered fresh and on time!',
                  ),
                  MotivationCard(
                    title: 'Building Hope',
                    content:
                        'By connecting donors and needers, you are building hope for a better tomorrow.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Active Deliveries Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Active Deliveries',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('delivery_orders')
                  .where('deliveryPartnerId',
                      isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .where('status', isEqualTo: 'Pending')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Lottie.asset('assets/loading.json',
                          height: 100, width: 100));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No active deliveries at the moment.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                List<QueryDocumentSnapshot> orders = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        orders[index].data() as Map<String, dynamic>;
                    return DeliveryCard(
                      title: data['foodTitle'] ?? 'Unknown Item',
                      status: data['status'] ?? 'Pending',
                      date: data['orderDate'] ?? 'Unknown Date',
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            // Motivational Section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Why Being a Delivery Partner Matters?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'As a delivery partner, you play a vital role in bridging the gap between those willing to give and those in need. Your efforts ensure timely delivery of food to the hungry, making an impact one delivery at a time. Your dedication contributes to a hunger-free community.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // List of captions or key points
                  const Text(
                    '• Connects food to the needy.\n'
                    '• Reduces food waste.\n'
                    '• Fosters a hunger-free community.\n'
                    '• Provides timely assistance.\n'
                    '• Helps save lives and build hope.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Vertical Stats Card
class VerticalStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const VerticalStatsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, size: 30, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

// Motivation Card
class MotivationCard extends StatelessWidget {
  final String title;
  final String content;

  const MotivationCard({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        color: Colors.grey.shade200,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Delivery Card
class DeliveryCard extends StatelessWidget {
  final String title;
  final String status;
  final String date;

  const DeliveryCard({
    required this.title,
    required this.status,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status\nDate: $date'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detailed delivery page
        },
      ),
    );
  }
}
