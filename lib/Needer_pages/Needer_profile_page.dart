// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NeederProfilePage extends StatefulWidget {
  const NeederProfilePage({super.key});

  @override
  _DonorProfilePageState createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<NeederProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? name;
  String? organisationType;
  String? organisationName;
  String? doorNo;
  String? street;
  String? nearWhere;
  String? city;
  String? district;
  String? pincode;
  String? emailId;

  bool isLoading = false;
  bool isEditable = false;
  String? phoneNumber;

  final List<String> organisationTypes = [
    'Childrens Home',
    'Oldage Home ',
    'Charitable Trust',
    'Shelters and Homeless ',
    'Others',
  ];

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      setState(() {
        isLoading = true;
      });
      User? user = _auth.currentUser;
      if (user != null) {
        phoneNumber = user.phoneNumber;
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
          setState(() {
            name = data['name'];
            organisationType =
                organisationTypes.contains(data['organisationType'])
                    ? data['organisationType']
                    : organisationTypes.first; // Fallback to the first item
            organisationName = data['organisationName'];
            doorNo = data['doorNo'];
            street = data['street'];
            nearWhere = data['nearWhere'];
            city = data['city'];
            district = data['district'];
            pincode = data['pincode'];
            emailId = data['emailId'];
          });
        }
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveProfile() async {
    try {
      setState(() {
        isLoading = true;
      });
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'organisationType': organisationType,
          'organisationName': organisationName,
          'doorNo': doorNo,
          'street': street,
          'nearWhere': nearWhere,
          'city': city,
          'district': district,
          'pincode': pincode,
          'emailId': emailId,
        }, SetOptions(merge: true));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.profileSaved)),
        );
      }
    } catch (e) {
      print('Error saving profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSavingProfile)),
      );
    } finally {
      setState(() {
        isLoading = false;
        isEditable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          AppLocalizations.of(context)?.profilePageTitle ?? 'Profile',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                if (isEditable) {
                  saveProfile(); // Save changes if editing is enabled
                } else {
                  isEditable = true; // Enable editing
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.center,
              child: Text(
                isEditable
                    ? AppLocalizations.of(context)?.saveProfile ?? 'Save'
                    : AppLocalizations.of(context)?.editProfile ?? 'Edit',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? SafeArea(
              child: Center(
                  child: Lottie.asset('assets/loading.json',
                      height: 170, width: 170)),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.name, name,
                        (value) => name = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildDropdownField(
                      AppLocalizations.of(context)!.organisationType,
                      organisationType,
                      organisationTypes,
                      (value) => organisationType = value,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(
                        AppLocalizations.of(context)!.organisationName,
                        organisationName,
                        (value) => organisationName = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.doorNo,
                        doorNo, (value) => doorNo = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.street,
                        street, (value) => street = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.nearWhere,
                        nearWhere, (value) => nearWhere = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.city, city,
                        (value) => city = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.district,
                        district, (value) => district = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.pincode,
                        pincode, (value) => pincode = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProfileField(AppLocalizations.of(context)!.emailId,
                        emailId, (value) => emailId = value),
                    const SizedBox(
                      height: 10,
                    ),
                    buildReadOnlyField(
                        AppLocalizations.of(context)!.phoneNumber, phoneNumber),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildProfileField(
      String label, String? value, Function(String?) onSave) {
    return TextFormField(
      initialValue: value,
      enabled: isEditable,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: isEditable ? Colors.white : Colors.grey[100],
      ),
      onChanged: onSave,
      validator: (value) => value == null || value.isEmpty
          ? AppLocalizations.of(context)!.requiredField
          : null,
    );
  }

  Widget buildDropdownField(String label, String? value, List<String> items,
      Function(String?) onSave) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isEditable ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: const Color.fromARGB(255, 156, 153, 153), width: 1),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: isEditable ? (value) => setState(() => onSave(value)) : null,
        onSaved: onSave,
        disabledHint: Text(value ?? '',
            style: const TextStyle(color: Colors.black87, fontSize: 16)),
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget buildReadOnlyField(String label, String? value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: const Color.fromARGB(255, 175, 173, 173), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 116, 116, 116),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? 'N/A',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(221, 94, 92, 92),
            ),
          ),
        ],
      ),
    );
  }
}
