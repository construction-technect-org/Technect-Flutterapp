import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Support/AddSupportTickets/services/ConnectorSupportTicketCategoriesServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Support/CustomerSupport/controller/connector_customer_support_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketPrioritiesModel.dart';

class ConnectorCreateNewTicketController extends GetxController {
  final ConnectorSupportTicketCategoriesServices _service =
      ConnectorSupportTicketCategoriesServices();
  final ConnectorCustomerSupportController controller = Get.find();

  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  RxList<SupportCategory> categories = <SupportCategory>[].obs;
  RxList<SupportPriority> priorities = <SupportPriority>[].obs;

  Rx<SupportCategory?> selectedCategory = Rx<SupportCategory?>(null);
  Rx<SupportPriority?> selectedPriority = Rx<SupportPriority?>(null);

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchPriorities();
  }

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    try {
      final cachedData = myPref.getConnectorCategoriesData();
      if (cachedData != null) {
        categories.assignAll(cachedData);
        return;
      }

      isLoading.value = true;
      final response = await _service.supportTicketCategories();
      if (response.data.isNotEmpty) {
        categories.assignAll(response.data);
        myPref.setConnectorCategoriesData(response.data);
      }
    } catch (e) {
      final cachedData = myPref.getConnectorCategoriesData();
      if (cachedData != null) {
        categories.assignAll(cachedData);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPriorities() async {
    try {
      final cachedData = myPref.getConnectorPrioritiesData();
      if (cachedData != null) {
        priorities.assignAll(cachedData);
        return;
      }

      isLoading.value = true;
      final response = await _service.supportTicketPriorities();
      if (response.data.isNotEmpty) {
        priorities.assignAll(response.data);
        myPref.setConnectorPrioritiesData(response.data);
      }
    } catch (e) {
      final cachedData = myPref.getConnectorPrioritiesData();
      if (cachedData != null) {
        priorities.assignAll(cachedData);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void onCategorySelected(SupportCategory? value) {
    selectedCategory.value = value;
  }

  void onPrioritySelected(SupportPriority? value) {
    selectedPriority.value = value;
  }

  // Clear cache (useful for logout or force refresh)
  Future<void> clearCache() async {
    try {
      myPref.cachedConnectorCategories.val = '';
      myPref.cachedConnectorPriorities.val = '';
    } catch (e) {
      log('Error clearing cache: $e');
    }
  }

  // Force refresh from API (ignores cache)
  Future<void> forceRefreshCategories() async {
    try {
      isLoading.value = true;
      final response = await _service.supportTicketCategories();
      if (response.data.isNotEmpty) {
        categories.assignAll(response.data);
        myPref.setConnectorCategoriesData(response.data);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forceRefreshPriorities() async {
    try {
      isLoading.value = true;
      final response = await _service.supportTicketPriorities();
      if (response.data.isNotEmpty) {
        priorities.assignAll(response.data);
        myPref.setConnectorPrioritiesData(response.data);
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Submit Ticket
  Future<void> submitTicket() async {
    if (selectedCategory.value == null) {
      SnackBars.errorSnackBar(content: 'Please select a category');
      return;
    }
    if (selectedPriority.value == null) {
      SnackBars.errorSnackBar(content: 'Please select a priority');
      return;
    }
    if (subjectController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter a subject');
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      SnackBars.errorSnackBar(content: 'Please enter a description');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _service.supportTicketCreate(
        categoryId: selectedCategory.value!.id.toString(),
        priorityId: selectedPriority.value!.id.toString(),
        subject: subjectController.text.trim(),
        description: descriptionController.text.trim(),
      );

      if (response.success) {
        subjectController.clear();
        descriptionController.clear();
        selectedCategory.value = null;
        selectedPriority.value = null;
        await controller.fetchMyTickets();
        Get.back();
      }
    } catch (e) {
      // NO need
    } finally {
      isLoading.value = false;
    }
  }
}
