import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/RoleManagement/models/GetTeamListModel.dart';
import 'package:construction_technect/app/modules/RoleManagement/services/GetAllRoleService.dart';
import 'package:construction_technect/app/modules/home/models/AddressModel.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/home/services/HomeService.dart';

class HomeController extends GetxController {
  CommonController commonController = Get.find();
  

  final List<Map<String, dynamic>> items = [
    {"icon": Asset.marketplaceIcon, "title": "Marketplace"},
    {"icon": Asset.crmIcon, "title": "CRM"},
    {"icon": Asset.erpIcon, "title": "ERP"},
    {"icon": Asset.projectManagementIcon, "title": "Project Management"},
    {"icon": Asset.hrmsIcon, "title": "HRMS"},
    {"icon": Asset.portfolioManagementIcon, "title": "Portfolio\nManagement"},
    {"icon": Asset.ovpIcon, "title": "OVP"},
    {"icon": Asset.constructionTaxi, "title": "Construction Taxi"},
  ];

  RxInt selectedIndex = 0.obs;

  HomeService homeService = HomeService();
  GetAllRoleService roleService = GetAllRoleService();

  final isLoading = false.obs;
  final hasAddress = false.obs;

  Rx<ProfileModel> profileData = ProfileModel().obs;
  AddressModel addressData = AddressModel();
  RxList<TeamListData> teamList = <TeamListData>[].obs;


}
