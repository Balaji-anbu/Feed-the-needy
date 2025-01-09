import 'package:feed_the_needy/services/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoorDeliveryPage extends StatefulWidget {
  final String foodRequestId;

  const DoorDeliveryPage({Key? key, required this.foodRequestId})
      : super(key: key);

  @override
  _DoorDeliveryPageState createState() => _DoorDeliveryPageState();
}

class _DoorDeliveryPageState extends State<DoorDeliveryPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  int _servings = 0;
  int _deliveryCharge = 0;
  String _selectedPaymentMethod = 'UPI'; // Default payment method

  @override
  void initState() {
    super.initState();
    _fetchFoodRequestDetails();
  }

  Future<void> _fetchFoodRequestDetails() async {
    try {
      final foodRequestSnapshot = await FirebaseFirestore.instance
          .collection('food_requests')
          .doc(widget.foodRequestId)
          .get();

      if (foodRequestSnapshot.exists) {
        final data = foodRequestSnapshot.data()!;
        setState(() {
          _servings = data['servings'] ?? 0;
          _deliveryCharge = _calculateDeliveryCharge(_servings);

          // Pre-fill the form with relevant details
          _formData['food_id'] = data['food_id'];
          _formData['donor_id'] = data['donor_id'];
          _formData['needer_id'] = data['needer_id'];
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching details: $error")),
      );
    }
  }

  int _calculateDeliveryCharge(int servings) {
    if (servings <= 50) return 80;
    if (servings <= 150) return 150;
    if (servings <= 250) return 200;
    return 350;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Add delivery charge, servings, and payment method to form data
      _formData['delivery_charge'] = _deliveryCharge;
      _formData['servings'] = _servings;
      _formData['payment_method'] = _selectedPaymentMethod;
      _formData['status'] = 'Waiting for Partner';

      try {
        // Add the document and get the document reference
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection('home_delivery')
            .add(_formData);

        // Update the document with its own ID as delivery_id
        await docRef.update({'delivery_id': docRef.id});

        // Mark the delivery option as selected and form as submitted in the food request
        await FirebaseFirestore.instance
            .collection('food_requests')
            .doc(widget.foodRequestId)
            .update({
          'delivery_option_selected': true,
          'delivery_form_submitted': true,
          'delivery_id': docRef.id, // Add the delivery_id to the food request
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Delivery Details Submitted!")),
        );

        await sendPushNotification(
          title: "New Order Available!",
          message:
              "Hurry! Start Finding ur Way Because Someone is waiting for You!",
          targetTag: "Delivery Partner",
        );

        // Reset or navigate to another page
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving data: $error")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 98, 115, 213),
      appBar: AppBar(
        title: const Text("Door Delivery Details"),
        backgroundColor: const Color.fromARGB(255, 133, 88, 210),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Basic Details",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  "Recipient Name",
                  "Enter recipient name",
                  key: "recipient_name",
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  "Recipient Phone Number",
                  "Enter recipient phone number",
                  keyboardType: TextInputType.phone,
                  key: "recipient_phone",
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  "Email ID",
                  "Enter email ID",
                  keyboardType: TextInputType.emailAddress,
                  key: "email_id",
                ),
                const SizedBox(height: 32),
                const Text(
                  "Address Details",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 16),
                _buildTextField("Door No.", "Enter door number",
                    key: "door_no"),
                const SizedBox(height: 16),
                _buildTextField("Street", "Enter street", key: "street"),
                const SizedBox(height: 16),
                _buildTextField("City", "Enter city", key: "city"),
                const SizedBox(height: 16),
                _buildTextField("Pin Code", "Enter pin code",
                    keyboardType: TextInputType.number, key: "pin_code"),
                const SizedBox(height: 32),
                const Text(
                  "Payment Details",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 16),
                Text(
                  "Delivery Charge: ₹$_deliveryCharge",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: _selectedPaymentMethod,
                  items: ['UPI', 'Card', 'Cash on Delivery']
                      .map((method) => DropdownMenuItem<String>(
                            value: method,
                            child: Text(
                              method,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 12.0),
                    ),
                    child: const Text("Submit Details"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {TextInputType keyboardType = TextInputType.text, required String key}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label.";
            }
            return null;
          },
          onSaved: (value) {
            _formData[key] = value;
          },
        ),
      ],
    );
  }
}
