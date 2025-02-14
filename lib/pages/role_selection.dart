import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_the_needy/Delivery_parntner/delivery_partnerHome.dart';
import 'package:feed_the_needy/Donor_pages/donar_home.dart';
import 'package:feed_the_needy/Needer_pages/needer_home.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RoleSelectionPageState createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          l10n.selectRole,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.whyRoleImportant,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l10n.roleSelectionDesc,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: _isLoading ? null : () => _handleRoleSelection(l10n.foodDonorRole),
                  borderRadius: BorderRadius.circular(30),
                  child: _buildRoleButton(l10n.foodDonorRole, Colors.black),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _isLoading ? null : () => _handleRoleSelection(l10n.foodNeederRole),
                  borderRadius: BorderRadius.circular(30),
                  child: _buildRoleButton(l10n.foodNeederRole, Colors.black),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _isLoading ? null : () => _handleRoleSelection(l10n.deliveryPartnerRole),
                  borderRadius: BorderRadius.circular(30),
                  child: _buildRoleButton(l10n.deliveryPartnerRole, Colors.black),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Row(
                    children: [
                      Text(
                        l10n.note,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        l10n.cantChangeRole,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: Lottie.asset(
                'assets/loading.json',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }

  /// Builds a custom role button with modern styling.
  Widget _buildRoleButton(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Handles role selection and shows a confirmation dialog.
  Future<void> _handleRoleSelection(String role) async {
    bool isConfirmed = await _showConfirmationDialog(role);

    if (isConfirmed) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _updateUserRole(role);
        _navigateToHome(role);
      } catch (e) {
        _showErrorDialog(
            "An error occurred while updating your role. Please try again.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Shows a confirmation dialog to the user.
  Future<bool> _showConfirmationDialog(String role) async {
    final l10n = AppLocalizations.of(context)!;
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmRoleTitle),
        content: Text(l10n.confirmRoleMessage(role)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.yes),
          ),
        ],
      ),
    ) ?? false;
  }

  /// Updates the user's role, FcmToken, and phone number in Firestore and OneSignal.
  Future<void> _updateUserRole(String role) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not authenticated");
      }

      String userId = user.uid;
      String? phoneNumber = user.phoneNumber;

      // Update Firestore with the role, phone number, and FCM token.
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'role': role,
          'phone_number': phoneNumber,
          'docId': userId, // Save the phone number in Firestore.
          // Add the FcmToken field here if needed.
        },
        SetOptions(merge: true), // Merge to avoid overwriting existing data.
      );

      // Add the role and phone number as tags to OneSignal.
      OneSignal.User.addTagWithKey("role", role);
      OneSignal.User.addTagWithKey("docId", userId);

      print(
          "User role, phone number, and OneSignal tags updated successfully.");
    } catch (e) {
      print("Error updating user role or adding OneSignal tags: $e");
    }
  }

  Future<void> _navigateToHome(String role) async {
    Widget homeScreen;

    switch (role) {
      case 'Food Donor':
        homeScreen = const HomeFoodDonor();
        break;
      case 'Food Needer':
        homeScreen = const HomeFoodNeeder();
        break;
      case 'Delivery Partner':
        homeScreen = const DeliveryPartnerHome();
        break;
      default:
        throw Exception('Invalid role selected.');
    }

    // Send a notification

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => homeScreen),
    );
  }

  /// Shows an error dialog.
  void _showErrorDialog(String message) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.yes),
          ),
        ],
      ),
    );
  }
}
