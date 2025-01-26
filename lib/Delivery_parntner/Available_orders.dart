import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AvailableOrdersPage extends StatefulWidget {
  @override
  _AvailableOrdersPageState createState() => _AvailableOrdersPageState();
}

class _AvailableOrdersPageState extends State<AvailableOrdersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> acceptOrder(DocumentSnapshot order) async {
    try {
      // Get current user (delivery partner)
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please log in first')),
        );
        return;
      }

      // Check if partner already has an active delivery
      QuerySnapshot activeDeliveries = await _firestore
          .collection('current_delivery')
          .where('partnerId', isEqualTo: currentUser.uid)
          .get();

      if (activeDeliveries.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You already have an active delivery')),
        );
        return;
      }

      // Transaction to move order and update status
      await _firestore.runTransaction((transaction) async {
        // Move order to current_delivery collection
        transaction.set(_firestore.collection('current_delivery').doc(), {
          ...order.data() as Map<String, dynamic>,
          'partnerId': currentUser.uid,
          'status': 'Partner Accepted',
          'acceptedAt': FieldValue.serverTimestamp(),
        });

        // Remove from home_delivery collection
        transaction.delete(order.reference);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Accepted Successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error accepting order: $e')),
      );
    }
  }

  Future<void> rejectOrder(DocumentSnapshot order) async {
    try {
      // Reject the order (just delete from the 'home_delivery' collection)
      await _firestore.collection('home_delivery').doc(order.id).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Rejected')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error rejecting order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('home_delivery')
            .where('status', isEqualTo: 'Waiting for Partner')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Column(
              children: [SizedBox(height: 100),
                Icon(Icons.info, size: 100, color: Colors.grey),
                SizedBox(height: 50),
                Text('No available orders'),
              ],
            ));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot order = snapshot.data!.docs[index];
              Map<String, dynamic> orderData = order.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(tileColor: Colors.lightBlueAccent,
                  title: Text('Delivery Id: ${orderData['delivery_id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location: ${orderData['city'] ?? 'N/A'}'),
                      Text('Recipient Name: ${orderData['recipient_name'] ?? 'N/A'}'),
                      Text('Quantity: ${orderData['servings'] ?? 'N/A'}'),
                      Text('Current Status: ${orderData['status'] ?? 'N/A'}'),
                    ],
                  ),
                  onTap: () {
                    // Show the bottom sheet with order details and Accept/Reject buttons
                    showModalBottomSheet(
                      scrollControlDisabledMaxHeightRatio: 100,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Delivery Id: ${orderData['delivery_id']}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text('Location: ${orderData['city'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                              Text('Recipient Name: ${orderData['recipient_name'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                              Text('Quantity: ${orderData['servings'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                              Divider(thickness: 0.5,),
                             
                              Text('Door No: ${orderData['door_no'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                              Text('Street Name: ${orderData['street'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                              
                              Text('City: ${orderData['city'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                               Text('Pincode : ${orderData['pin_code'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                               Text('Payment Mode: ${orderData['payment_method'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                               Text('delivery charge: ${orderData['delivery_charge'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 17)),
                               Divider(thickness: 0.5,),
                              Text('Recipient phone: ${orderData['recipient_phone'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                               Text('Recipient Email: ${orderData['email_id'] ?? 'N/A'}',style: TextStyle(fontSize: 16),),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      acceptOrder(order);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      color: Colors.green,
                                      child: Text('Accept', style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      rejectOrder(order);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      color: Colors.red,
                                      child: Text('Reject', style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
