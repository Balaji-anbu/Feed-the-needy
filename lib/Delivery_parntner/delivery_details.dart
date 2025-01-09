import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeliveryDetailsPage extends StatelessWidget {
  final String deliveryId;
  final Map<String, dynamic> deliveryData;

  const DeliveryDetailsPage({
    Key? key,
    required this.deliveryId,
    required this.deliveryData,
  }) : super(key: key);

  // Function to update delivery status
  Future<void> _updateDeliveryStatus(
      BuildContext context, String status, String message) async {
    try {
      await FirebaseFirestore.instance
          .collection('home_delivery')
          .doc(deliveryId)
          .update({'status': status});

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Helper function to get action buttons based on current status
  List<Widget> _getActionButtons(BuildContext context) {
    final List<Widget> actionButtons = [];

    switch (deliveryData['status']) {
      case 'Waiting for Partner':
        actionButtons.add(ElevatedButton(
          onPressed: () {
            _updateDeliveryStatus(context, 'Partner Accepted',
                'Delivery Partner has accepted the delivery!');
          },
          child: const Text('Accept Delivery'),
        ));
        break;

      case 'Partner Accepted':
        actionButtons.add(ElevatedButton(
          onPressed: () {
            _updateDeliveryStatus(context, 'Food Picked Up from Donor',
                'Food has been picked up from the donor!');
          },
          child: const Text('Pickup Food from Donor'),
        ));
        break;

      case 'Food Picked Up from Donor':
        actionButtons.add(ElevatedButton(
          onPressed: () {
            _updateDeliveryStatus(
                context, 'Out for Delivery', 'Food is now out for delivery!');
          },
          child: const Text('Out for Delivery'),
        ));
        break;

      case 'Out for Delivery':
        actionButtons.add(ElevatedButton(
          onPressed: () {
            _updateDeliveryStatus(
                context, 'Delivery in Progress', 'Delivery is in progress!');
          },
          child: const Text('Delivery in Progress'),
        ));
        break;

      case 'Delivery in Progress':
        actionButtons.add(ElevatedButton(
          onPressed: () {
            _updateDeliveryStatus(
                context, 'Delivered', 'Food has been successfully delivered!');
          },
          child: const Text('Mark as Delivered'),
        ));
        break;

      default:
        actionButtons.add(const Text('No further actions available.'));
    }

    // Add reject button as a default option
    actionButtons.add(const SizedBox(height: 20));
    actionButtons.add(ElevatedButton(
      onPressed: () {
        _updateDeliveryStatus(
            context, 'Rejected', 'Delivery has been rejected by the partner.');
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text('Reject Delivery'),
    ));

    return actionButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Details",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Food ID: ${deliveryData['food_id']}"),
            Text("Donor: ${deliveryData['donor_id']}"),
            Text("Needer: ${deliveryData['needer_id']}"),
            Text("Status: ${deliveryData['status']}"),
            const SizedBox(height: 20),
            const Text(
              "Action Steps",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ..._getActionButtons(context),
          ],
        ),
      ),
    );
  }
}
