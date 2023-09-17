// ToDO step 1 create model in firebase

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String passsword;
  final String? imageUrl;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.passsword,
    required this.phoneNo,
    this.imageUrl, // Initialize it as null in the constructor
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": passsword,
      "ImageUrl": imageUrl,
    };
  }
}
