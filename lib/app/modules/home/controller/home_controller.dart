// // lib/app/modules/home/controllers/home_controller.dart
// import 'package:get/get.dart';

// class HomeController extends GetxController {
//   /// List of feature items
//   final items = [
//     {"icon": "assets/icons/marketplace.png", "label": "Marketplace"},
//     {"icon": "assets/icons/erp.png", "label": "ERP"},
//     {"icon": "assets/icons/crm.png", "label": "CRM"},
//     {"icon": "assets/icons/ovp.png", "label": "OVP"},
//     {"icon": "assets/icons/hrms.png", "label": "HRMS"},
//     {"icon": "assets/icons/project.png", "label": "Project\nManagement"},
//     {"icon": "assets/icons/portfolio.png", "label": "Portfolio\nManagement"},
//   ].obs;

//   /// Dummy team list
//   final teamMembers = [
//     {"name": "Mohan Sau", "image": "assets/images/team.png"},
//     {"name": "Vaishnavi", "image": "assets/images/team.png"},
//     {"name": "Rahul", "image": "assets/images/team.png"},
//     {"name": "Kirti", "image": "assets/images/team.png"},
//   ].obs;

//   /// Statistics values
//   final noOfUsers = 34.obs;
//   final totalProducts = 104.obs;

//   /// Months for chart
//   final monthNames = [
//     "Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Feb","Mar"
//   ].obs;

//   /// Example: could be API call
//   Future<void> fetchDashboardData() async {
//     // TODO: Call API and update observables
//     await Future.delayed(const Duration(seconds: 1));
//     noOfUsers.value = 40;
//     totalProducts.value = 120;
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDashboardData();
//   }
// }
