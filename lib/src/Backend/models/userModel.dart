// ToDO step 1 create model in firebase

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String passsword;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.passsword,
    required this.phoneNo,
  });

  toJson(){
    return {
      "FullName" : fullName,
      "Email" : email,
      "Phone" : phoneNo,
      "Password" : passsword,
    };
  }
}
