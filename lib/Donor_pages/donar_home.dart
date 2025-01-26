// ignore_for_file: use_build_context_synchronously

import 'package:feed_the_needy/Donor_pages/Donor_main.dart';
import 'package:feed_the_needy/Donor_pages/Donor_profile.dart';
import 'package:feed_the_needy/pages/Language_selection.dart';
import 'package:feed_the_needy/pages/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeFoodDonor extends StatelessWidget {
  const HomeFoodDonor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          AppLocalizations.of(context)!.homeTitle,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
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
      body: const DonorMainPage(),
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
                                  builder: (context) => DonorProfilePage()),
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
      onTap: onTap,
    );
  }
}
Future<void> signOutUser(BuildContext context) async {
  try {
    // Handle Google Sign-Out
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      // Disconnect and sign out the Google account
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
    }

    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Navigate to the onboarding screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  } catch (e) {
    print('Error signing out: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.signOutError,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

