// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:feed_the_needy/services/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class DonorUploadPage extends StatefulWidget {
  const DonorUploadPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DonorUploadPageState createState() => _DonorUploadPageState();
}

class _DonorUploadPageState extends State<DonorUploadPage> {
  final _foodNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _servingsController = TextEditingController();
  final _doorNoController = TextEditingController();
  final _streetController = TextEditingController();
  final _nearWhereController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _pincodeController = TextEditingController();

  String? _selectedFoodType;
  String? _selectedFoodCategory; // New field for Food Category
  String? _selectedFoodCondition; // New field for Food Condition
  String? _selectedPackagingType; // New field for Packaging Type
  DateTime? _cookedAt;
  bool _acceptedGuidelines = false;
  String? _addressOption = 'current'; // Default to 'current'
  String? _selectedServeWithin;
  bool _gpsFetched = false;
  Position? _currentPosition;
  bool _isUploading = false;
  bool _isFetchingGPS = false;
  final List<String> _foodTypes = [
    'Freshly Cooked Food',
    'Packaged Food',
    'Bakery Items',
    'Fruits and Vegetables',
    'Dairy Products',
    'Grains and Staples',
    'Beverages',
    'Frozen or Refrigerated Food',
    'Surplus Food from Events',
    'Custom Food Donations',
  ];

  final List<String> _foodCategories = [
    'Veg',
    'Non-Veg'
  ]; // Food Category options
  final List<String> _foodConditions = [
    'Fresh',
    'Ready to serve',
    'Other'
  ]; // Food Condition options
  final List<String> _packagingTypes = [
    'Packed',
    'Unpacked'
  ]; // Packaging Type options

