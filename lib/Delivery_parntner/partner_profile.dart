// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_the_needy/generated/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeliveryPartnerProfilePage extends StatefulWidget {
  const DeliveryPartnerProfilePage({super.key});

  @override
  _DeliveryPartnerProfilePageState createState() =>
      _DeliveryPartnerProfilePageState();
}

class _DeliveryPartnerProfilePageState
    extends State<DeliveryPartnerProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  String? vehicleType;
  String? vehicleNumber;
  String? licenseNumber;
  String? city;
  String? district;
  String? pincode;
  String? emailId;

  bool isLoading = false;
  bool isEditable = false;
  String? phoneNumber;

  final List<String> vehicleTypes = [
    'Bike',
    'Car',
    'Van',
    'Truck',
    'Other',
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
            vehicleType = data['vehicleType'];
            vehicleNumber = data['vehicleNumber'];
            licenseNumber = data['licenseNumber'];
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
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          isLoading = true;
        });
        User? user = _auth.currentUser;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'name': name,
            'vehicleType': vehicleType,
            'vehicleNumber': vehicleNumber,
            'licenseNumber': licenseNumber,
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                  saveProfile();
                } else {
                  isEditable = true;
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      buildProfileField(AppLocalizations.of(context)!.name,
                          name, (value) => name = value),
                      const SizedBox(height: 10),
                      buildDropdownField(
                        AppLocalizations.of(context)!.vehicleType,
                        vehicleType,
                        vehicleTypes,
                        (value) => vehicleType = value,
                      ),
                      const SizedBox(height: 10),
                      buildProfileField(
                          AppLocalizations.of(context)!.vehicleNumber,
                          vehicleNumber,
                          (value) => vehicleNumber = value),
                      const SizedBox(height: 10),
                      buildProfileField(
                          AppLocalizations.of(context)!.licenseNumber,
                          licenseNumber,
                          (value) => licenseNumber = value),
                      const SizedBox(height: 10),
                      buildProfileField(AppLocalizations.of(context)!.city,
                          city, (value) => city = value),
                      const SizedBox(height: 10),
                      buildProfileField(AppLocalizations.of(context)!.district,
                          district, (value) => district = value),
                      const SizedBox(height: 10),
                      buildProfileField(AppLocalizations.of(context)!.pincode,
                          pincode, (value) => pincode = value),
                      const SizedBox(height: 10),
                      buildProfileField(AppLocalizations.of(context)!.emailId,
                          emailId, (value) => emailId = value),
                      const SizedBox(height: 10),
                      buildReadOnlyField(
                          AppLocalizations.of(context)!.phoneNumber,
                          phoneNumber),
                    ],
                  ),
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
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: isEditable ? Colors.white : Colors.grey[100],
      ),
      onChanged: onSave,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.requiredField;
        }
        return null;
      },
    );
  }

  Widget buildDropdownField(String label, String? value, List<String> items,
      Function(String?) onSave) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isEditable ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
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
        borderRadius: BorderRadius.circular(12),
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
