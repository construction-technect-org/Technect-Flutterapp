import 'package:construction_technect/app/modules/RoleManagement%20/models/GetAllRoleModel.dart';
import 'package:construction_technect/app/modules/RoleManagement%20/services/GetAllRoleService.dart';
import 'package:get/get.dart';

class RoleManagementController extends GetxController {


 
  final users = [
    {
      "name": "Mike Junior",
      "role": "Owner",
      "email": "mike@constructiontechnet.com",
      "status": "Active",
      "image": "https://i.pravatar.cc/150?img=3",
    },
    {
      "name": "Sarah Lee",
      "role": "Manager",
      "email": "sarah@constructiontechnet.com",
      "status": "Active",
      "image": "https://i.pravatar.cc/150?img=5",
    },
  ].obs;



 final roles = <GetAllRole>[].obs;
  final isLoading = false.obs;

  final GetAllRoleService _service = GetAllRoleService();




  @override
  void onInit() {
    super.onInit();
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    try {
      isLoading.value = true;
      final result = await _service.fetchAllRoles();
      if (result != null && result.success) {
        roles.assignAll(result.data);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
