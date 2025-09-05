import 'package:get/get.dart';

class TeamDetailsController extends GetxController {
  /// Example reactive data
  RxString userName = "Mike Junior".obs;
  RxString userEmail = "@mike@constructiontechnet.com".obs;
  RxString userRole = "Admin".obs;
  RxString userPhone = "8950482123".obs;
  RxString userAddress = "12/45, East Street, Main Chowk, Dattawadi, "
      "Mhasoba Chowk, Near Ajit Super Market, Pune, Maharashtra-411030".obs;

  RxList<Map<String, String>> documents = [
    {
      "title": "PAN Card",
      "organization": "International Organization for Standardization",
      "expiry": "Expires on 12/12/2025",
    },
    {
      "title": "Aadhar Card",
      "organization": "International Organization for Standardization",
      "expiry": "Expires on 12/12/2025",
    },
  ].obs;
}
