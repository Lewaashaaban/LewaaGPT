import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my/src/Pages/chat/chatScreen.dart';
// import 'package:my/src/Pages/homepage.dart';
import 'package:my/src/Pages/welcomePage.dart';
import 'package:my/src/repository/auth_repsitory/exceptions/login_email_passsword_failure.dart';
import 'package:my/src/repository/auth_repsitory/exceptions/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => WelcomeScreen())
        : Get.offAll(() => ChatScreen());
  }

// FUNC
  Future<void> phoneAuthentication(String phoneNo) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendTOken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('error', 'The provided phone number is not valid');
        } else {
          Get.snackbar('error', 'Something went wrong, try again!');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPasssword(
      String email, String password, String phone) async {
    try {
      // Step 1: Create user with email and password
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Step 2: Send SMS verification to phone and verify it
      await phoneAuthentication(phone);

      // Step 3: After phone verification, update the email in the authentication identifier
      if (_auth.currentUser != null) {
        await _auth.currentUser!.updateEmail(email);
      }

      // Step 4: Navigate to appropriate screen based on user's status
      if (firebaseUser.value != null) {
        Get.offAll(() => ChatScreen());
      } else {
        Get.to(() => WelcomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignupWithEmailAndPasswordFailure();
      print('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LoginWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = LoginWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
