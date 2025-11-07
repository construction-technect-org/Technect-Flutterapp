import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/controller/customer_support_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketPrioritiesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/services/SupportTicketCategoriesServices.dart';

class CreateNewTicketController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final SupportTicketCategoriesServices _service =
      SupportTicketCategoriesServices();
  final CustomerSupportController controller = Get.find();

  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  RxList<SupportCategory> categories = <SupportCategory>[].obs;
  RxList<SupportPriority> priorities = <SupportPriority>[].obs;

  Rx<SupportCategory?> selectedCategory = Rx<SupportCategory?>(null);
  Rx<SupportPriority?> selectedPriority = Rx<SupportPriority?>(null);

  RxBool isLoading = false.obs;
  RxBool isSubmitting = false.obs;

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
      final cachedData = myPref.getCategoriesData();
      if (cachedData != null) {
        categories.assignAll(cachedData);
        return;
      }

      isLoading.value = true;
      final response = await _service.supportTicketCategories();
      if (response.data.isNotEmpty) {
        categories.assignAll(response.data);
        myPref.setCategoriesData(response.data);
      }
    } catch (e) {
      final cachedData = myPref.getCategoriesData();
      if (cachedData != null) {
        categories.assignAll(cachedData);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPriorities() async {
    try {
      final cachedData = myPref.getPrioritiesData();
      if (cachedData != null) {
        priorities.assignAll(cachedData);
        return;
      }

      isLoading.value = true;
      final response = await _service.supportTicketPriorities();
      if (response.data.isNotEmpty) {
        priorities.assignAll(response.data);
        myPref.setPrioritiesData(response.data);
      }
    } catch (e) {
      final cachedData = myPref.getPrioritiesData();
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

  Future<void> clearCache() async {
    try {
      myPref.cachedCategories.val = '';
      myPref.cachedPriorities.val = '';
    } catch (e) {
      // No Error Show
    }
  }

  Future<void> forceRefreshCategories() async {
    try {
      isLoading.value = true;
      final response = await _service.supportTicketCategories();
      if (response.data.isNotEmpty) {
        categories.assignAll(response.data);
        myPref.setCategoriesData(response.data);
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
        myPref.setPrioritiesData(response.data);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitTicket() async {
    try {
      isSubmitting.value = true;
      isLoading.value = true;

      final response = await _service.supportTicketCreate(
        categoryId: selectedCategory.value!.id.toString(),
        priorityId: selectedPriority.value!.id.toString(),
        subject: subjectController.text.trim(),
        description: descriptionController.text.trim(),
      );

      if (response.success) {
        await controller.fetchMyTickets();
        Get.back();
      }
    } catch (e) {
      // No Error Show
    } finally {
      isSubmitting.value = false;
      isLoading.value = false;
    }
  }
}
