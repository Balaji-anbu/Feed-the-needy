import 'package:feed_the_needy/Needer_pages/Delivery_register.dart';
import 'package:feed_the_needy/Needer_pages/delivery_track.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({Key? key}) : super(key: key);

  // Replace with your Firebase query function
  Stream<QuerySnapshot> _getNeederRequests() {
    return FirebaseFirestore.instance.collection('food_requests').snapshots();
  }

  void _showRequestDetails(BuildContext context,
      Map<String, dynamic> requestData, Color bottomSheetColor) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor:
          bottomSheetColor, // Set the bottom sheet color dynamically
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.requestDetails,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text("${AppLocalizations.of(context)!.requestIdLabel}: ${requestData['request_id'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.foodIdLabel}: ${requestData['food_id'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.foodNameLabel}: ${requestData['food_name'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.donorIdLabel}: ${requestData['donor_id'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.neederIdLabel}: ${requestData['needer_id'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.neederNameLabel}: ${requestData['needer_name'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.statusLabel}: ${requestData['status'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.createdAtLabel}: ${requestData['created_at'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.donorNameLabel}: ${requestData['donor_name'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.organizationNameLabel}: ${requestData['organization_name'] ?? 'N/A'}"),
                Text("${AppLocalizations.of(context)!.servingsLabel}: ${requestData['servings'] ?? 'N/A'}"),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blue), // Border color
                          color:
                              Colors.black, // You can customize the color here
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 16, // Text size
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getCardColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green.shade100; // Light green
      case 'rejected':
        return Colors.orange.shade100; // Light orange
      case 'pending':
        return Colors.blueGrey.shade100; // Light grayish-blue
      default:
        return Colors.white; // Default if none of the statuses match
    }
  }

  Color _getBottomSheetColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green.shade200; // Light green for accepted
      case 'rejected':
        return Colors.orange.shade100; // Light orange for rejected
      case 'pending':
        return Colors.blueGrey.shade200; // Light blue-grey for pending
      default:
        return Colors.white; // Default if none of the statuses match
    }
  }

  // Add a new method to check if delivery form is submitted
  bool _isDeliveryFormSubmitted(Map<String, dynamic> requestData) {
    return requestData.containsKey('delivery_form_submitted') &&
        requestData['delivery_form_submitted'] == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _getNeederRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:
                  Lottie.asset('assets/loading.json', height: 170, width: 170),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No requests found.'),
            );
          }

          final requestDocs = snapshot.data!.docs;

          // Sort the documents based on the status and delivery option
          requestDocs.sort((a, b) {
            bool deliveryA =
                _isDeliveryFormSubmitted(a.data() as Map<String, dynamic>);
            bool deliveryB =
                _isDeliveryFormSubmitted(b.data() as Map<String, dynamic>);

            if (deliveryA && !deliveryB) return -1;
            if (!deliveryA && deliveryB) return 1;

            String statusA = a['status'] ?? '';
            String statusB = b['status'] ?? '';

            if (statusA == 'accepted') return -1;
            if (statusB == 'accepted') return 1;

            if (statusA == 'pending') return -1;
            if (statusB == 'pending') return 1;

            return 0; // No change for 'rejected'
          });

          return ListView.builder(
            itemCount: requestDocs.length,
            itemBuilder: (context, index) {
              final requestData =
                  requestDocs[index].data() as Map<String, dynamic>;
              String status = requestData['status'] ?? 'N/A';

              // Determine the background color based on the status
              Color cardColor = _getCardColor(status);
              Color bottomSheetColor = _getBottomSheetColor(status);

              return Card(
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
                elevation: 4.0,
                color:
                    cardColor, // Set the background color based on the status
                child: InkWell(
                  onTap: () => _showRequestDetails(
                      context, requestData, bottomSheetColor),
                  child: Stack(
                    children: [
                      // Conditionally display Lottie animation only when the status is 'accepted'
                      if (status == 'accepted')
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: LottieBuilder.asset(
                              'assets/accepted.json',
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill, // Fills the entire card
                              repeat: false, // Animation plays only once
                            ),
                          ),
                        ),
                      // Content overlaying the animation
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Request ID: ${requestData['request_id'] ?? 'N/A'}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: status == 'rejected'
                                    ? Colors.red
                                    : Colors
                                        .black, // Text color based on status
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Status: $status",
                              style: TextStyle(
                                color: status == 'rejected'
                                    ? Colors.red
                                    : status == 'accepted'
                                        ? Colors.green
                                        : Colors.blueGrey, // Status text color
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            if (status == 'accepted' &&
                                !_isDeliveryFormSubmitted(requestData))
                              InkWell(
                                onTap: () {
                                  // Action for selecting delivery option
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0)),
                                    ),
                                    backgroundColor:
                                        bottomSheetColor, // Set bottom sheet color dynamically
                                    builder: (context) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.chooseDeliveryOption,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const SizedBox(height: 16),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Action for self-pickup
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    Text(AppLocalizations.of(context)!.selfPickup),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Action for home delivery
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoorDeliveryPage(
                                                        foodRequestId: requestData[
                                                                'request_id'] ??
                                                            'N/A', // Ensure it's safe
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child:
                                                    Text(AppLocalizations.of(context)!.homeDelivery),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                      ),
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        AppLocalizations.of(context)!.chooseDeliveryOption,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (_isDeliveryFormSubmitted(requestData))
                              Center(
                                  child: ElevatedButton(
                                onPressed: () async {
                                  // Get the delivery ID from your data
                                  String deliveryId =
                                      requestData['delivery_id'] ?? 'N/A';

                                  // Check if the delivery ID is valid
                                  if (deliveryId == 'N/A' ||
                                      deliveryId.isEmpty) {
                                    // Handle the case where the delivery ID is invalid
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Invalid delivery ID!')),
                                    );
                                    return; // Exit early to avoid making an invalid Firestore query
                                  }

                                  // Fetch data from Firestore's 'home_delivery' collection
                                  var deliveryData = await FirebaseFirestore
                                      .instance
                                      .collection('home_delivery')
                                      .doc(deliveryId)
                                      .get();

                                  // Check if the document exists
                                  if (deliveryData.exists) {
                                    // Navigate to the DeliveryTrackingPage with the fetched data
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DeliveryTrackingPage(
                                          deliveryId:
                                              deliveryId, // Pass the fetched data
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Handle the case where the delivery data doesn't exist
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Delivery not found!')),
                                    );
                                  }
                                },
                                child: Text(AppLocalizations.of(context)!.trackDelivery),
                              ))
                          ],
                        ),
                      ),
                    ],
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
