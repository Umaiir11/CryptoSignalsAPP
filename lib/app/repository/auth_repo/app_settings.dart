import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/mvvm/model/bodymodel/changepass_bodymodel.dart';
import 'package:souq_ai/app/repository/auth_repo/settings_resp_model.dart';
import '../../config/app_routes.dart';
import '../../config/app_urls.dart';
import '../../mvvm/model/bodymodel/login_body_model.dart';
import '../../mvvm/model/bodymodel/signup_bodymodel.dart';
import '../../mvvm/model/bodymodel/update_user_bodymodel.dart';
import '../../mvvm/model/response_model/api_responsemodel.dart';
import '../../mvvm/model/response_model/user_model.dart';
import '../../services/https_service.dart';
import '../../services/json_extractor.dart';

class AppSettingsRepo {
  final logger = Logger();

  Future<ApiResponse<SettingsData>> fetchAppSettingsApi() async {
    try {
      String? endPoint = ApiUrls.appSettings;
      final response = await HttpsCalls().getApiHits(endPoint);
      return _processResponse(response, (dataJson) => SettingsData.fromJson(dataJson));
    } catch (e, stackTrace) {
      _logUnhandledError(e, stackTrace);
      rethrow;
    }
  }

  ApiResponse<T> _processResponse<T>(
    dynamic response,
    T Function(dynamic dataJson) fromJson,
  ) {
    MessageExtractor().extractAndStoreMessage('', response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return ApiResponse<T>.fromJson(
          jsonDecode(response.body),
          fromJson,
        );

      case 401:
        _handleUnauthorized();
        break;

      case 422:
        _handleError(response, "Validation Error");
        break;

      case 500:
        _handleError(response, "Internal Server Error");
        break;

      default:
        _handleError(
          response,
          "API Error: ${response.statusCode} - ${response.reasonPhrase}",
        );
    }
    throw Exception("Unexpected error occurred.");
  }

  void _handleUnauthorized() {
    logger.w("Unauthorized access. Redirecting to login.");
    Get.offAllNamed(AppRoutes.signInView);
    throw Exception("Unauthorized access. Please log in.");
  }

  void _handleError(dynamic response, String errorMessage) {
    try {
      final errorResponse = jsonDecode(response.body);
      throw Exception("$errorMessage: ${errorResponse['message'] ?? 'No details available'}");
    } catch (e) {
      logger.e("Error handling failed: $e");
      throw Exception(errorMessage);
    }
  }

  void _logUnhandledError(dynamic e, StackTrace stackTrace) {
    logger.e('Unhandled error: $e', error: e, stackTrace: stackTrace);
  }
}
