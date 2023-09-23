import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key to the form
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: 'Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a card number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an expiry date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(labelText: 'CVV'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the CVV';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
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
                          content: Text('Payment information saved.'),
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
    );
  }
}
