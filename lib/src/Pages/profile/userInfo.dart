import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  List<String> docIDs = [];

  // Fetch document IDs and populate docIDs list
  Future<List<String>> getDocIDs() async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').get();
    return snapshot.docs.map((document) => document.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getDocIDs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If docIDs are available, you can display them or use them to fetch data for each user
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final userDocRef = FirebaseFirestore.instance
                    .collection('Users')
                    .doc(snapshot.data![index]);
                return FutureBuilder<DocumentSnapshot>(
                  future: userDocRef.get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          userSnapshot.data!.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text('FirstName: ${data['FullName']}'),
                      );
                    }
                    return ListTile(
                      title: Text('loading...'),
                    );
                  },
                );
              },
            );
          } else {
            return Text('No user data available.');
          }
        }
        return Text('loading...');
      },
    );
  }
}
