import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/services/SupportTicketCategoriesServices.dart';

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
  RxString searchQuery = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyTickets();
  }

  Rx<SupportMyTicketsModel> supportMyTickets = SupportMyTicketsModel().obs;
  RxList<Ticket> filteredTickets = <Ticket>[].obs;

  Future<void> fetchMyTickets() async {
    try {
      isLoading.value = true;
      supportMyTickets.value = await _service.supportMyTicketsModel();
      filteredTickets.clear();
      filteredTickets.addAll(supportMyTickets.value.data?.tickets ?? []);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to fetch tickets: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void searchTickets(String value) {
    searchQuery.value = value;
    if (value.isEmpty) {
      filteredTickets.clear();
      filteredTickets.addAll(supportMyTickets.value.data?.tickets ?? []);
    } else {
      filteredTickets.clear();
      filteredTickets.value = (supportMyTickets.value.data?.tickets ?? [])
          .where((ticket) {
            return (ticket.subject ?? '').toLowerCase().contains(
                  value.toLowerCase(),
                ) ||
                (ticket.description ?? '').toLowerCase().contains(
                  value.toLowerCase(),
                ) ||
                (ticket.ticketNumber ?? '').toLowerCase().contains(
                  value.toLowerCase(),
                ) ||
                (ticket.categoryName ?? '').toLowerCase().contains(
                  value.toLowerCase(),
                ) ||
                (ticket.priorityName ?? '').toLowerCase().contains(
                  value.toLowerCase(),
                );
          })
          .toList();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    filteredTickets.clear();
    filteredTickets.addAll(supportMyTickets.value.data?.tickets ?? []);
  }

  // Handlers
  void onMainCategorySelected(String? value) {
    if (value != null) {
      selectedMainCategory.value = value;
    }
  }
}
