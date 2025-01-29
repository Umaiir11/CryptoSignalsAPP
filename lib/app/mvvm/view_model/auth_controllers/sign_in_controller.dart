import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../repository/auth_repo/auth_repo.dart';
import '../../../services/shared_preferences_helper.dart';
import '../../model/bodymodel/login_body_model.dart';
import '../../model/response_model/api_responsemodel.dart';
import '../../model/response_model/user_model.dart';

class SignInController extends GetxController {
  RxBool obscureText = true.obs;
  RxBool isValidPhoneAndPass = true.obs;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RxBool isSignInLoading = false.obs;
  bool fieldsValidate = false;

  void changeObscureText() {
    obscureText.value = !obscureText.value;
  }

  final logger = Logger();

  LoginBodyModel createSignUpBarnBody() {
    return LoginBodyModel(
      number: phoneNumberController.text,
      password: passwordController.text,
    );
  }

  Future<bool> login() async {
    try {
      isSignInLoading.value = true;

      LoginBodyModel loginBodyModel = createSignUpBarnBody();

      ApiResponse<UserData>? apiResponse = await AuthRepo().loginApi(loginBodyModel);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        await SharedPreferencesService().saveUserData(apiResponse.data?.user ?? User());
        await SharedPreferencesService().saveToken(apiResponse.data?.token ?? "");
        return true;
      } else {
        logger.w('Login response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during Login: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isSignInLoading.value = false;
    }
  }
}
