import 'package:construction_technect/app/core/utils/imports.dart';

import 'package:construction_technect/app/modules/MarketPlace/Partner/Projects/controllers/projects_controller.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(() => ProjectsController());
  }
}
