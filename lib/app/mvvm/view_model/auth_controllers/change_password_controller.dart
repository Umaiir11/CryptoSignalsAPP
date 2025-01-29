import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/mvvm/model/bodymodel/changepass_bodymodel.dart';

import '../../../repository/auth_repo/auth_repo.dart';
import '../../model/response_model/api_responsemodel.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final RxBool isLoading = false.obs;
  RxBool currentPasswordVisibility = true.obs;
  RxBool newPasswordVisibility = true.obs;
  RxBool confirmPasswordVisibility = true.obs;
  RxBool isChangeLoading = false.obs;
  final logger = Logger();
  bool fieldsValidate = false;


  void toggleCurrentPasswordVisibility() {
    currentPasswordVisibility.value = !currentPasswordVisibility.value;
    HapticFeedback.selectionClick();
  }

  void toggleNewPasswordVisibility() {
    newPasswordVisibility.value = !newPasswordVisibility.value;
    HapticFeedback.selectionClick();
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisibility.value = !confirmPasswordVisibility.value;
    HapticFeedback.selectionClick();
  }

  ChangePassBodyModel changePassMethod() {
    return ChangePassBodyModel(password: newPasswordController.text, passwordConfirmation: confirmPasswordController.text, oldPassword: currentPasswordController.text);
  }

  Future<bool?> changePassword() async {
    try {
      isChangeLoading.value = true;

      ChangePassBodyModel changePassBodyModel = changePassMethod();

      ApiResponse<String>? apiResponse = await AuthRepo().changePasswordApi(changePassBodyModel);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        return apiResponse.success ;
      } else {
        logger.w('Login response is null');
        return apiResponse.success ;
      }
    } catch (e, stack) {
      logger.e('Error during Login: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isChangeLoading.value = false;
    }
  }
}
