class PaymentModel {
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String userId; // Add a field to store the user's ID or reference

  PaymentModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.userId, // Initialize it in the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'userId': userId, // Include the user's ID or reference
    };
  }
}
