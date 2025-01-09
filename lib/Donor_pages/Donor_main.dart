// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_the_needy/Donor_pages/Donor_dashboard_page.dart';
import 'package:feed_the_needy/Donor_pages/Donor_food_upload.dart';
import 'package:feed_the_needy/Donor_pages/Donor_profile.dart';
import 'package:feed_the_needy/Donor_pages/Tracking_order.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonorMainPage extends StatefulWidget {
  const DonorMainPage({super.key});

  @override
  State<DonorMainPage> createState() => _DonorMainPageState();
}

class _DonorMainPageState extends State<DonorMainPage> {
  int _selectedIndex = 0; // Track the selected index for navigation
  bool isProfileComplete = true; // Flag for profile completion
  bool isLoading = false; // Loading state for async operations

  final List<Widget> _pages = [
    const DonorDashboardPage(),
    DonorTrackPage(),
  ];

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Donor Dashboard'),
        ),
        body: const Center(
          child: Text('No user logged in'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 242, 245),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: _pages[_selectedIndex], // Display the selected page
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.dashboard,
                  color: _selectedIndex == 0
                      ? Colors.lightGreenAccent
                      : Colors.white),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0; // Navigate to Dashboard
                });
              },
            ),
            const SizedBox(width: 40), // Space for FAB
            IconButton(
              icon: Icon(Icons.track_changes_outlined,
                  color: _selectedIndex == 1
                      ? Colors.lightGreenAccent
                      : Colors.white),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1; // Navigate to Track Page
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () async {
          setState(() {
            isLoading = true; // Start loading indicator
          });

          await _checkUserProfile(); // Check profile completion status

          setState(() {
            isLoading = false; // Stop loading indicator
          });

          if (!isProfileComplete) {
            // Show alert dialog if profile is incomplete
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Complete Your Profile'),
                content: const Text(
                    'Your profile is incomplete. Please complete your profile to proceed.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonorProfilePage(),
                        ),
                      );
                    },
                    child: const Text('Go to Profile'),
                  ),
                ],
              ),
            );
          } else {
            // Navigate to DonorUploadPage if profile is complete
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const DonorUploadPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0); // Start from the bottom
                  var end = Offset.zero; // End at the center
                  var curve =
                      Curves.fastEaseInToSlowEaseOut; // Smooth transition curve

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  // Apply the fade effect
                  var fadeAnimation =
                      Tween(begin: 0.0, end: 1.0).animate(animation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(opacity: fadeAnimation, child: child),
                  );
                },
              ),
            );
          }
        },
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(
                Icons.add,
                color: Colors.white,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _checkUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
          isProfileComplete = data['name'] != null &&
              data['organisationType'] != null &&
              data['organisationName'] != null &&
              data['doorNo'] != null &&
              data['street'] != null &&
              data['nearWhere'] != null &&
              data['city'] != null &&
              data['district'] != null &&
              data['pincode'] != null &&
              data['emailId'] != null;
        }
      }
    } catch (e) {
      print('Error checking user profile: $e');
      isProfileComplete = false; // Default to false if an error occurs
    }
  }
}
