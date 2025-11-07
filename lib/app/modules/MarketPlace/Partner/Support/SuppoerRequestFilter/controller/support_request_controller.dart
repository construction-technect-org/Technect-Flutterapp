import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/services/SupportTicketCategoriesServices.dart';

class SupportRequestController extends GetxController {
  final suggestionController = TextEditingController();
  RxInt rating = 0.obs;
  RxBool isLoading = false.obs;

  final SupportTicketCategoriesServices _service =
      SupportTicketCategoriesServices();

  RxList<Ticket> myTickets = <Ticket>[].obs;

  Future<void> fetchMyTickets({required String status}) async {
    try {
      isLoading.value = true;
      final response = await _service.supportMyTicketsModel(filter: status);
      myTickets.clear();
      myTickets.addAll(response.data?.tickets ?? []);
    } catch (e) {
      // No Error Show
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      fetchMyTickets(status: Get.arguments["status"]);
    }
  }
}
