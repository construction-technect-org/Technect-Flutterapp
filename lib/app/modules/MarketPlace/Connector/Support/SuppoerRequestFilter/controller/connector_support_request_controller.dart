import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/Support/CustomerSupport/services/ConnectorSupportTicketServices.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';

class ConnectorSupportRequestController extends GetxController {
  final suggestionController = TextEditingController();
  RxInt rating = 0.obs;
  RxBool isLoading = false.obs;

  final ConnectorSupportTicketServices _service = ConnectorSupportTicketServices();

  RxList<Ticket> myTickets = <Ticket>[].obs;

  Future<void> fetchMyTickets({required String status}) async {
    try {
      isLoading.value = true;
      final response = await _service.supportMyTicketsModel(filter: status);
      myTickets.clear();
      myTickets.addAll(response.data?.tickets ?? []);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Failed to fetch tickets: $e');
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
