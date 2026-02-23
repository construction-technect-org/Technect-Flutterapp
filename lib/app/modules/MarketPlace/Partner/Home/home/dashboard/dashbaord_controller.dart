import "dart:developer";

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
          content: 'Location services are disabled. Please enable location services.',
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
        SnackBars.errorSnackBar(content: 'Location permissions are permanently denied.');
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error getting current location: $e');
    }
  }

  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
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
      log("Persona Response : $personaResponse");
      if (personaResponse.success == true) {
        log("Success");
        log("Persona Response : ${personaResponse.personas?.length}");
        for (int i = 0; i < personaResponse.personas!.length; i++) {
          log("Persona Response : ${personaResponse.personas?[i].profileType}");
        }
        await storage.setPersonaDetail(personaResponse);
        profileFetch();
      }
    } catch (e) {
      log('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      log("Fetched");
    }
  }

  Future<void> profileFetch() async {
    log("Profile Fetched");
    String? merchantID;
    String? connectorID;

    try {
      isLoading.value = true;

      log("Hy there ${storage.personaDetail}");
      final PersonaProfileModel? persona = storage.personaDetail;
      log("Persona : $persona");
      if (persona == null) {
        log("Yes Null");
      }
      log("Length ${persona!.personas!.length}");
      for (int i = 0; i < persona.personas!.length; i++) {
        log("Persona : ${persona.personas?[i]}");
        log("YEs ${persona.personas?[i].profileType}");
        if (persona.personas?[i].profileType == "merchant") {
          merchantID = persona.personas?[i].profileId;
        } else {
          connectorID = persona.personas?[i].profileId;
        }
      }

      if (merchantID != null && merchantID.isNotEmpty) {
        profileResponse.value = await homeService.getMerchantProfile(merchantID);
        log("Merchant Response : ${profileResponse.value}");
        await storage.setMerchantID(merchantID);
        log("Merchant ID : $merchantID");
        if (profileResponse.value.merchant != null) {
          log("Merchant NotNull");
          log("Biz Hrs ${profileResponse.value.merchant!.businessHours}");
          if (profileResponse.value.merchant!.businessHours != null) {
            log("Storign BIz HOurs");
            await storage.setMerchantBizHours(profileResponse.value.merchant!.businessHours);
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
      log('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      log("Fetched");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
    if (myPref.getToken().isNotEmpty && myPref.getRole() == "partner") {
      personaFetch();
      profileFetch();
    }

    log("Address Imm ${addressImmediate.value}");
    log("Oninit123");
    final savedToken = storage.token;
    //myPref.getToken();
    final savedTokenType = storage.tokenType;
    //myPref.getTokenType();
    log("Saved $savedTokenType");
    if (savedTokenType == "ACCESS") {
      log("HeyToke");
      userMainModel = storage.user;
      //myPref.getUserModel();
      log("First Name ${userMainModel?.firstName}");
    }
  }
}
