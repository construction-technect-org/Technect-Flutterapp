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
}
