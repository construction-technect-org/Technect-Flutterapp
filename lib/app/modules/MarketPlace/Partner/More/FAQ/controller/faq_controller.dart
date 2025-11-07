import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/model/faq_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/FAQ/services/FAQService.dart';

class FAQController extends GetxController {
  final isLoading = false.obs;
  final FAQService _service = FAQService();
  final RxList<FAQ> faqList = <FAQ>[].obs;
  RxList selectedIndex = [].obs;

  Future<void> fetchFAQs() async {
    try {
      final cachedData = myPref.getFAQData();
      if (cachedData != null) {
        faqList.assignAll(cachedData.data ?? []);
        return;
      }

      isLoading.value = true;
      final result = await _service.fetchAllFAQs();
      if (result.success == true) {
        faqList.assignAll(result.data ?? []);
        myPref.setFAQData(result);
      }
    } catch (e) {
      final cachedData = myPref.getFAQData();
      if (cachedData != null) {
        faqList.assignAll(cachedData.data ?? []);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFAQs();
  }
}
