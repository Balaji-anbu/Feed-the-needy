import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_the_needy/Donor_pages/Donor_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfileCompletionCard extends StatelessWidget {
  final String userId;

  const ProfileCompletionCard({super.key, required this.userId});

  // Fetch data from Firestore for the current user
  Future<Map<String, dynamic>> _getProfileData() async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return document.data() as Map<String, dynamic>;
  }

  // Calculate profile completion percentage
  double _calculateCompletionPercentage(Map<String, dynamic> data) {
    List<String> fields = [
      'name',
      'organisationType',
      'organisationName',
      'doorNo',
      'street',
      'nearWhere',
      'city',
      'district',
      'pincode',
      'emailId'
    ];

    int filledFields = fields
        .where((field) =>
            data.containsKey(field) && data[field] != null && data[field] != '')
        .length;
    return (filledFields / fields.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text('No user logged in'));
    }

    // ignore: unused_local_variable
    String userId = currentUser.uid;

    return FutureBuilder<Map<String, dynamic>>(
      future: _getProfileData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  Lottie.asset('assets/loading.json', height: 170, width: 170));
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        Map<String, dynamic> profileData = snapshot.data!;
        double completionPercentage =
            _calculateCompletionPercentage(profileData);

        bool isProfileComplete = completionPercentage == 100.0;

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          margin: const EdgeInsets.all(15),
          child: InkWell(
            onTap: !isProfileComplete
                ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DonorProfilePage()))
                : null,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 224, 102, 202)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile Completion',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: completionPercentage / 100,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${completionPercentage.toStringAsFixed(0)}% Complete',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  if (!isProfileComplete)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DonorProfilePage())),
                        child: const Text(
                          'Complete Profile',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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
}
