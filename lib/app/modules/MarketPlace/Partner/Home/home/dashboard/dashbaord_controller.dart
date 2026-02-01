import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashBoardController extends GetxController {
  final CommonController commonController = Get.find<CommonController>();
  UserMainModel? userMainModel;
  RxString addressImmediate = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addressImmediate.value = commonController.selectedAddress.value;
    print("Address Imm ${addressImmediate.value}");
    print("Oninit123");
    final savedToken = storage.token;
    //myPref.getToken();
    final savedTokenType = storage.tokenType;
    //myPref.getTokenType();
    print("Saved $savedTokenType");
    if (savedTokenType == "ACCESS") {
      print("HeyToke");
      userMainModel = storage.user;
      //myPref.getUserModel();
      print("First Name ${userMainModel?.firstName}");
    }
  }
}
