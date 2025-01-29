import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/mvvm/model/bodymodel/update_user_bodymodel.dart';

import '../../repository/auth_repo/app_settings.dart';
import '../../repository/auth_repo/auth_repo.dart';
import '../../repository/auth_repo/settings_resp_model.dart';
import '../../services/shared_preferences_helper.dart';
import '../model/response_model/api_responsemodel.dart';
import '../model/response_model/user_model.dart';

class AppDrawerController extends GetxController {
  RxBool notificationsValue = false.obs;
  final Rxn<AppSetting> appSetting = Rxn<AppSetting>();

  void changeNotificationValue(val) {
    notificationsValue.value = val;
  }

  final RxBool isUserLoading = false.obs;
  final RxBool isUserDeleteLoading = false.obs;
  final RxBool isUserUpdateLoading = false.obs;
  final RxBool isSettingsLoading = false.obs;

  final logger = Logger();

  User? currentUser;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();

  Future<bool> currentUserFetch() async {
    try {
      rXfile.value = null;
      isUserLoading.value = true;

      ApiResponse<UserData>? apiResponse = await AuthRepo().fetchCurrentUserApi();

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        currentUser = apiResponse.data?.user;
        await SharedPreferencesService().saveUserData(apiResponse.data?.user ?? User());
        userNameController.text = currentUser?.name ?? "";
        userPhoneController.text = currentUser?.number ?? "";
        userEmailController.text = currentUser?.email ?? "";
        return true;
      } else {
        logger.w('current User response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during current User: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isUserLoading.value = false;
    }
  }

  Rx<File?> rXfile = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

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

  UpdateBodyModel createUpdateUser() {
    return UpdateBodyModel(name: userNameController.text, profileImage: rXfile.value);
  }

  Future<bool> updateUser() async {
    try {
      isUserUpdateLoading.value = true;

      UpdateBodyModel updateUserBodyModel = createUpdateUser();

      ApiResponse<UserData>? apiResponse = await AuthRepo().updateUserApi(updateUserBodyModel, currentUser?.id);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        await SharedPreferencesService().saveUserData(apiResponse.data?.user ?? User());

        return true;
      } else {
        logger.w('Signup response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during signup: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isUserUpdateLoading.value = false;
    }
  }

  // Future<bool> deleteCurrentUser() async {
  //   try {
  //     isUserDeleteLoading.value = true;
  //
  //     ApiResponse<String>? apiResponse = await AuthRepo().deleteCurrentUserApi();
  //
  //     if (apiResponse != null) {
  //       logger.i(apiResponse.message ?? 'No message from server');
  //       String? response = apiResponse.message;
  //       logger.i(response);
  //       return true;
  //     } else {
  //       logger.w('current User response is null');
  //       return false;
  //     }
  //   } catch (e, stack) {
  //     logger.e('Error during current User: $e', error: e, stackTrace: stack);
  //     return false;
  //   } finally {
  //     isUserDeleteLoading.value = false;
  //   }
  // }


  Future<bool> fetchAppSettingsApi() async {
    try {
        isSettingsLoading.value = true;

      ApiResponse<SettingsData>? apiResponse = await AppSettingsRepo().fetchAppSettingsApi();
      if (apiResponse.data != null) {
        appSetting.value = apiResponse?.data?.appSetting;
        return true;
      } else {
        logger.w('portfolio response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during portfolio: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isSettingsLoading.value = false;
    }
  }





}
