import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';

class CurrentDeliveryPage extends StatefulWidget {
  @override
  _CurrentDeliveryPageState createState() => _CurrentDeliveryPageState();
}

class _CurrentDeliveryPageState extends State<CurrentDeliveryPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  final List<String> deliveryStatusOrder = [
    'Partner Accepted',
    'Food Verified', 
    'Food Picked Up from Donor', 
    'Out for Delivery', 
    'Delivery in Progress', 
    'Delivered'
  ];

  final Map<String, StatusUpdateConfig> statusTransitions = {
    'Partner Accepted': StatusUpdateConfig(
      nextStatus: 'Food Verified', 
      requiresAction: true,
      actionLabel: 'Verify Food',
      actionIcon: Icons.check_circle_outline,
      requiresPhoto: true,
      requiresNotes: true,
      notePrompt: 'Food Verification Notes',
    ),
    'Food Verified': StatusUpdateConfig(
      nextStatus: 'Food Picked Up from Donor', 
      requiresAction: true,
      actionLabel: 'Pickup Confirmation',
      actionIcon: Icons.local_shipping,
      requiresPhoto: true,
      requiresNotes: true,
      notePrompt: 'Pickup Notes',
    ),
    'Food Picked Up from Donor': StatusUpdateConfig(
      nextStatus: 'Out for Delivery', 
      requiresAction: true,
      actionLabel: 'Start Delivery',
      actionIcon: Icons.navigation,
      requiresPhoto: false,
      requiresNotes: true,
      notePrompt: 'Delivery Preparation Notes',
    ),
    'Out for Delivery': StatusUpdateConfig(
      nextStatus: 'Delivery in Progress', 
      requiresAction: true,
      actionLabel: 'Begin Delivery',
      actionIcon: Icons.local_shipping,
      requiresPhoto: false,
      requiresNotes: true,
      notePrompt: 'Delivery Progress Notes',
    ),
    'Delivery in Progress': StatusUpdateConfig(
      nextStatus: 'Delivered', 
      requiresAction: true,
      actionLabel: 'Complete Delivery',
      actionIcon: Icons.check_circle,
      requiresPhoto: true,
      requiresNotes: true,
      notePrompt: 'Delivery Completion Notes',
    ),
  };

  double _calculateProgressValue(String currentStatus) {
    int currentIndex = deliveryStatusOrder.indexOf(currentStatus);
    return (currentIndex + 1) / deliveryStatusOrder.length;
  }

  String _getProgressLabel(String currentStatus) {
    int currentIndex = deliveryStatusOrder.indexOf(currentStatus);
    return '${currentIndex + 1}/${deliveryStatusOrder.length} Steps';
  }

  Future<void> updateDeliveryStatus(DocumentSnapshot delivery) async {
    final currentStatus = delivery['status'];
    final config = statusTransitions[currentStatus];

    if (config == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot update status further')),
      );
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => StatusUpdateDialog(
        currentStatus: currentStatus,
        config: config,
        imagePicker: _picker,
      ),
    );

    if (result == null) return;

    try {
      Map<String, dynamic> updateData = {
        'status': config.nextStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (result['photoPath'] != null) {
        updateData['statusUpdatePhoto'] = result['photoPath'];
      }
      if (result['notes'] != null) {
        updateData['statusUpdateNotes'] = result['notes'];
      }

      await _firestore.collection('current_delivery').doc(delivery.id).update(updateData);

      if (config.nextStatus == 'Delivered') {
        await _firestore.collection('completed_delivery').add({
          ...delivery.data() as Map<String, dynamic>,
          ...updateData,
          'deliveredAt': FieldValue.serverTimestamp(),
        });

        await _firestore.collection('current_delivery').doc(delivery.id).delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Status updated to "${config.nextStatus}"'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> openGoogleMaps(String locationId, {bool isDeliveryLocation = false}) async {
    try {
      DocumentSnapshot documentData;
      double latitude;
      double longitude;

      if (isDeliveryLocation) {
        documentData = await _firestore.collection('current_delivery').doc(locationId).get();
        
        String fullAddress = [
          documentData['door_no'] ?? '',
          documentData['street'] ?? '',
          documentData['city'] ?? '',
          documentData['pin_code'] ?? ''
        ].where((part) => part.isNotEmpty).join(', ');

        List<Location> locations = await locationFromAddress(fullAddress);
        
        latitude = locations.first.latitude;
        longitude = locations.first.longitude;
      } else {
        documentData = await _firestore.collection('food_available').doc(locationId).get();
        latitude = documentData['latitude'];
        longitude = documentData['longitude'];
      }

      String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
      
      final Uri url = Uri.parse(googleMapsUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch Google Maps')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching location: $e')),
      );
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(backgroundColor: Colors.white,
   
    body: SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('current_delivery')
                .where('partnerId', isEqualTo: _auth.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
          
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                      children: [
                        SizedBox(height: 150),
                        
                        Lottie.asset('assets/coffee.json', height: 200, width: 200),
                      SizedBox(height: 50),
                        Text(
                          'No Active Delivery',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                         Text(
                          'We will Notify you when you get a delivery',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                );
                
              }
          
              DocumentSnapshot delivery = snapshot.data!.docs.first;
              Map<String, dynamic> deliveryData = delivery.data() as Map<String, dynamic>;
              String currentStatus = deliveryData['status'];
          
              // List of statuses where the button should be shown
              final List<String> showButtonStatuses = [
                'Food Picked Up from Donor',
                'Out for Delivery',
                'Delivery in Progress',
              ];
          
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(color: const Color.fromARGB(255, 215, 231, 238),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            children: [
                              Text(
                                'Delivery Progress',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: deliveryStatusOrder.map((status) {
                                  bool isCompleted = deliveryStatusOrder.indexOf(status) < deliveryStatusOrder.indexOf(currentStatus);
                                  bool isCurrentStatus = status == currentStatus;
                                  
                                  return Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: isCompleted 
                                              ? Colors.green 
                                              : (isCurrentStatus ? Colors.orange : Colors.grey),
                                            shape: BoxShape.circle,
                                          ),
                                          child: isCompleted 
                                            ? Icon(Icons.check, color: Colors.white, size: 12) 
                                            : null,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          status.split(' ').last, 
                                          style: TextStyle(
                                            fontSize: 10, 
                                            color: isCompleted 
                                              ? Colors.green 
                                              : (isCurrentStatus ? Colors.orange : Colors.grey)
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: _calculateProgressValue(currentStatus),
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                minHeight: 10,
                              ),
                              SizedBox(height: 8),
                              Text(
                                _getProgressLabel(currentStatus),
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        
                        Divider(),
                        Text('Current Status: $currentStatus',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        
                        Text('Delivery Id: ${deliveryData['delivery_id']}',
                            style: TextStyle(fontSize: 16)),
                        Text('Location: ${deliveryData['city'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        Text('Recipient Name: ${deliveryData['recipient_name'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        Text('Quantity: ${deliveryData['servings'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 16),
                        Divider(),
                        Text('Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Door No: ${deliveryData['door_no'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        Text('Street Name: ${deliveryData['street'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        Text('City: ${deliveryData['city'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        Text('Pincode: ${deliveryData['pin_code'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 16),
                        Divider(),
                        Text('Contact Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Phone: ${deliveryData['recipient_phone'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16)),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Email: ${deliveryData['email_id'] ?? 'N/A'}', 
                                style: TextStyle(fontSize: 16)
                              ),
                            ],
                          ),
                        ),
                        Text('delivery charge: ${deliveryData['delivery_charge'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 17)),
                             Text('payment_method: ${deliveryData['payment_method'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 17)),
                        SizedBox(height: 16),
                        if (currentStatus == 'Partner Accepted') ...[
                          InkWell(
                            onTap: () => openGoogleMaps(deliveryData['food_id']),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'View Food Location',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                        if (showButtonStatuses.contains(currentStatus)) ...[
                          InkWell(
                            onTap: () => openGoogleMaps(delivery.id, isDeliveryLocation: true),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'View Delivery Location',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () => updateDeliveryStatus(delivery),
                            icon: Icon(statusTransitions[currentStatus]?.actionIcon ?? Icons.update),
                            label: Text(
                              statusTransitions[currentStatus]?.actionLabel ?? 'Update Status', 
                              style: TextStyle(fontSize: 16)
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}}


// StatusUpdateConfig and StatusUpdateDialog classes remain the same as in the previous implementation

class StatusUpdateConfig {
  final String nextStatus;
  final bool requiresAction;
  final String actionLabel;
  final IconData actionIcon;
  final bool requiresPhoto;
  final bool requiresNotes;
  final String? notePrompt;

  const StatusUpdateConfig({
    required this.nextStatus,
    required this.requiresAction,
    required this.actionLabel,
    required this.actionIcon,
    required this.requiresPhoto,
    required this.requiresNotes,
    this.notePrompt,
  });
}

class StatusUpdateDialog extends StatefulWidget {
  final String currentStatus;
  final StatusUpdateConfig config;
  final ImagePicker imagePicker;

  const StatusUpdateDialog({
    Key? key,
    required this.currentStatus,
    required this.config,
    required this.imagePicker,
  }) : super(key: key);

  @override
  _StatusUpdateDialogState createState() => _StatusUpdateDialogState();
}

class _StatusUpdateDialogState extends State<StatusUpdateDialog> {
  String? photoPath;
  TextEditingController notesController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await widget.imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        photoPath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: Colors.white,
      title: Text('Currently: ${widget.currentStatus}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.config.requiresPhoto) ...[
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.camera_alt),
                label: Text('Capture Photo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              if (photoPath != null)Image.file(File(photoPath!), height: 100),
            ],

            if (widget.config.requiresNotes) ...[
              SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  labelText: widget.config.notePrompt ?? 'Additional Notes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if ((widget.config.requiresPhoto && photoPath == null) ||
                (widget.config.requiresNotes && notesController.text.isEmpty)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please complete all required fields'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            Navigator.of(context).pop({
              'photoPath': photoPath,
              'notes': notesController.text,
            });
          },
          child: Text('Confirm ${widget.config.actionLabel}', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}