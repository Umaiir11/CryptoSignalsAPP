import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:souq_ai/app/mvvm/model/response_model/zakatinstitutes_resp_model.dart';
import 'package:souq_ai/app/repository/auth_repo/zakat_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/response_model/api_responsemodel.dart';

class ZakatController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final logger = Logger();
  final RxInt zakatValue = 0.obs;
  RxList<Institute> institutesList = <Institute>[].obs;
  final ScrollController scrollController = ScrollController(); // ScrollController
  RxString? selectedCharity = "Orphans".obs;

  final List<String> charityList = ["Orphans", "Education", "Healthcare"];

  void launchUrlFromAPP(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.inAppBrowserView,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void calculateZakat(String value) {
    int enteredAmount = int.tryParse(value) ?? 0;

    int calculatedZakat = (enteredAmount * 2.5 / 100).toInt();
    zakatValue.value = calculatedZakat;
    logger.i("Zakat Value${zakatValue.value}");
  }

  int? apiPageNumber;
  int pageNumber = 1;
  final RxBool hasMoreData = true.obs;
  final RxBool isLoading = false.obs;
  int totalFetchedItems = 0;
  final RxBool isBottomLoading = false.obs;

  Future<void> fetchInstitutes(int page) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isBottomLoading.value = true;
      }

      ApiResponse<InstitutesResponse>? apiResponse = await ZaKatRepo().fetchInstitutes(
        page,
        selectedCharity?.value.toLowerCase(),
      );

      if (apiResponse != null && apiResponse.data != null) {
        List<Institute> newInstitutes = apiResponse.data!.institutes;

        logger.i("Selected Charity: ${selectedCharity?.value}");

        if (newInstitutes.isNotEmpty) {
          // Filter out duplicates
          institutesList.addAll(
            newInstitutes.where((newInstitute) =>
            !institutesList.any((existing) => existing.id == newInstitute.id)),
          );

          apiPageNumber = apiResponse.data?.pagination.lastPage ?? page;
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

  void resetPagination() {
    pageNumber = 1;
    institutesList.clear();
    hasMoreData.value = true;
    totalFetchedItems = 0;
    apiPageNumber = null;
    fetchInstitutes(pageNumber);
  }

  @override
  void onClose() {
    amountController.dispose();
    scrollController.dispose();

    super.onClose();
  }
}
