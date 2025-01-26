import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompletedOrdersPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('completed_delivery')
            .where('partnerId', isEqualTo: _auth.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Completed Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          // Display the list of completed orders
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot completedOrder = snapshot.data!.docs[index];
              Map<String, dynamic> orderData = completedOrder.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.greenAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ${orderData['delivery_id']}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text('Recipient Name: ${orderData['recipient_name'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        Text('Location: ${orderData['city'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        Text('Quantity: ${orderData['servings'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Divider(color: Colors.white),
                        Text('Address:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Door No: ${orderData['door_no'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        Text('Street Name: ${orderData['street'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        Text('City: ${orderData['city'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        Text('Pincode: ${orderData['pin_code'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Divider(color: Colors.white),
                        Text('Contact Details:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Phone: ${orderData['recipient_phone'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        Text('Email: ${orderData['email_id'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Divider(color: Colors.white),
                        Text('Completed On: ${orderData['completed_on'] ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
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
