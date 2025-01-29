import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/repository/auth_repo/app_settings.dart';
import 'package:souq_ai/app/repository/auth_repo/settings_resp_model.dart';

import '../../repository/auth_repo/home_repo.dart';
import '../../services/shared_preferences_helper.dart';
import '../model/response_model/portfolio_summary_resp.dart';
import '../model/response_model/api_responsemodel.dart';
import '../model/response_model/profit_analysis_resp_model.dart';
import '../model/response_model/user_model.dart';

class HomeController extends GetxController {
  RxDouble fearGreedValue = 0.0.obs;
  final RxBool isPortfolioLoading = false.obs;
  final RxBool isApisLoading = false.obs;
  Rxn<ProfitPercentages> profitPercentages = Rxn<ProfitPercentages>();
  RxString currentPortfolioTotal = "0".obs;
  RxString portfolioProfit = "0".obs;
  RxString portfolioLoss = "0".obs;
  final logger = Logger();
  final RxMap<String, double> coinPercentages = <String, double>{}.obs;
  AppSetting? appSetting;

  void changeFearGreedValue(val) {
    fearGreedValue.value = val;
  }

  String calculateFearGreedIndex(val) {
    if (val <= 2 || val >= 0) {
      return 'Extreme Fear';
    } else if (val <= 4 || val >= 2) {
      return 'Fear';
    } else if (val >= 5 || val <= 6) {
      return 'Neutral';
    } else if (val >= 7 || val <= 8) {
      return 'Greed';
    } else {
      return 'Extreme Greed';
    }
  }

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

  Future<void> fetchApis() async {
    isApisLoading.value = true;
    await fetchPortfolioProfitsApi();

    await fetchUserData();
    await fetchPortfolioSummaryApi();
    isApisLoading.value = false;
  }

  Future<bool> fetchPortfolioSummaryApi() async {
    try {
      isPortfolioLoading.value = true;

      ApiResponse<PortfolioSummaryResponse>? apiResponse = await HomeRepo().fetchPortfolio();
      FearGreed? fearGreed;
      if (apiResponse != null) {
        fearGreed = apiResponse?.data?.fearGreed;
        fearGreedValue.value = fearGreed?.percentage ?? 0.0;
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

  Future<bool> fetchPortfolioProfitsApi() async {
    try {
      //  isPortfolioLoading.value = true;

      ApiResponse<ProfitPercentagesResponse>? apiResponse = await HomeRepo().fetchProfits();
      if (apiResponse.data != null) {
        profitPercentages.value = apiResponse?.data?.profitPercentages;
        return true;
      } else {
        logger.w('portfolio response is null');
        return false;
      }
    } catch (e, stack) {
      logger.e('Error during portfolio: $e', error: e, stackTrace: stack);
      return false;
    } finally {
      //isPortfolioLoading.value = false;
    }
  }
}
