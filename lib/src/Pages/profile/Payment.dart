// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my/src/constants/imageStrings.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Define the form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key to the form
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage(tvisaLogo),
                      width: 32,
                      height: 20,
                    ),
                    SizedBox(
                        width:
                            8), // You can adjust the spacing between the image and text
                    Flexible(
                      child: Text(
                        'Enter Your Billing Details and benefit from latest Gpt update!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey), // Customize border style
                    borderRadius:
                        BorderRadius.circular(8), // Customize border radius
                  ),
                  child: Text(
                    '18 \$ will be deducted from your account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red, // Customize text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(labelText: 'Card Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a card number';
                    }
                    if (value.length != 4) {
                      return 'Card number should be a 4-digit number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _expiryDateController,
                  decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an expiry date';
                    }

                    // Define a regular expression pattern for "MM/YY" format
                    final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}$');

                    if (!dateRegex.hasMatch(value)) {
                      return 'Please enter a valid expiry date in MM/YY format';
                    }

                    // Extract the month from the entered value
                    final List<String> parts = value.split('/');
                    final int? month = int.tryParse(parts[0]);

                    // Check if the month is in the valid range (01 to 12)
                    if (month == null || month < 1 || month > 12) {
                      return 'Please enter a valid month (01 to 12)';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _cvvController,
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    prefixIcon: Icon(
                      Icons
                          .lock, // Replace with the icon or logo you want to use
                      color: Colors.grey, // Customize the color as needed
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the CVV';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final cardNumber = _cardNumberController.text;
                      final expiryDate = _expiryDateController.text;
                      final cvv = _cvvController.text;

                      final user = _auth.currentUser;

                      if (user != null) {
                        final uid = user.uid;

                        final paymentData = {
                          'uid':
                              uid, // Include the user's UID in the payment data
                          'cardNumber': cardNumber,
                          'expiryDate': expiryDate,
                          'cvv': cvv,
                          // Add more payment-related fields as needed
                        };

                        // Add payment data to the "payments" collection using the user's UID as the document ID
                        await _firestore
                            .collection('payments')
                            .doc(uid)
                            .set(paymentData);

                        // Update the user's "billing" field to reference their payment document
                        await _firestore.collection('Users').doc(uid).update({
                          'billing': _firestore.collection('payments').doc(uid),
                        });

                        // Your payment processing logic can go here

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                '18 \$ were deducted from your account, Congrats!'),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Save Payment Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
