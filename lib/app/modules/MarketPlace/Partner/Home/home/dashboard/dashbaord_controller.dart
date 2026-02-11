import 'package:construction_technect/app/core/utils/globals.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/Authentication/SignUp/SignUpDetails/model/complete_signup_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/merchant_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/persona_profile_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/services/HomeService.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashBoardController extends GetxController {
  final CommonController commonController = Get.find<CommonController>();
  UserMainModel? userMainModel;
  RxString addressImmediate = "".obs;
  Rx<LatLng> currentPosition = const LatLng(21.1702, 72.8311).obs;
  RxString selectedAddress = ''.obs;
  final isLoading = false.obs;
  final HomeService homeService = Get.find<HomeService>();
  Rx<MerchantProfileModel> profileResponse = MerchantProfileModel().obs;
  Rx<MerchantProfileModel> profileResponse1 = MerchantProfileModel().obs;
  RxBool getLoading() {
    return (commonController.isLoading.value && isLoading.value).obs;
  }

  Future<void> getCurrentLocation() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        SnackBars.errorSnackBar(
          content:
              'Location services are disabled. Please enable location services.',
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          SnackBars.errorSnackBar(content: 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        SnackBars.errorSnackBar(
          content: 'Location permissions are permanently denied.',
        );
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error getting current location: $e');
    }
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        final String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        selectedAddress.value = address;
      }
    } catch (e) {
      selectedAddress.value = 'Address not found';
    }
  }

  Future<void> personaFetch() async {
    try {
      isLoading.value = true;
      final personaResponse = await homeService.getPersona();
      if (personaResponse.success == true) {
        print("Success");
        await storage.setPersonaDetail(personaResponse);
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      print("Fetched");
    }
  }

  Future<void> profileFetch() async {
    print("Profile Fetched");
    String? merchantID, connectorID;

    try {
      isLoading.value = true;

      print("Hy there ${storage.personaDetail}");
      final PersonaProfileModel? _persona = storage.personaDetail;
      if (_persona == null) {
        print("Yes Null");
      }
      print("Length ${_persona!.personas!.length}");
      for (int i = 0; i < _persona!.personas!.length; i++) {
        print("YEs ${_persona?.personas?[i].profileType}");
        if (_persona?.personas?[i].profileType == "merchant") {
          merchantID = _persona?.personas?[i].profileId;
        } else {
          connectorID = _persona?.personas?[i].profileId;
        }
      }

      if (merchantID != null && merchantID.isNotEmpty) {
        profileResponse.value = await homeService.getMerchantProfile(
          merchantID,
        );
        await storage.setMerchantID(merchantID);
        if (profileResponse.value.merchant != null) {
          print("Merchant NotNull");
          print("Biz Hrs ${profileResponse.value.merchant!.businessHours}");
          if (profileResponse.value.merchant!.businessHours != null) {
            print("Storign BIz HOurs");
            await storage.setMerchantBizHours(
              profileResponse.value.merchant!.businessHours,
            );
          }
          if (profileResponse.value.merchant!.pocDetails != null) {
            await storage.setPOC(profileResponse.value.merchant!.pocDetails);
          }
          await storage.setBM(profileResponse.value.merchant!);
          if (profileResponse.value.merchant!.verificationDetails != null) {
            await storage.setGstNumber(
              profileResponse.value.merchant!.verificationDetails!.gstNumber!,
            );
          }
        }
      }
    } catch (e) {
      Get.printError(info: 'Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      print("Fetched");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
    personaFetch();
    profileFetch();

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
