import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryTrackingPage extends StatelessWidget {
  final String deliveryId; // Unique ID of the delivery to track

  const DeliveryTrackingPage({Key? key, required this.deliveryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your Delivery'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('home_delivery')
            .doc(deliveryId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No delivery details available.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final List<String> statuses = [
            "Order Placed",
            "Waiting for Partner",
            "Partner Accepted",
            "Food Picked Up from Donor",
            "Out for Delivery",
            "Delivery in Progress",
            "Delivered!",
          ];
          final currentStatus = data['status'] ?? "Order Placed";
          final currentIndex = statuses.indexOf(currentStatus);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery Status",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: statuses.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: index <= currentIndex
                                    ? Colors.green
                                    : Colors.grey,
                                child: Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              if (index != statuses.length - 1)
                                Container(
                                  height: 50,
                                  width: 2,
                                  color: index < currentIndex
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  statuses[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: index <= currentIndex
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                                if (index <= currentIndex &&
                                    data['timestamps'] != null)
                                  Text(
                                    data['timestamps'][statuses[index]] ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality if needed (e.g., contact delivery partner)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text("Contact Delivery Partner"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
