import 'package:get/get.dart';
import 'package:my/src/Pages/welcomePage.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();
  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(microseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(microseconds: 5000));
    Get.offAll(() => const WelcomeScreen());
  }
}
