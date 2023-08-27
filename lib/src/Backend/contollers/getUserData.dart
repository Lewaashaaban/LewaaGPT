import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Future<Map<String, dynamic>> getUserDataForCurrentUser() async {
//   try {
//     // Get the current user's UID from Firebase Authentication
//     String? uid = FirebaseAuth.instance.currentUser?.uid;

//     if (uid != null) {
//       final userDoc =
//           await FirebaseFirestore.instance.collection('Users').doc(uid).get();

//       if (userDoc.exists) {
//         // Return the user data directly instead of assigning to a global variable
//         return {'userData': userDoc.data(), 'errorMessage': null};
//       } else {
//         return {'userData': null, 'errorMessage': 'User data not found.'};
//       }
//     } else {
//       return {'userData': null, 'errorMessage': 'User not authenticated.'};
//     }
//   } catch (error) {
//     // Return the error message
//     return {'userData': null, 'errorMessage': 'An error occurred: $error'};
//   }
// }

Future<Map<String, dynamic>> getUserDataForCurrentUser() async {
  try {
    // Get the current user's UID from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        // Retrieve creation time from the user object's metadata
        final creationTime = user.metadata.creationTime;

        return {
          'userData': userDoc.data(),
          'creationTime': creationTime,
          'errorMessage': null,
        };
      } else {
        return {'userData': null, 'errorMessage': 'User data not found.'};
      }
    } else {
      return {'userData': null, 'errorMessage': 'User not authenticated.'};
    }
  } catch (error) {
    return {'userData': null, 'errorMessage': 'An error occurred: $error'};
  }
}
