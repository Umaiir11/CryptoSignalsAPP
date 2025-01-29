import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/mvvm/model/response_model/portfolio_data_resp_model.dart';
import '../../config/app_routes.dart';
import '../../config/app_urls.dart';
import '../../mvvm/model/response_model/api_responsemodel.dart';
import '../../mvvm/model/response_model/crypto_currenices_resp_model.dart';
import '../../mvvm/model/response_model/crypto_symbols.dart';
import '../../services/https_service.dart';
import '../../services/json_extractor.dart';

class PortfolioRepo {
  final logger = Logger();

  Future<ApiResponse<PortfolioData>> fetchPortfolio() async {
    try {
      String? endPoint = ApiUrls.fetchPortfolio;
      final response = await HttpsCalls().getApiHits(endPoint);
      return _processResponse(response, (dataJson) => PortfolioData.fromJson(dataJson));
    } catch (e, stackTrace) {
      _logUnhandledError(e, stackTrace);
      rethrow;
    }
  }

  Future<ApiResponse<CurrenciesSymbolsData>> fetchPortfolioCurrencies() async {
    try {
      String? endPoint = ApiUrls.getSymbols;
      final response = await HttpsCalls().getApiHits(endPoint);
      return _processResponse(response, (dataJson) => CurrenciesSymbolsData.fromJson(dataJson));
    } catch (e, stackTrace) {
      _logUnhandledError(e, stackTrace);
      rethrow;
    }
  }

  Future<ApiResponse<PortfolioData>> updatePortfolio(int? portfolioId, double? amount) async {
    try {
      final Map<String, dynamic> requestBody = {
        'amount': amount,
      };
      String jsonString = json.encode(requestBody);

      String? endPoint = ApiUrls.updatePortfolio + portfolioId.toString();
      final response = await HttpsCalls().patchApiHits(endPoint, utf8.encode(jsonString));
      return _processResponse(response, (dataJson) => PortfolioData.fromJson(dataJson));
    } catch (e, stackTrace) {
      _logUnhandledError(e, stackTrace);
      rethrow;
    }
  }

  Future<ApiResponse<PortfolioData>> addPortfolio(int? symbolId, double? amount) async {
    try {
      final Map<String, dynamic> requestBody = {
        'currency_id': symbolId,
        'amount': amount,
      };
      String jsonString = json.encode(requestBody);

      String? endPoint = ApiUrls.addPortfolio;
      final response = await HttpsCalls().postApiHits(endPoint, utf8.encode(jsonString));
      return _processResponse(response, (dataJson) => PortfolioData.fromJson(dataJson));
    } catch (e, stackTrace) {
      _logUnhandledError(e, stackTrace);
      rethrow;
    }
  }

  Future<ApiResponse<String>> deletePortfolio(int portfolioId) async {
    try {
      String? endPoint = ApiUrls.deletePortfolio + portfolioId.toString();

      final response = await HttpsCalls().deleteApiHits(endPoint,null);

      return _processResponse(response, (dataJson) => dataJson as String? ?? '');
    } catch (e, stackTrace) {
      _logUnhandledError(e, stackTrace);
      rethrow;
    }
  }

  // Future<ApiResponse<PortfolioData>> fetchCoins() async {
  //   try {
  //     String? endPoint = ApiUrls.fetchCoins;
  //     final response = await HttpsCalls().getApiHits(endPoint);
  //     return _processResponse(response, (dataJson) => PortfolioData.fromJson(dataJson));
  //   } catch (e, stackTrace) {
  //     _logUnhandledError(e, stackTrace);
  //     rethrow;
  //   }
  // }

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
