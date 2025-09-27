import 'package:construction_technect/app/core/utils/imports.dart';
class ConnectorHomeController extends GetxController {

  final List<Map<String, dynamic>> items = [
    {"icon": Asset.inbox, "title": "Inbox"},
    {"icon": Asset.report, "title": "Report"},
    {"icon": Asset.report, "title": "Analysis"},
    {"icon": Asset.setting, "title": "Setting"},
    {"icon": Asset.insights, "title": "Insights"},
    {"icon": Asset.cart, "title": "Inventory"},
    {"icon": Asset.warning, "title": "News"},
    {"icon": Asset.thumbup, "title": "Refer& Earn"},
  ];

  RxInt selectedIndex = 0.obs;


  final isLoading = false.obs;



}
