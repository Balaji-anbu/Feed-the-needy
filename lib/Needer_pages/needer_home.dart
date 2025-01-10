// ignore_for_file: use_build_context_synchronously

import 'package:feed_the_needy/Needer_pages/Needer_food_request.dart';
import 'package:feed_the_needy/Needer_pages/Needer_profile_page.dart';
import 'package:feed_the_needy/pages/Language_selection.dart';
import 'package:feed_the_needy/pages/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeFoodNeeder extends StatelessWidget {
  const HomeFoodNeeder({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Colors.purpleAccent.shade100,
              Colors.purpleAccent.shade700
            ],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          child: const Text(
            'Welcome! Home',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
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
      endDrawer: _buildFullWidthDrawer(context, screenWidth),
      endDrawerEnableOpenDragGesture: false,
      body: const NeederFoodRequestPage(),
    );
  }

  SafeArea _buildFullWidthDrawer(BuildContext context, double screenWidth) {
    final user = FirebaseAuth.instance.currentUser;
    final phoneNumber = user?.phoneNumber?.replaceFirst('+91', '') ?? 'Unknown';

    return SafeArea(
      child: Drawer(
        width: screenWidth, // Make drawer full screen width
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.1, // Adjust size dynamically
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person,
                          size: 40, color: Color.fromARGB(255, 0, 0, 0)),
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
                                fontSize: 17,
                                color: Color.fromARGB(255, 68, 67, 67)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NeederProfilePage()),
                              );
                            },
                            child: const Text(
                              'My Profile',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              _buildDrawerItem(
                context,
                Icons.history,
                AppLocalizations.of(context)!.transactionHistory,
                () {},
              ),
              _buildDrawerItem(
                context,
                Icons.track_changes,
                AppLocalizations.of(context)!.trackStatus,
                () {},
              ),
              _buildDrawerItem(
                context,
                Icons.chat,
                AppLocalizations.of(context)!.islChatbot,
                () {},
              ),
              _buildDrawerItem(
                context,
                Icons.settings,
                AppLocalizations.of(context)!.settings,
                () {},
              ),
              _buildDrawerItem(
                context,
                Icons.language,
                AppLocalizations.of(context)!.language,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LanguageSelectionPage()),
                  );
                },
              ),
              _buildDrawerItem(
                context,
                Icons.help,
                AppLocalizations.of(context)!.helpAndSupport,
                () {},
              ),
              _buildDrawerItem(
                context,
                Icons.star,
                AppLocalizations.of(context)!.rateUs,
                () {},
              ),
              _buildDrawerItem(
                context,
                Icons.info,
                AppLocalizations.of(context)!.aboutUs,
                () {},
              ),
              _buildDrawerItem(
                context,
                Icons.logout,
                AppLocalizations.of(context)!.signOut,
                () async {
                  await signOutUser(context);
                },
                isLogout: true,
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 0.5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.black54, Colors.grey, Colors.black54],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'App Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Text(
                'Copyright© 2024 Feed The Needy',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${AppLocalizations.of(context)!.signOutError}'),
      ),
    );
  }
}
