import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportMyTicketsModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketPrioritiesModel.dart';

class ConnectorCustomerSupportTicketController extends GetxController {
 

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



}
