import 'package:feed_the_needy/Needer_pages/Needer_profile_page.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:feed_the_needy/services/push_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AvailableFoodPage extends StatefulWidget {
  @override
  _AvailableFoodPageState createState() => _AvailableFoodPageState();
}

class _AvailableFoodPageState extends State<AvailableFoodPage> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedType = 'All';
  int _selectedServings = 0;
  DateTime? _selectedTime;
  double _selectedDistance = 0.0;

// Stream to fetch available food
  Stream<QuerySnapshot> _getAvailableFood() {
    Query query = FirebaseFirestore.instance
        .collection('food_available')
        .where('status', isEqualTo: 'available')
        .orderBy('created_at', descending: true);

    if (_searchQuery.isNotEmpty) {
      query = query
          .where('food_name', isGreaterThanOrEqualTo: _searchQuery)
          .where('food_name', isLessThanOrEqualTo: _searchQuery + '\uf8ff');
    }

    if (_selectedCategory != 'All') {
      query = query.where('food_category', isEqualTo: _selectedCategory);
    }

    if (_selectedType != 'All') {
      query = query.where('food_type', isEqualTo: _selectedType);
    }

    if (_selectedServings > 0) {
      query =
          query.where('servings', isGreaterThanOrEqualTo: _selectedServings);
    }

    if (_selectedTime != null) {
      query = query.where('created_at',
          isGreaterThanOrEqualTo: Timestamp.fromDate(_selectedTime!));
    }

    // Assuming distance is calculated and stored in the database
    if (_selectedDistance > 0.0) {
      query = query.where('distance', isLessThanOrEqualTo: _selectedDistance);
    }

    return query.snapshots();
  }

  // Function to check if the needer has already requested the food
  Future<bool> _hasRequestedFood(String foodId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('food_requests')
        .where('food_id', isEqualTo: foodId)
        .where('needer_id', isEqualTo: _currentUser?.uid)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Function to show filter options
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: _selectedCategory,
                    items: <String>[
                      'All',
                      'Veg',
                      'Non-Veg',
                      'both veg and Non-veg'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: _selectedType,
                    items: <String>[
                      'All',
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
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Wrap(
                spacing: 8.0,
                children: [50, 100, 200, 300, 400, 500].map((int value) {
                  return ChoiceChip(
                    label: Text('$value Servings'),
                    selected: _selectedServings == value,
                    onSelected: (selected) {
                      setState(() {
                        _selectedServings = selected ? value : 0;
                      });
                    },
                  );
                }).toList(),
              ),
              const Divider(
                thickness: 1,
              ),
              Wrap(
                spacing: 8.0,
                children: [10.0, 20.0, 30.0, 50.0].map((double value) {
                  return ChoiceChip(
                    label: Text('${value.toInt()} km'),
                    selected: _selectedDistance == value,
                    onSelected: (selected) {
                      setState(() {
                        _selectedDistance = selected ? value : 0.0;
                      });
                    },
                  );
                }).toList(),
              ),
              const Divider(
                thickness: 0.6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'All';
                        _selectedType = 'All';
                        _selectedServings = 0;
                        _selectedTime = null;
                        _selectedDistance = 0.0;
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.clearFilters,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),

                      padding: const EdgeInsets.all(
                          12.0), // Add some padding for better touch target
                      child: Text(
                        AppLocalizations.of(context)!.applyFilters,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color:
                              Colors.white, // Example: Customize the text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to check if any filter is applied
  bool _isFilterApplied() {
    return _selectedCategory != 'All' ||
        _selectedType != 'All' ||
        _selectedServings > 0 ||
        _selectedTime != null ||
        _selectedDistance > 0.0;
  }

  void _showDonorDetails(Map<String, dynamic> foodData) async {
    final donorId = foodData['donor_id'];
    final donorSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(donorId).get();
    final donorData = donorSnapshot.data();

    if (donorData != null) {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        showDragHandle: true,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Container(
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60, // Size of the avatar
                          backgroundColor:
                              Colors.blueGrey, // Background color of the avatar
                          child: Icon(
                            Icons.person,
                            size: 40, // Icon size
                            color: Colors.white, // Icon color
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "AUTHORIZED USER",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 20,
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Text(
                      "Donor Name:  ${donorData['name']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),

                    Text(
                      "Phone Number:  ${donorData['phone']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    Text(
                      "Donor Email:  ${donorData['emailId']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    Text(
                      "Organisation Name:  ${donorData['organisationName']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    Text(
                      "Organisation Type:  ${donorData['organisationType']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    const Divider(
                      thickness: 0.5,
                    ),
                    Text(
                      "Organisation Address:  ${donorData['doorNo']},${donorData['street']},${donorData['city']},${donorData['district']},${donorData['pincode']}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    const Divider(
                      thickness: 0.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Add more donor details as needed
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  // Function to request food
  Future<void> _requestFood(Map<String, dynamic> foodData) async {
    try {
      DocumentReference requestRef =
          FirebaseFirestore.instance.collection('food_requests').doc();

      await requestRef.set({
        'request_id': requestRef.id,
        'food_id': foodData['food_id'],
        'food_name': foodData['food_name'],
        'donor_id': foodData['donor_id'],
        'needer_id': _currentUser?.uid,
        'needer_name': _currentUser?.displayName,
        'status': 'pending',
        'created_at': FieldValue.serverTimestamp(),
        'donor_name': foodData['donor_name'], // Assuming donor details exist
        'organization_name': foodData['organization_name'],
        'servings': foodData['servings'],
      });

      await sendNotificationToDocId(
        title: "New Request For Your Food!",
        message:
            "Check Out The New Request From The Needer Who Waiting for ur Acceptance",
        docId: foodData['donor_id'],
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.requestSentSuccess)),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorSendingRequest(e.toString()))),
      );
    }
  }

  // Function to check user profile
  Future<bool> _isUserProfileComplete() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser?.uid)
        .get();
    final userData = userDoc.data();
    return userData != null &&
        userData.containsKey('name') &&
        userData.containsKey('emailId');
  }

  // Function to get address from coordinates
  Future<String> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      return "Address not available";
    }
    return "Address not available";
  }

  // Food details page
  void _navigateToFoodDetails(Map<String, dynamic> foodData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              title: const Text(
                'Food Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              )),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<String>(
              future: _getAddressFromCoordinates(
                foodData['latitude'],
                foodData['longitude'],
              ),
              builder: (context, snapshot) {
                String address = snapshot.data ?? "Loading address...";
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Food-ID: ${foodData['food_id']}",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Food Name: ${foodData['food_name']}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text("Description: ${foodData['description']}"),
                    Text("Servings: ${foodData['servings']}"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 10),
                    Text("Food Type: ${foodData['food_type']}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("Food Category: ${foodData['food_category']}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("Package Type: ${foodData['packaging_type']}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("Food Condition: ${foodData['food_condition']}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("Serve Witthin: ${foodData['serve_within']}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                    Text(
                      "Location: $address",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Cooked Time: "),
                        Text(
                          DateFormat('dd-MM-yyyy – kk:mm')
                              .format(foodData['created_at'].toDate()),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        _showDonorDetails(foodData);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.purple.shade400
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Show Donor Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: FutureBuilder<bool>(
            future: _hasRequestedFood(foodData['food_id']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Lottie.asset('assets/loading.json'));
              }
              final hasRequested = snapshot.data ?? false;
              return InkWell(
                onTap: hasRequested
                    ? null
                    : () async {
                        bool isProfileComplete = await _isUserProfileComplete();
                        if (!isProfileComplete) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NeederProfilePage()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please complete your profile before requesting food')),
                          );
                          return;
                        }

                        bool? confirmed = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Request'),
                              content: Text(
                                  'Are you sure you want to request this food?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); // Cancel
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // Confirm
                                  },
                                  child: Text('Request'),
                                ),
                              ],
                            );
                          },
                        );
                        if (confirmed == true) {
                          _requestFood(foodData);
                        }
                      },
                borderRadius: BorderRadius.circular(
                    12), // Match container's border radius
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: hasRequested
                        ? LinearGradient(
                            colors: [
                              Colors.grey.shade400,
                              Colors.grey.shade600,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.purple.shade400,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    boxShadow: hasRequested
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Text(
                      hasRequested ? 'Food Requested' : 'Request Food',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.availableFoodSearch,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: _showFilterOptions,
                    ),
                    if (_isFilterApplied())
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getAvailableFood(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Lottie.asset('assets/loading.json',
                          height: 150, width: 150));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No food available at the moment. Try Using Different Filters',
                    ),
                  );
                }

                final foodDocs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: foodDocs.length,
                  itemBuilder: (context, index) {
                    final foodData =
                        foodDocs[index].data() as Map<String, dynamic>;
                    foodData['food_id'] = foodDocs[index].id;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 15,
                        child: InkWell(
                          onTap: () => _navigateToFoodDetails(foodData),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.purpleAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Food-Name: ${foodData['food_name']}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 0.5,
                                      ),
                                      Text(
                                        "Description: ${foodData['description']}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Food Type: ${foodData['food_type']}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Food Category: ${foodData['food_category']}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Servings: ${foodData['servings']}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 0.5,
                                      ),
                                      Text(
                                        "Food-ID: ${foodData['food_id']}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Uploaded on:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[300]),
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy – kk:mm').format(
                                          foodData['created_at'].toDate()),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
