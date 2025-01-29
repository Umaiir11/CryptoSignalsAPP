import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:souq_ai/app/repository/auth_repo/auth_repo.dart';

import '../../../services/shared_preferences_helper.dart';
import '../../model/response_model/api_responsemodel.dart';
import '../../model/response_model/user_model.dart';

class AccountDeletionController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();

  RxBool currentPasswordVisibility = true.obs;

  void toggleCurrentPasswordVisibility() {
    currentPasswordVisibility.value = !currentPasswordVisibility.value;
    HapticFeedback.selectionClick();
  }

  final logger = Logger();

  final RxBool isDeleteLoading = false.obs;
  final RxBool isLoading = false.obs;
  User? userData;

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      userData = await SharedPreferencesService().readUserData();

      if (userData == null) {
        logger.w("User is Null");
      } else {
        logger.i('User email: ${userData!.email}');
      }
    } catch (e, stackTrace) {
      logger.e('Error during user data check: $e, Stack $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteAccount() async {
    try {
      isDeleteLoading.value = true;

      ApiResponse<String>? apiResponse = await AuthRepo().deleteUserApi(currentPasswordController.text, userData?.id);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        // selectedSymbolId = null;
        await SharedPreferencesService().clearAllPreferences();
        return true;
      } else {
        logger.w('Login response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during Login: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isDeleteLoading.value = false;
    }
  }
}
