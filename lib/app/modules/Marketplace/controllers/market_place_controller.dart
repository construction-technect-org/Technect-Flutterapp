


import 'package:get/get.dart';
import 'package:construction_technect/app/core/utils/imports.dart';

class MarketPlaceController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Map<String, dynamic>> items = [
    {"icon": Asset.materialMarketplace, "title": "Material\nMarketplace"},
    {
      "icon": Asset.constructionCinemarketPlace,
      "title": "Construction-Line\nMarketplace",
    },
    {"icon": Asset.logisticMarketPlace, "title": "Logistic\nMarketplace"},
  ];

  void selectIndex(int index) {
    selectedIndex.value = index;
  }
}