  final List<String> _serveWithinOptions = [
    '2 hours',
    '4 hours',
    '6 hours',
    '12 hours',
    '24 hours',
    '48 hours',
  ];

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      _cookedAt =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() {
      _isFetchingGPS = true; // Start showing progress indicator
    });

    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _currentPosition = position;
          _gpsFetched = true;
        });
      } catch (e) {}
    } else {}

    setState(() {
      _isFetchingGPS = false; // Stop showing progress indicator
    });
  }

  // Method to check if the profile is complete

  Future<void> _uploadFoodDetails() async {
    if (_foodNameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _servingsController.text.isEmpty ||
        _selectedFoodType == null ||
        _selectedServeWithin == null ||
        _cookedAt == null ||
        !_acceptedGuidelines ||
        (_addressOption == 'current' && !_gpsFetched) ||
        _selectedFoodCategory == null || // Check for Food Category
        _selectedFoodCondition == null || // Check for Food Condition
        _selectedPackagingType == null) {
      // Check for Packaging Type
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in all fields and accept the guidelines'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Check if profile is complet

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not authenticated'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      DocumentReference foodRef =
          FirebaseFirestore.instance.collection('food_available').doc();

      Map<String, dynamic> foodData = {
        'food_name': _foodNameController.text,
        'description': _descriptionController.text,
        'servings': int.tryParse(_servingsController.text),
        'food_type': _selectedFoodType,
        'food_category': _selectedFoodCategory, // Save Food Category
        'food_condition': _selectedFoodCondition, // Save Food Condition
        'packaging_type': _selectedPackagingType, // Save Packaging Type
        'serve_within': _selectedServeWithin,
        'cooked_at': _cookedAt,
        'donor_id': user.uid,
        'food_id': foodRef.id,
        'status': 'available',
        'created_at': FieldValue.serverTimestamp(),
      };

      if (_addressOption == 'current' && _gpsFetched) {
        foodData['latitude'] = _currentPosition?.latitude;
        foodData['longitude'] = _currentPosition?.longitude;
      } else if (_addressOption == 'manual') {
        foodData['door_no'] = _doorNoController.text;
        foodData['street'] = _streetController.text;
        foodData['near_where'] = _nearWhereController.text;
        foodData['city'] = _cityController.text;
        foodData['district'] = _districtController.text;
        foodData['pincode'] = _pincodeController.text;
      }

      await foodRef.set(foodData);
      await sendPushNotification(
        title: "New Food Available!",
        message: "Check out the newly uploaded food items in your area.",
        targetTag: "Food Needer",
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
          return Center(
            child: Lottie.asset(
              'assets/success.json',
              repeat: false,
            ),
          );
        },
      );

      _foodNameController.clear();
      _descriptionController.clear();
      _servingsController.clear();
      _doorNoController.clear();
      _streetController.clear();
      _nearWhereController.clear();
      _cityController.clear();
      _districtController.clear();
      _pincodeController.clear();

      setState(() {
        _selectedFoodType = null;
        _selectedFoodCategory = null; // Reset Food Category
        _selectedFoodCondition = null; // Reset Food Condition
        _selectedPackagingType = null; // Reset Packaging Type
        _cookedAt = null;
        _acceptedGuidelines = false;
        _gpsFetched = false;
        _addressOption = 'current';
        _selectedServeWithin = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading food details: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Upload Food Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Other fields

              _buildCard(
                child: TextField(
                  controller: _foodNameController,
                  decoration: const InputDecoration(labelText: 'Food Name'),
                ),
              ),
              _buildCard(
                child: DropdownButtonFormField<String>(
                  value: _selectedFoodType,
                  onChanged: (value) {
                    setState(() {
                      _selectedFoodType = value;
                    });
                  },
                  items: _foodTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Food Type'),
                ),
              ),
              _buildCard(
                child: DropdownButtonFormField<String>(
                  value: _selectedFoodCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedFoodCategory = value;
                    });
                  },
                  items: _foodCategories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Food Category'),
                ),
              ),
              _buildCard(
                child: DropdownButtonFormField<String>(
                  value: _selectedFoodCondition,
                  onChanged: (value) {
                    setState(() {
                      _selectedFoodCondition = value;
                    });
                  },
                  items: _foodConditions.map((condition) {
                    return DropdownMenuItem(
                      value: condition,
                      child: Text(condition),
                    );
                  }).toList(),
                  decoration:
                      const InputDecoration(labelText: 'Food Condition'),
                ),
              ),
              _buildCard(
                child: DropdownButtonFormField<String>(
                  value: _selectedPackagingType,
                  onChanged: (value) {
                    setState(() {
                      _selectedPackagingType = value;
                    });
                  },
                  items: _packagingTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration:
                      const InputDecoration(labelText: 'Packaging Type'),
                ),
              ),
              _buildCard(
                child: DropdownButtonFormField<String>(
                  value: _selectedServeWithin,
                  onChanged: (value) {
                    setState(() {
                      _selectedServeWithin = value;
                    });
                  },
                  items: _serveWithinOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Serve Within'),
                ),
              ),
              _buildCard(
                child: TextField(
                  controller: _servingsController,
                  decoration:
                      const InputDecoration(labelText: 'Number of Servings'),
                  keyboardType: TextInputType.number,
                ),
              ),
              _buildCard(
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      labelText:
                          'Description(Tell about ur variety of dishes...)'),
                  maxLines: 3,
                ),
              ),
              _buildCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _cookedAt == null
                          ? 'When was the food cooked?'
                          : 'Cooked At: ${DateFormat.yMMMd().add_jm().format(_cookedAt!)}',
                    ),
                    TextButton(
                      onPressed: _pickDateTime,
                      child: const Text('Pick Date & Time'),
                    ),
                  ],
                ),
              ),

              _buildCard(
                child: Row(
                  children: [
                    Radio<String>(
                      value: 'current',
                      groupValue: _addressOption,
                      onChanged: (value) {
                        setState(() {
                          _addressOption = value;
                        });
                      },
                    ),
                    const Expanded(child: Text('Use current GPS address')),
                    Radio<String>(
                      value: 'manual',
                      groupValue: _addressOption,
                      onChanged: (value) {
                        setState(() {
                          _addressOption = value;
                        });
                      },
                    ),
                    const Expanded(child: Text('Enter manual address')),
                  ],
                ),
              ), // Display the InkWell button to fetch GPS only if the "current" address option is selected
              if (_addressOption == 'current' && !_gpsFetched) ...[
                _buildCard(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _isFetchingGPS =
                            true; // Start showing the progress indicator
                      });

                      await _fetchCurrentLocation();

                      setState(() {
                        _isUploading =
                            false; // Stop showing the progress indicator
                      });

                      if (_gpsFetched) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('GPS location fetched'),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Failed to fetch GPS'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: _isFetchingGPS
                            ? Colors.grey
                            : Colors.black, // Disable button color if uploading
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: _isUploading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            )
                          : const Text(
                              'Fetch Current GPS',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Text color
                              ),
                            ),
                    ),
                  ),
                ),
              ],
              if (_gpsFetched) ...[
                _buildCard(
                  child: const Row(
                    children: [
                      Icon(Icons.safety_check),
                      Text(
                        'GPS location fetched successfully!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (_addressOption == 'manual') ...[
                _buildCard(
                  child: TextField(
                    controller: _doorNoController,
                    decoration: const InputDecoration(labelText: 'Door No'),
                  ),
                ),
                _buildCard(
                  child: TextField(
                    controller: _streetController,
                    decoration: const InputDecoration(labelText: 'Street'),
                  ),
                ),
                _buildCard(
                  child: TextField(
                    controller: _nearWhereController,
                    decoration: const InputDecoration(labelText: 'Near Where'),
                  ),
                ),
                _buildCard(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                ),
                _buildCard(
                  child: TextField(
                    controller: _districtController,
                    decoration: const InputDecoration(labelText: 'District'),
                  ),
                ),
                _buildCard(
                  child: TextField(
                    controller: _pincodeController,
                    decoration: const InputDecoration(labelText: 'Pincode'),
                  ),
                ),
              ],
              _buildCard(
                child: Row(
                  children: [
                    Checkbox(
                      value: _acceptedGuidelines,
                      onChanged: (value) {
                        setState(() {
                          _acceptedGuidelines = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I confirm that the food is hygienic, safe to eat, and follows the NGO\'s donation guidelines.',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () async {
                    if (_addressOption == 'current' && !_gpsFetched) {
                      await _fetchCurrentLocation();
                      if (_gpsFetched) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('GPS location fetched'),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Failed to fetch GPS'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                    if (_gpsFetched || _addressOption == 'manual') {
                      setState(() {
                        _isUploading = true; // Show the progress indicator
                      });
                      await _uploadFoodDetails();
                      setState(() {
                        _isUploading =
                            false; // Hide the progress indicator after upload
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.black26
                      .withOpacity(0.2), // Optional for a ripple effect
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black, // Background color
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center, // Centers the text
                      child: _isUploading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Upload Food',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Text color
                              ),
                            ))),
            ],
          ),
        ));
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xffEAD6EE), Color(0xffA0F1EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
