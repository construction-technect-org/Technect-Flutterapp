import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/services/SupportTicketCategoriesServices.dart';

class CustomerSupportController extends GetxController {
  final SupportTicketCategoriesServices _service =
      SupportTicketCategoriesServices();
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

  Future<void> _loadTicketsFromStorage() async {
    final cachedTicketsModel = myPref.getSupportTicketsModel();
    if (cachedTicketsModel != null) {
      supportMyTickets.value = cachedTicketsModel;
      filteredTickets.assignAll(cachedTicketsModel.data?.tickets ?? []);
    } else {
      fetchMyTickets();
    }
  }

  void sortfilteredTickets() {
    final priorityOrder = {'Critical': 1, 'High': 2, 'Medium': 3, 'Low': 4};

    filteredTickets.sort((a, b) {
      final aPriority = priorityOrder[a.priorityName ?? ''] ?? 999;
      final bPriority = priorityOrder[b.priorityName ?? ''] ?? 999;
      return aPriority.compareTo(bPriority);
    });

    filteredTickets.refresh();
  }

  Future<void> fetchMyTickets() async {
    try {
      isLoading.value = true;
      final result = await _service.supportMyTicketsModel();
      if (result.success == true) {
        supportMyTickets.value = result;
        filteredTickets.clear();
        filteredTickets.addAll(result.data?.tickets ?? []);
        myPref.setSupportTicketsModel(result);
      } else {
        await _loadTicketsFromStorage();
      }
    } catch (e) {
      // No Error Show
    } finally {
      sortfilteredTickets();
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

  void onMainCategorySelected(String? value) {
    if (value != null) {
      selectedMainCategory.value = value;
    }
  }
}
