import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../repository/auth_repo/auth_repo.dart';
import '../../../services/shared_preferences_helper.dart';
import '../../model/bodymodel/signup_bodymodel.dart';
import '../../model/response_model/api_responsemodel.dart';
import '../../model/response_model/user_model.dart';

class SignUpController extends GetxController {
  final RxBool isSignUpLoading = false.obs;
  RxBool passwordVisibility = true.obs;
  RxBool confirmPasswordVisibility = true.obs;
  RxBool termAndConditions = false.obs;
  bool fieldsValidate = false;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rx<File?> rXfile = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();
  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisibility.value = !confirmPasswordVisibility.value;
  }

  void toggleTermsAndConditions(bool val) {
    termAndConditions.value = val;
  }



  Future<bool> pickImageFromGallery() async {
    try {
      rXfile.value = null;
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        rXfile.value = File(pickedFile.path);
        print('Image path: ${rXfile.value?.path}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error picking image: $e');
      return false;
    }
  }

  Future<bool> pickImageFromCamera() async {
    try {
      rXfile.value = null;
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        rXfile.value = File(pickedFile.path);

        print('Image path: ${rXfile.value?.path}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error picking image: $e');
      return false;
    }
  }

  SignupBodyModel createSignUpBarnBody() {
    return SignupBodyModel(
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        number: phoneNumberController.text,
        profileImage: rXfile.value);
  }
  final logger = Logger();

  void clearData() {
    isSignUpLoading.value = false;
    passwordVisibility.value = true;
    confirmPasswordVisibility.value = true;
    termAndConditions.value = false;
    fieldsValidate = false;

    phoneNumberController.clear();
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    rXfile.value = null;
  }

  Future<bool> signUp() async {
    try {
      isSignUpLoading.value = true;

      SignupBodyModel signupBodyModel = createSignUpBarnBody();

      ApiResponse<UserData>? apiResponse = await AuthRepo().signUpApi(signupBodyModel);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        await SharedPreferencesService().saveUserData(apiResponse.data?.user ?? User());
        await SharedPreferencesService().saveToken(apiResponse.data?.token ?? "");
        clearData();
        return true;
      } else {
        logger.w('Signup response is null');
        return false;
      }

    } catch (e, stack) {
      logger.e('Error during signup: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isSignUpLoading.value = false;
    }
  }
}
