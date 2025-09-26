import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/FAQ/model/faq_model.dart';
import 'package:construction_technect/app/modules/FAQ/services/FAQService.dart';

class FAQController extends GetxController{
  final isLoading = false.obs;
  final FAQService _service = FAQService();
  final RxList<FAQ> faqList = <FAQ>[].obs;

  Future<void> fetchFAQs() async {
    try {
      isLoading.value = true;
      final result = await _service.fetchAllRoles();
      if (result != null && result.success==true) {
        faqList.assignAll(result.data??[]);
      }
    } finally {
      isLoading.value = false;
    }
  }


  RxList selectedIndex = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchFAQs();
  }
}