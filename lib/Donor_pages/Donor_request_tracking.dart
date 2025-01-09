import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_the_needy/services/push_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RequestTrackingPage extends StatefulWidget {
  const RequestTrackingPage({super.key});

  @override
  _RequestTrackingPageState createState() => _RequestTrackingPageState();
}

class _RequestTrackingPageState extends State<RequestTrackingPage> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> _foodRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFoodRequests();
  }

  Future<void> _fetchFoodRequests() async {
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not authenticated!")),
      );
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('food_requests')
          .where('donor_id', isEqualTo: _currentUser.uid)
          .where('status', whereIn: ['pending', 'accepted']).get();

      print("Fetched ${snapshot.docs.length} requests"); // Debug log

      List<Map<String, dynamic>> requestsWithFoodDetails = [];
      for (var doc in snapshot.docs) {
        final requestData = doc.data();
        requestData['id'] = doc.id; // Add the document ID
        print("Request data: $requestData"); // Debug log
        requestsWithFoodDetails.add(requestData);
      }

      setState(() {
        _foodRequests = requestsWithFoodDetails;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching requests: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _acceptRequest(String requestId) async {
    try {
      // Fetch the accepted request's food_id and needer_id
      final requestSnapshot = await FirebaseFirestore.instance
          .collection('food_requests')
          .doc(requestId)
          .get();

      if (!requestSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Request not found!")),
        );
        return;
      }

      final data = requestSnapshot.data();
      final foodId = data?['food_id'];
      final neederId = data?['needer_id']; // Fetch the needer_id

      if (neederId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Needer ID not found!")),
        );
        return;
      }

      // Update the status of the accepted request
      await FirebaseFirestore.instance
          .collection('food_requests')
          .doc(requestId)
          .update({
        'status': 'accepted',
      });

      // Send notification to the needer
      await sendNotificationToDocId(
        title: "Request Accepted",
        message:
            "Your request for food has been accepted! Please check the app for updates.",
        docId: neederId,
      );

      // Update all other requests with the same food_id to rejected
      final otherRequests = await FirebaseFirestore.instance
          .collection('food_requests')
          .where('food_id', isEqualTo: foodId)
          .where(FieldPath.documentId, isNotEqualTo: requestId)
          .get();

      for (var doc in otherRequests.docs) {
        await FirebaseFirestore.instance
            .collection('food_requests')
            .doc(doc.id)
            .update({'status': 'rejected'});

        // Optionally, notify other needers about rejection
        final otherNeederId = doc.data()['needer_id'];
        if (otherNeederId != null) {
          await sendNotificationToDocId(
            title: "Request Rejected",
            message:
                "Your request for food has been rejected. Please try again later.",
            docId: otherNeederId,
          );
        }
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Request accepted!")));
      _fetchFoodRequests(); // Refresh the list
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> _rejectRequest(String requestId) async {
    try {
      // Fetch the needer_id
      final requestSnapshot = await FirebaseFirestore.instance
          .collection('food_requests')
          .doc(requestId)
          .get();

      if (!requestSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Request not found!")),
        );
        return;
      }

      final neederId = requestSnapshot.data()?['needer_id'];

      if (neederId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Needer ID not found!")),
        );
        return;
      }

      // Update the status to rejected
      await FirebaseFirestore.instance
          .collection('food_requests')
          .doc(requestId)
          .update({'status': 'rejected'});

      // Send notification to the needer
      await sendNotificationToDocId(
        title: "Request Rejected",
        message:
            "Your request for food has been rejected. Please try again later.",
        docId: neederId,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Request rejected!")));
      _fetchFoodRequests(); // Refresh the list
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _showRequestDetails(Map<String, dynamic> request) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Request Details",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text("Request ID: ${request['id']}"),
              Text("Food ID: ${request['food_id']}"),
              Text("Status: ${request['status']}"),
              Text("Needer ID: ${request['needer_id']}"),
              const SizedBox(height: 16),
              if (request['status'] == 'pending') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _acceptRequest(request['id']);
                        Navigator.pop(context); // Close the modal
                      },
                      child: const Text("Accept"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _rejectRequest(request['id']);
                        Navigator.pop(context); // Close the modal
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Reject"),
                    ),
                  ],
                ),
              ] else
                Center(
                  child: Text(
                    "Request already ${request['status']}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/loading.json', width: 150, height: 150),
            const Text(
              'Loading requests...',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return _foodRequests.isEmpty
        ? const Center(child: Text('No requests found for your food'))
        : ListView.builder(
            itemCount: _foodRequests.length,
            itemBuilder: (context, index) {
              var request = _foodRequests[index];
              return GestureDetector(
                onTap: () => _showRequestDetails(request),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.purple.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request ID: ${request['id']}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Food ID: ${request['food_id']}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Status: ${request['status']}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
