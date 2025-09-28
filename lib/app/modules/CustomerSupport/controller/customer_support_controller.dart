import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/services/SupportTicketCategoriesServices.dart';

class CustomerSupportController extends GetxController {
  final SupportTicketCategoriesServices _service = SupportTicketCategoriesServices();

  // Main Categories
  final List<String> mainCategories = [
    "Construction",
    "Electrical",
    "Plumbing",
    "Interior",
    "Painting",
  ];
  RxString selectedMainCategory = "".obs;
  bool isEdit = false;
  RxString searchQuery = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyTickets();
  }

  Rx<SupportMyTicketsModel> supportMyTickets = SupportMyTicketsModel().obs;

  Future<void> fetchMyTickets() async {
    try {
      isLoading.value = true;
      supportMyTickets.value = await _service.supportMyTicketsModel();
      log('Gopal Tickets : ${supportMyTickets.value.data?.tickets?.length ?? 0}');
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to fetch tickets: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Handlers
  void onMainCategorySelected(String? value) {
    if (value != null) {
      selectedMainCategory.value = value;
    }
  }
}
