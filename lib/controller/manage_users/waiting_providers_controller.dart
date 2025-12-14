// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/models/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class WaitingProvidersController extends GetxController {
  List<ProviderModel> providers = [];
  ScrollController scrollController = ScrollController();
  StatusRequest statusRequest = StatusRequest.loading;
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  bool isLastPage = false;
  @override
  Future<void> onInit() async {
    scrollController.addListener(_scrollListener);
    await getProviders();
    super.onInit();
  }

  void _scrollListener() {
    if (!scrollController.hasClients) return;
    if (scrollController.position.maxScrollExtent <= 0) return;

    final pixels = scrollController.position.pixels;
    final maxScroll = scrollController.position.maxScrollExtent;

    // Trigger when within 200 pixels of the bottom
    if (pixels >= maxScroll - 200) {
      if (!isLoading && !isLastPage && currentPage < totalPages) {
        Logger().d(
            'Loading more providers. Current page: $currentPage, Total pages: $totalPages');
        currentPage++;
        getProviders();
      } else {
        Logger().d(
            'Not loading - isLoading: $isLoading, isLastPage: $isLastPage, currentPage: $currentPage, totalPages: $totalPages');
      }
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void deleteProviderDialog(id) {
    Get.defaultDialog(
        title: "Delete Provider",
        titleStyle: TextStyle(fontSize: 14.sp),
        middleText: "Are you sure you want to\ndelete this provider?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          _deleteProvider(id);
        });
  }

  Future<void> _deleteProvider(String id) async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteProvider(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      Get.back();
      getProviders(refresh: true);
    });
  }

  Future<void> acceptProvider(id) async {
    statusRequest = StatusRequest.loading;
    print("====================");
    print(id);
    print("====================");
    final response = await CustomRequest(
        path: ApiConstance.approveProviderProvider,
        data: {"provider_id": id},
        fromJson: (json) {
          return json['data'];
        }).sendPostRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      // Get.back();
      getProviders(refresh: true);
    });
  }

  Future<void> getProviders({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      totalPages = 1;
      providers.clear();
      isLastPage = false;
      statusRequest = StatusRequest.loading;
    }
    if (isLoading) return; // Prevent multiple simultaneous requests
    isLoading = true;
    if (currentPage == 1) {
      statusRequest = StatusRequest.loading;
    }
    update();
    final response = await CustomRequest<List<ProviderModel>>(
        path: ApiConstance.getWaitingProvider(currentPage.toString()),
        fromJson: (json) {
          // Extract pagination metadata from API response
          // The API returns pagination info in a 'meta' object
          if (json.containsKey('meta') && json['meta'] is Map) {
            final meta = json['meta'] as Map;
            if (meta.containsKey('current_page')) {
              currentPage = meta['current_page'] is int
                  ? meta['current_page']
                  : int.tryParse(meta['current_page'].toString()) ??
                      currentPage;
            }
            if (meta.containsKey('last_page')) {
              totalPages = meta['last_page'] is int
                  ? meta['last_page']
                  : int.tryParse(meta['last_page'].toString()) ?? totalPages;
            }
            Logger().d(
                'Pagination from meta - Current: $currentPage, Total: $totalPages');
          } else {
            // Fallback: try to get from root level (for backward compatibility)
            if (json.containsKey('current_page')) {
              currentPage = json['current_page'] is int
                  ? json['current_page']
                  : int.tryParse(json['current_page'].toString()) ??
                      currentPage;
            }
            if (json.containsKey('last_page')) {
              totalPages = json['last_page'] is int
                  ? json['last_page']
                  : int.tryParse(json['last_page'].toString()) ?? totalPages;
            }
            Logger().d(
                'Pagination from root - Current: $currentPage, Total: $totalPages');
          }

          // Return the list of providers from the data field
          final dataList = json['data'] as List?;
          if (dataList == null) {
            Logger().e('API response does not contain data field');
            return <ProviderModel>[];
          }
          return dataList
              .map<ProviderModel>((e) => ProviderModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      isLoading = false;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      isLoading = false;
      // Append new items instead of clearing
      providers.addAll(r);
      Logger().d(
          'Loaded ${r.length} providers. Total providers: ${providers.length}');

      // Check if we've reached the last page
      if (r.isEmpty || currentPage >= totalPages) {
        isLastPage = true;
        Logger().d(
            'Reached last page - isEmpty: ${r.isEmpty}, currentPage: $currentPage, totalPages: $totalPages');
      }

      if (providers.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }
}
