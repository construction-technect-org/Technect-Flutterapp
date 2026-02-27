import 'package:construction_technect/app/core/utils/imports.dart';

class ProjectsController extends GetxController {
  final count = 0.obs;

  final RxInt selectedCategory = 0.obs;
  final RxInt selectedNavIndex = 0.obs;
  final RxBool isGridView = false.obs;

  final List<Map<String, String>> categories = [
    {"name": "Project", "image": Asset.building},
    {"name": "Manufacturer", "image": Asset.building},
  ];

  final List<Map<String, dynamic>> projects = [
    {
      "projectName": "Project Name",
      "connectorName": "Connector Name",
      "location": "Jp nagar 7th phase rbi layout, Jp nagar 7th ph...",
      "area": "1234",
      "distance": "12",
      "projectImage": Asset.building,
    },
    {
      "projectName": "Project Name",
      "connectorName": "Connector Name",
      "location": "Jp nagar 7th phase rbi layout, Jp nagar 7th ph...",
      "area": "1234",
      "distance": "12",
      "projectImage": Asset.industrial,
    },
    {
      "projectName": "Project Name",
      "connectorName": "Connector Name",
      "location": "Jp nagar 7th phase rbi layout, Jp nagar 7th ph...",
      "area": "1234",
      "distance": "12",
      "projectImage": Asset.residential,
    },
    {
      "projectName": "Project Name",
      "connectorName": "Connector Name",
      "location": "Jp nagar 7th phase rbi layout, Jp nagar 7th ph...",
      "area": "1234",
      "distance": "12",
      "projectImage": Asset.commercial,
    },
  ];

  final List<Map<String, dynamic>> manufacturers = [
    {
      "projectName": "ABC Manufacturing",
      "connectorName": "John Doe",
      "location": "Peenya Industrial Area, Bangalore",
      "category": "Steel",
      "distance": "8",
      "projectImage": Asset.mer,
    },
    {
      "projectName": "XYZ Cement",
      "connectorName": "Jane Smith",
      "location": "Whitefield, Bangalore",
      "category": "Cement",
      "distance": "15",
      "projectImage": Asset.industrial,
    },
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
