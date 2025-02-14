import 'package:feed_the_needy/generated/app_localizations.dart';
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
                AppLocalizations.of(context)!.noCompletedOrders,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

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
                          AppLocalizations.of(context)!.orderId(orderData['delivery_id']),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.recipientNameLabel(orderData['recipient_name'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.locationLabel(orderData['city'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.quantityLabel(orderData['servings'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Divider(color: Colors.white),
                        Text(AppLocalizations.of(context)!.addressLabel,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.doorNoLabel(orderData['door_no'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.streetNameLabel(orderData['street'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.cityLabel(orderData['city'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.pincodeLabel(orderData['pin_code'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Divider(color: Colors.white),
                        Text(AppLocalizations.of(context)!.contactDetailsLabel,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.recipientPhoneLabel(orderData['recipient_phone'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        Text(
                          AppLocalizations.of(context)!.recipientEmailLabel(orderData['email_id'] ?? 'N/A'),
                          style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Divider(color: Colors.white),
                        Text(
                          AppLocalizations.of(context)!.completedOnLabel(orderData['completed_on'] ?? 'N/A'),
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
