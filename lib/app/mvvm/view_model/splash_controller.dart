import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/mvvm/model/response_model/user_model.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../services/shared_preferences_helper.dart';


class SplashController extends GetxController with SingleGetTickerProviderMixin {
  var isLoading = true.obs;
  Logger logger = Logger();
  User? userData;

  Future<void> checkUserData() async {
    try {
      isLoading.value = true;
      userData = await SharedPreferencesService().readUserData();

      if (userData == null) {
        Get.offNamed(AppRoutes.signInView);
      } else {
        logger.i('User email: ${userData!.email}');
        Get.offNamed(AppRoutes.navbarView);

      }
    } catch (e, stackTrace) {
      logger.e('Error during user data check: $e, Stack $stackTrace');
      Get.offNamed(AppRoutes.signInView);
    } finally {
      isLoading.value = false;
    }
  }
}
