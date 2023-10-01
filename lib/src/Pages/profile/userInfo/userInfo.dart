// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my/src/Backend/contollers/getUserData.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Map<String, dynamic>? userData;
  String? errorMessage;

  Future<void> fetchUserData() async {
    final userDataResult = await getUserDataForCurrentUser();
    setState(() {
      errorMessage = userDataResult['errorMessage'];
      if (errorMessage == null) {
        userData = userDataResult['userData'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kol khara'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              if (userData != null)
                ListTile(
                  title: Text('First Name: ${userData!['Phone']}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
