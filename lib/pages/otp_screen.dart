// ignore_for_file: use_build_context_synchronously

import 'package:feed_the_needy/Delivery_parntner/delivery_partnerHome.dart';
import 'package:feed_the_needy/Donor_pages/donar_home.dart';
import 'package:feed_the_needy/Needer_pages/needer_home.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:feed_the_needy/pages/role_selection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;

  OTPScreen({required this.verificationId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          l10n.otpScreenTitle,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset(
                  'assets/otp.json',
                  height: 200,
                  width: 200,
                  repeat: false,
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: l10n.enterOtp,
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final otp = _otpController.text.trim();
                    if (otp.isEmpty) {
                      _showSnackBar(context, l10n.otpEmpty, Colors.red);
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      // Authenticate the user with the provided OTP
                      final credential = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otp,
                      );

                      final userCredential = await FirebaseAuth.instance
                          .signInWithCredential(credential);

                      final user = userCredential.user;
                      if (user != null) {
                        final userDoc = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get();

                        if (userDoc.exists) {
                          final role = userDoc.get('role');
                          if (role == 'unknown') {
                            // Navigate to Role Selection Page if the role is not set
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoleSelectionPage(),
                              ),
                            );
                          } else {
                            // Navigate to the corresponding home screen based on the role
                            _navigateToHome(role, context);
                          }
                        } else {
                          // If user document does not exist, create it and navigate to role selection
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .set({'role': 'unknown'});

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RoleSelectionPage(),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      _showSnackBar(
                          context, 'Error verifying OTP: $e', Colors.red);
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.black, // Button color
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        l10n.verifyOtp,
                        style: const TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 18, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                    ),
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

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _navigateToHome(String role, BuildContext context) {
    switch (role) {
      case 'Food Donor':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeFoodDonor(),
          ),
        );
        break;
      case 'Food Needer':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeFoodNeeder(),
          ),
        );
        break;
      case 'Delivery Partner':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DeliveryPartnerHome(),
          ),
        );
        break;
      default:
        _showSnackBar(context, 'Invalid role assigned', Colors.red);
        break;
    }
  }
}
