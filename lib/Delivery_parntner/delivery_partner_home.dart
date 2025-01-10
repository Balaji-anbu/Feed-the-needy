import 'package:feed_the_needy/Delivery_parntner/delivery_details.dart';
import 'package:feed_the_needy/Delivery_parntner/orders_to_deliver.dart';
import 'package:feed_the_needy/Delivery_parntner/partner_dashBoard.dart';
import 'package:feed_the_needy/Delivery_parntner/partner_profile.dart';
import 'package:feed_the_needy/pages/Language_selection.dart';
import 'package:feed_the_needy/pages/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryPartnerHome extends StatefulWidget {
  const DeliveryPartnerHome({super.key});

  @override
  _DeliveryPartnerHomeState createState() => _DeliveryPartnerHomeState();
}

class _DeliveryPartnerHomeState extends State<DeliveryPartnerHome> {
  int _currentIndex = 0;

  // Pages for each bottom navigation item
  final List<Widget> _pages = [
    const DeliveryPartnerDashboardPage(), // Home page
    const DeliveryPartnerPage(), // New orders page
    // Placeholder for the current orders page
    const DeliveryDetailsPage(
      deliveryData: {},
      deliveryId: '',
    ), // Will be replaced after fetching data
  ];

  // Function to fetch delivery data from Firestore based on deliveryId
  Future<Map<String, dynamic>> fetchDeliveryData(String deliveryId) async {
    try {
      // Fetching delivery data from Firestore (replace with your Firestore path)
      var deliveryDoc = await FirebaseFirestore.instance
          .collection('deliveries')
          .doc(deliveryId)
          .get();

      if (deliveryDoc.exists) {
        return deliveryDoc.data() ?? {};
      } else {
        throw Exception('Delivery data not found');
      }
    } catch (e) {
      throw Exception('Error fetching delivery data: $e');
    }
  }

  // Function to navigate to delivery details page
  void navigateToDeliveryDetails(String deliveryId) async {
    try {
      // Fetch the delivery data based on deliveryId
      var deliveryData = await fetchDeliveryData(deliveryId);

      // Navigate to DeliveryDetailsPage with fetched delivery data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeliveryDetailsPage(
            deliveryId: deliveryId,
            deliveryData: deliveryData, // Pass the fetched data
          ),
        ),
      );
    } catch (e) {
      // Handle any errors, such as if the delivery data is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching delivery data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Welcome, Home!",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              color: Colors.white,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: _buildFullWidthDrawer(context),
      endDrawerEnableOpenDragGesture: false,
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.new_releases),
            label: AppLocalizations.of(context)!.newOrders,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            label: AppLocalizations.of(context)!.currentOrders,
          ),
        ],
      ),
    );
  }

  SafeArea _buildFullWidthDrawer(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final phoneNumber = user?.phoneNumber?.replaceFirst('+91', '') ?? 'Unknown';

    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 221, 208, 208),
                    Color.fromARGB(255, 134, 230, 198)
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person,
                        size: 37, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hey!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(255, 68, 67, 67)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DeliveryPartnerProfilePage()),
                            );
                          },
                          child: const Text(
                            'My Profile',
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Example usage of navigateToDeliveryDetails function
            _buildDrawerItem(
              context,
              Icons.list_alt,
              'View Delivery Details',
              () => navigateToDeliveryDetails('yourDeliveryIdHere'),
            ),
            _buildDrawerItem(context, Icons.history,
                AppLocalizations.of(context)!.transactionHistory, () {}),
            _buildDrawerItem(context, Icons.track_changes,
                AppLocalizations.of(context)!.trackStatus, () {}),
            _buildDrawerItem(context, Icons.chat,
                AppLocalizations.of(context)!.islChatbot, () {}),
            _buildDrawerItem(context, Icons.settings,
                AppLocalizations.of(context)!.settings, () {}),
            _buildDrawerItem(
                context, Icons.language, AppLocalizations.of(context)!.language,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LanguageSelectionPage()),
              );
            }),
            _buildDrawerItem(context, Icons.help,
                AppLocalizations.of(context)!.helpAndSupport, () {}),
            _buildDrawerItem(context, Icons.star,
                AppLocalizations.of(context)!.rateUs, () {}),
            _buildDrawerItem(context, Icons.info,
                AppLocalizations.of(context)!.aboutUs, () {}),
            _buildDrawerItem(
                context, Icons.logout, AppLocalizations.of(context)!.signOut,
                () async {
              await signOutUser(context);
            }, isLogout: true),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(
        title,
        style: TextStyle(
            color: isLogout ? Colors.red : Colors.black, fontSize: 14),
      ),
      onTap: isLogout
          ? () {
              // Show confirmation dialog for logout
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Sign Out'),
                    content: Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          onTap(); // Perform the actual sign-out
                        },
                        child: Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          : onTap,
    );
  }
}

Future<void> signOutUser(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  } catch (e) {
    print('Error signing out: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${AppLocalizations.of(context)!.signOutError}'),
      ),
    );
  }
}
