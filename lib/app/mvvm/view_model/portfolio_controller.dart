import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/mvvm/model/response_model/crypto_coins_respmodel.dart';
import 'package:souq_ai/app/repository/auth_repo/portfolio_repo.dart';

import '../model/response_model/api_responsemodel.dart';
import '../model/response_model/crypto_currenices_resp_model.dart';
import '../model/response_model/crypto_symbols.dart';
import '../model/response_model/portfolio_data_resp_model.dart';

class PortfolioController extends GetxController {
  RxBool obscureText = true.obs;
  RxBool isValidPhoneAndPass = true.obs;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RxBool isPortfolioLoading = false.obs;
  final RxBool isPortfolioCurrenciesLoading = false.obs;
  final RxBool isDeleteLoading = false.obs;
  final RxBool isUpdateLoading = false.obs;
  final RxBool isAddLoading = false.obs;
  bool fieldsValidate = false;
  RxList<Portfolio>? portfolioList = <Portfolio>[].obs;
  RxList<String>? allCoinsList = <String>[].obs;
  RxList<CurrencySymbols>? allCurrenciesSymbolsList = <CurrencySymbols>[].obs;
  int? selectedPortfolioId;
  CurrencySymbols? selectedCurrency;
  int? selectedSymbolId;
  final RxMap<String, double> coinPercentages = <String, double>{}.obs;

  void changeObscureText() {
    obscureText.value = !obscureText.value;
  }

  final logger = Logger();
  RxString currentPortfolioTotal = "0".obs;
  RxString portfolioProfit = "0".obs;
  RxString portfolioLoss = "0".obs;

  Future<bool> fetchPortfolioApi() async {
    try {
      isPortfolioLoading.value = true;

      ApiResponse<PortfolioData>? apiResponse = await PortfolioRepo().fetchPortfolio();

      if (apiResponse != null) {
        portfolioList?.value = apiResponse?.data?.portfolios ?? [];
        logger.i(apiResponse.message ?? 'No message from server');
        currentPortfolioTotal?.value = apiResponse.data?.currentPortfolioTotal.toString() ?? "0";
        portfolioProfit?.value = apiResponse.data?.profitPercentage?.toString() ?? "0";
        portfolioLoss?.value = apiResponse.data?.lossPercentage?.toString() ?? "0";
        final apiCoinPercentages = apiResponse.data?.coinPercentages;
        if (apiCoinPercentages != null) {
          coinPercentages.value = apiCoinPercentages;
        }
        return true;
      } else {
        logger.w('portfolio response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during portfolio: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isPortfolioLoading.value = false;
    }
  }

  Future<bool?> deletePortfolio() async {
    try {
      isDeleteLoading.value = true;

      ApiResponse<String>? apiResponse = await PortfolioRepo().deletePortfolio(selectedPortfolioId ?? 0);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        selectedPortfolioId = null;
        return apiResponse.success;
      } else {
        logger.w('Login response is null');
        return apiResponse.success;
      }
    } catch (e, stack) {
      logger.e('Error during Login: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isDeleteLoading.value = false;
    }
  }

  Future<bool> updatePortfolio(double amount) async {
    try {
      isUpdateLoading.value = true;

      ApiResponse<PortfolioData>? apiResponse = await PortfolioRepo().updatePortfolio(selectedPortfolioId ?? 0, amount);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        selectedPortfolioId = null;
        return true;
      } else {
        logger.w('Login response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during Login: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isUpdateLoading.value = false;
    }
  }

  Future<bool> addPortfolio(double amount) async {
    try {
      isAddLoading.value = true;

      ApiResponse<PortfolioData>? apiResponse = await PortfolioRepo().addPortfolio(selectedSymbolId ?? 0, amount);

      if (apiResponse != null) {
        logger.i(apiResponse.message ?? 'No message from server');
        // selectedSymbolId = null;
        return true;
      } else {
        logger.w('Login response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during Login: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isAddLoading.value = false;
    }
  }

  Future<bool> fetchPortfolioCurrenciesSymbolsApi() async {
    try {
      isPortfolioCurrenciesLoading.value = true;
      selectedSymbolId = selectedCurrency?.id;
      ApiResponse<CurrenciesSymbolsData>? apiResponse = await PortfolioRepo().fetchPortfolioCurrencies();

      if (apiResponse != null) {
        allCurrenciesSymbolsList?.value = apiResponse?.data?.currencies ?? [];
        logger.i(apiResponse.message ?? 'No message from server');

        return true;
      } else {
        logger.w('portfolio currencies symbols response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during portfolio currencies symbols: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      isPortfolioCurrenciesLoading.value = false;
    }
  }

// Future<bool> fetchCoinsApi() async {
//   try {
//     isCoinsLoading.value = true;
//
//     ApiResponse<CryptoCoinsResponse>? apiResponse = await PortfolioRepo().fetchCoins();
//
//     if (apiResponse != null) {
//       allCoinsList?.value = apiResponse?.data?.coins ?? [];
//       logger.i(apiResponse.message ?? 'No message from server');
//
//       return true;
//     } else {
//       logger.w('coins response is null');
//       return false;
//     }
//   } catch (e, stack) {
//     logger.e('Error during coins: $e', error: e, stackTrace: stack);
//     return false;
//   } finally {
//     isCoinsLoading.value = false;
//   }
// }
}
