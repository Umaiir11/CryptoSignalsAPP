import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../repository/auth_repo/signals_repo.dart';
import '../../model/response_model/api_responsemodel.dart';
import '../../model/response_model/signals_response_model.dart';

class SignalController extends GetxController {
  final logger = Logger();
  final ScrollController scrollController = ScrollController(); // ScrollController
  int? apiPageNumber;
  int pageNumber = 1;
  final RxBool hasMoreData = true.obs;
  final RxBool isLoading = false.obs;
  int totalFetchedItems = 0;
  final RxBool isBottomLoading = false.obs;
  final RxBool isCurrencyDetailsLoading = false.obs;

  // Original list of signals fetched from the API
  RxList<Signal> signalsList = <Signal>[].obs;
  RxList<Signal> filteredSignalsList = <Signal>[].obs;

  TextEditingController searchController = TextEditingController();

  Future<void> fetchSignals(int page) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isBottomLoading.value = true;
      }

      ApiResponse<SignalsData>? apiResponse = await SignalsRepo().fetchSignals();

      if (apiResponse != null && apiResponse.data != null) {
        List<Signal>? newSignals = apiResponse.data!.signals;

        if (newSignals != null) {
          signalsList.addAll(newSignals);
          filteredSignalsList.addAll(newSignals); // Update filtered list
          apiPageNumber = apiResponse.data?.pagination?.lastPage ?? page;
          totalFetchedItems += newSignals.length;
          hasMoreData.value = page < apiPageNumber!;
        } else {
          hasMoreData.value = false;
        }
      } else {
        hasMoreData.value = false;
        logger.w("API response or data is null");
      }
    } catch (e) {
      logger.e("Error fetching signals: $e");
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
    pageNumber++;
    await fetchSignals(pageNumber);
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && hasMoreData.value && !isBottomLoading.value) {
        loadMoreData();
      }
    });
  }

  void resetPagination() {
    pageNumber = 1;
    signalsList.clear();
    filteredSignalsList.clear(); // Clear filtered list as well
    hasMoreData.value = true;
    totalFetchedItems = 0;
    apiPageNumber = null;
    // fetchSignals(pageNumber);
  }

  // Filter signals based on search query
  void filterSignals(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all signals
      filteredSignalsList.assignAll(signalsList);
    } else {
      // Filter the signals where currency name matches the query
      filteredSignalsList.assignAll(
        signalsList.where(
              (signal) => (signal.currency?.name?.toLowerCase() ?? '').contains(query.toLowerCase()),
        ),
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
