// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:feed_the_needy/Donor_pages/Donor_request_tracking.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class DonorTrackPage extends StatefulWidget {
  const DonorTrackPage({super.key});

  @override
  _DonorTrackPageState createState() => _DonorTrackPageState();
}

class _DonorTrackPageState extends State<DonorTrackPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.lightGreenAccent,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: const Icon(Icons.fastfood), text: AppLocalizations.of(context)!.uploadFoodDetails),
                Tab(icon: const Icon(Icons.receipt), text: AppLocalizations.of(context)!.requestDetails),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                UploadedFoodPage(),
                RequestTrackingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UploadedFoodPage extends StatefulWidget {
  const UploadedFoodPage({super.key});

  @override
  _UploadedFoodPageState createState() => _UploadedFoodPageState();
}

class _UploadedFoodPageState extends State<UploadedFoodPage> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> _uploadedFood = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUploadedFood();
  }

  Future<void> _getUploadedFood() async {
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.userNotAuthenticated)));
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('food_available')
          .where('donor_id', isEqualTo: _currentUser.uid)
          .get();

      setState(() {
        _uploadedFood = snapshot.docs.map((doc) => doc.data()).toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching uploaded food: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showFoodDetails(Map<String, dynamic> food) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 710,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.uploadedFoodDetail,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.foodId(food['food_id']),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(thickness: 0.5),
                  Text(
                    AppLocalizations.of(context)!.foodName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.descriptionHint,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.servingsCount(food['servings']),
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.5),
                  Text(AppLocalizations.of(context)!.foodType,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.packagingType,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.foodCategory,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.foodCondition,
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.5),
                  Text(AppLocalizations.of(context)!.cookedAt(food['cooked_at'].toDate()),
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.uploadedAtLabel(food['created_at'].toDate()),
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  const Divider(thickness: 0.5),
                  Image.asset(
                    'assets/food1.webp', // Replace with actual image URL or shuffled logic
                    height: 280,

                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.statusLabel(food['status']),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: food['status'] == 'available'
                                ? Colors.green
                                : (food['status'] == 'unavailable' ||
                                        food['status'] == 'deleted')
                                    ? Colors.red
                                    : Colors.black, // Default color for other statuses
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            // Show the dialog for reason selection
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String? selectedReason; // To store the selected reason
                                return AlertDialog(
                                  title: Text(AppLocalizations.of(context)!.selectDeletionReason),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RadioListTile<String>(
                                        title: Text(AppLocalizations.of(context)!.foodDistributed),
                                        value: AppLocalizations.of(context)!.foodDistributed,
                                        groupValue: selectedReason,
                                        onChanged: (value) {
                                          selectedReason = value;
                                          Navigator.pop(context, value);
                                        },
                                      ),
                                      RadioListTile<String>(
                                        title: Text(AppLocalizations.of(context)!.foodSpoiled),
                                        value: AppLocalizations.of(context)!.foodSpoiled,
                                        groupValue: selectedReason,
                                        onChanged: (value) {
                                          selectedReason = value;
                                          Navigator.pop(context, value);
                                        },
                                      ),
                                      RadioListTile<String>(
                                        title: Text(AppLocalizations.of(context)!.notAvailable),
                                        value: AppLocalizations.of(context)!.notAvailable,
                                        groupValue: selectedReason,
                                        onChanged: (value) {
                                          selectedReason = value;
                                          Navigator.pop(context, value);
                                        },
                                      ),
                                      RadioListTile<String>(
                                        title: Text(AppLocalizations.of(context)!.others),
                                        value: AppLocalizations.of(context)!.others,
                                        groupValue: selectedReason,
                                        onChanged: (value) {
                                          selectedReason = value;
                                          Navigator.pop(context, value);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).then((reason) async {
                              if (reason != null) {
                                // Proceed with deletion if a reason is selected
                                await FirebaseFirestore.instance
                                    .collection('food_available') // Replace with your food collection name
                                    .doc(food['food_id']) // Replace with the document ID
                                    .update({
                                  'status': 'unavailable',
                                  'reason_of_deletion': reason, // Store reason of deletion
                                });

                                // Move the food to a separate collection for deleted food
                                await FirebaseFirestore.instance
                                    .collection('deleted_food') // New collection for deleted food
                                    .doc(food['food_id'])
                                    .set({
                                  ...food,
                                  'reason_of_deletion': reason, // Add the reason here
                                });

                                // Delete the food from the main collection
                                await FirebaseFirestore.instance
                                    .collection('food_available')
                                    .doc(food['food_id'])
                                    .delete();

                                // Find and delete related document in the 'food_request' collection
                                final querySnapshot = await FirebaseFirestore.instance
                                    .collection('food_requests') // Replace with your food_request collection name
                                    .where('food_id', isEqualTo: food['food_id']) // Match the food_id
                                    .get();

                                for (var doc in querySnapshot.docs) {
                                  await doc.reference.delete(); // Delete each matching document
                                }

                                // Show confirmation message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.orange,
                                    content: Text(AppLocalizations.of(context)!.foodDeletedSuccess),
                                  ),
                                );
                              } else {
                                // If no reason is selected
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(AppLocalizations.of(context)!.selectDeletionReason),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.deleteFood,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
            Text(
              AppLocalizations.of(context)!.loadingUploadedFood,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return _uploadedFood.isEmpty
        ? Center(child: Text(AppLocalizations.of(context)!.noFoodUploaded))
        : ListView.builder(
            itemCount: _uploadedFood.length,
            itemBuilder: (context, index) {
              var food = _uploadedFood[index];
              // Shuffle the images
              List<String> foodImages = [
                'assets/food1.webp',
                'assets/food2.webp',
                'assets/food3.webp',
                'assets/food4.webp',
                // Add more image assets as needed
              ];
              foodImages.shuffle(); // Shuffle the list of images

              return InkWell(
                onTap: () => _showFoodDetails(food), // Show full details on tap
                child: Card(
                  elevation: 20,
                  margin: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xffEAD6EE), Color(0xffA0F1EA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.foodName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(AppLocalizations.of(context)!.statusLabel(food['status'])),
                                const SizedBox(height: 6),
                                Text(AppLocalizations.of(context)!.servingsCount(food['servings'])),
                                const SizedBox(height: 6),
                                Text(AppLocalizations.of(context)!.foodType),
                                const SizedBox(height: 6),
                                Text(AppLocalizations.of(context)!.uploadedAtLabel(food['created_at'].toDate())),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            flex: 3,
                            child: Image.asset(
                              foodImages.first, // Show the first shuffled image
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill,
                            ),
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
