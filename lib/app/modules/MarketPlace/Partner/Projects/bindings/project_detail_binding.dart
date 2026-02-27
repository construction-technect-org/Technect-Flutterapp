import 'package:construction_technect/app/modules/MarketPlace/Partner/Projects/controllers/project_detail_controller.dart';
import 'package:get/get.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectDetailController>(() => ProjectDetailController());
  }
}
