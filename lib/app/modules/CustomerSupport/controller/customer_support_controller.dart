import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketPrioritiesModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/services/SupportTicketCategoriesServices.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/customer_support_view.dart';

class CustomerSupportController extends GetxController {
  final SupportTicketCategoriesServices _service =
      SupportTicketCategoriesServices();

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

  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  RxList<SupportCategory> categories = <SupportCategory>[].obs;
  RxList<SupportPriority> priorities = <SupportPriority>[].obs;

  Rx<SupportCategory?> selectedCategory = Rx<SupportCategory?>(null);
  Rx<SupportPriority?> selectedPriority = Rx<SupportPriority?>(null);

  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingPriorities = false.obs;
  RxBool isSubmitting = false.obs;

  // ---------------- New: Support My Tickets ----------------
  RxList<SupportMyTickets> myTickets = <SupportMyTickets>[].obs;
  RxBool isLoadingMyTickets = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchPriorities();
    fetchMyTickets(); // Fetch tickets when controller initializes
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final response = await _service.supportTicketCategories();
      categories.assignAll(response.data);
    } finally {
      isLoadingCategories.value = false;
    }
  }

  Future<void> fetchPriorities() async {
    try {
      isLoadingPriorities.value = true;
      final response = await _service.supportTicketPriorities();
      priorities.assignAll(response.data);
    } finally {
      isLoadingPriorities.value = false;
    }
  }

  void onCategorySelected(SupportCategory? value) {
    selectedCategory.value = value;
  }

  void onPrioritySelected(SupportPriority? value) {
    selectedPriority.value = value;
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
      isSubmitting.value = true;

      final response = await _service.supportTicketCreate(
        categoryId: selectedCategory.value!.id.toString(),
        priorityId: selectedPriority.value!.id.toString(),
        subject: subjectController.text.trim(),
        description: descriptionController.text.trim(),
      );

      if (response.success) {
        SnackBars.successSnackBar(content: 'Ticket submitted successfully');

        // Refresh ticket list after creation
        await fetchMyTickets();

        // Clear the form
        subjectController.clear();
        descriptionController.clear();
        selectedCategory.value = null;
        selectedPriority.value = null;
        isSubmitting.value = false;

        final result = await Get.to(() => CustomerSupportView());
        if (result == true) {
          fetchMyTickets(); // refresh list
        }
      } else {
        SnackBars.errorSnackBar(
          content: response.message ?? 'Failed to submit ticket',
        );
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'An error occurred: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  // ---------------- New: Fetch My Tickets ----------------
  Future<void> fetchMyTickets() async {
    try {
      isLoadingMyTickets.value = true;
      final response = await _service.supportMyTicketsModel();
      myTickets.assignAll(response.data.tickets); // just update the list
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to fetch tickets: $e');
    } finally {
      isLoadingMyTickets.value = false;
    }
  }

  // Handlers
  void onMainCategorySelected(String? value) {
    if (value != null) {
      selectedMainCategory.value = value;
    }
  }
}
