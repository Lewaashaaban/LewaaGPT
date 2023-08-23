import 'package:get/get.dart';
import 'package:my/src/Pages/welcomePage.dart';
import 'package:my/src/repository/auth_repsitory/auth_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<bool> verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    return isVerified;
  }

  void processOTPVerification(String otp) async {
    bool isVerified = await verifyOTP(otp);

    if (isVerified) {
      Get.offAll(const WelcomeScreen());
    } else {
      // Show a snackbar or alert dialog to indicate incorrect verification code
      Get.snackbar(
        'Incorrect Verification Code',
        'The verification code you entered is incorrect. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
