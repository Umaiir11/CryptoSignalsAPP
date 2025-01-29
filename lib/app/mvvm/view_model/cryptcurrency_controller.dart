import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../repository/auth_repo/crypto_repo.dart';
import '../model/response_model/api_responsemodel.dart';
import '../model/response_model/crypto_currenices_resp_model.dart';

class CryptocurrencyController extends GetxController {
  Map<String, double> dataMap = {
    "Halal": 0.0,
    "Questionable": 0.0,
    "Haram": 0.0,
  };
  final logger = Logger();
  RxList<Currency> currenciesList = <Currency>[].obs;
  final ScrollController scrollController = ScrollController(); // ScrollController
  RxBool showPieChart = false.obs;
  int? apiPageNumber;
  int pageNumber = 1;
  final RxBool hasMoreData = true.obs;
  final RxBool isLoading = false.obs;
  int totalFetchedItems = 0;
  final RxBool isBottomLoading = false.obs;
  final RxBool isCurrencyDetailsLoading = false.obs;
  String? selectedTab;
  Currency? currencyDetailsModel;

  Future<void> fetchInstitutes(int page) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isBottomLoading.value = true;
      }

      ApiResponse<CurrenciesData>? apiResponse = await CryptoRepo().fetchCurrencies(
        page,
        selectedTab?.toLowerCase(),
      );

      if (apiResponse != null && apiResponse.data != null) {
        List<Currency>? newInstitutes = apiResponse.data!.currencies;
        Percentages? percentages = apiResponse.data!.percentages;

        logger.i("Selected TAB: ${selectedTab}");

        if (newInstitutes != null) {
          currenciesList.addAll(newInstitutes);
          dataMap = {
            "Halal": percentages?.halal?.toDouble() ?? 0.0,
            "Questionable": percentages?.questionable?.toDouble() ?? 0.0,
            "Haram": percentages?.haram?.toDouble() ?? 0.0,
          };
          apiPageNumber = apiResponse.data?.pagination?.lastPage ?? page;
          totalFetchedItems += newInstitutes.length;
          hasMoreData.value = page < apiPageNumber!;
        } else {
          hasMoreData.value = false;
        }
      } else {
        hasMoreData.value = false;
        logger.w("API response or data is null");
      }
    } catch (e) {
      logger.e("Error fetching institutes: $e");
      hasMoreData.value = false;
    } finally {
      isLoading.value = false;
      isBottomLoading.value = false;
    }
  }

  Future<void> loadMoreData() async {
    logger.i("Pagination Info: lastPage=${apiPageNumber}, currentPage=$pageNumber");
    if (!hasMoreData.value || isBottomLoading.value || (apiPageNumber != null && pageNumber >= apiPageNumber!)) {
      hasMoreData.value = false;
      return;
    }

    // Increment page and fetch data
    pageNumber++;
    await fetchInstitutes(pageNumber);
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && hasMoreData.value && !isBottomLoading.value) {
        loadMoreData();
      }
    });
  }

  // Future<bool> currencyDetails(int currencyId) async {
  //   try {
  //     isCurrencyDetailsLoading.value = true;
  //
  //
  //     ApiResponse<Currency>? apiResponse = await CryptoRepo().fetchCurrencyDetails(currencyId);
  //
  //     if (apiResponse.data != null) {
  //       logger.i(apiResponse.message ?? 'No message from server');
  //       currencyDetailsModel = apiResponse.data;
  //
  //       return true;
  //     } else {
  //       logger.w('currencyDetails response is null');
  //       return false;
  //     }
  //   } catch (e, stack) {
  //     logger.e('Error during currencyDetails: $e', error: e, stackTrace: stack);
  //     return false;
  //   } finally {
  //     isCurrencyDetailsLoading.value = false;
  //   }
  // }

  void resetPagination() {
    pageNumber = 1;
    currenciesList.clear();
    hasMoreData.value = true;
    totalFetchedItems = 0;
    apiPageNumber = null;
    fetchInstitutes(pageNumber);
  }

  @override
  void onClose() {
    scrollController.dispose();

    super.onClose();
  }
}
