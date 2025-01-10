// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:feed_the_needy/Delivery_parntner/delivery_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryPartnerPage extends StatefulWidget {
  const DeliveryPartnerPage({super.key});

  @override
  _DeliveryPartnerPageState createState() => _DeliveryPartnerPageState();
}

class _DeliveryPartnerPageState extends State<DeliveryPartnerPage> {
  // Stream to fetch delivery requests assigned to the partner
  Stream<QuerySnapshot> _getPendingDeliveries() {
    return FirebaseFirestore.instance
        .collection('home_delivery')
        .where('status', isEqualTo: 'order placed') // Pending deliveries
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Assigned Deliveries'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _getPendingDeliveries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No assigned deliveries.'));
          }

          final deliveryDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: deliveryDocs.length,
            itemBuilder: (context, index) {
              final deliveryData =
                  deliveryDocs[index].data() as Map<String, dynamic>;
              final deliveryId = deliveryDocs[index].id;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryDetailsPage(
                        deliveryId: deliveryId,
                        deliveryData: deliveryData,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      "Food ID: ${deliveryData['food_id']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Donor: ${deliveryData['donor_id']}"),
                        Text("Needer: ${deliveryData['needer_id']}"),
                        Text("Status: ${deliveryData['status']}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
