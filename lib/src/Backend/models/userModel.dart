import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String passsword;
  final String? imageUrl;
  final DocumentReference? billing;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.passsword,
    required this.phoneNo,
    this.billing,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'Email': email,
      'Phone': phoneNo,
      'Password': passsword,
      'ImageUrl': imageUrl,
      'Billing': billing,
    };
  }
}
