import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/models/delivery_address_model.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/AddDeliveryAddress/services/delivery_address_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DeliveryLocationController extends GetxController {
  final CommonController commonController = Get.find<CommonController>();

  // Observable variables - redirected to central storage
  RxBool get isLoading => commonController.isLoadingAddresses;
  RxList<DeliveryAddressData> get addresses => commonController.addresses;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    await commonController.fetchAddresses();
  }

  // Add new address
  Future<void> addAddress() async {
    await Get.toNamed(Routes.ADD_DELIVERY_ADDRESS);
    fetchAddresses(); // Refresh central list after returning
  }

  Future<void> useCurrentLocationAsDefault() async {
    if (commonController.isLoading.value) return; // Prevent multiple clicks

    try {
      commonController.isLoading.value = true;

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

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];

        final String street = place.street ?? "Current Location";
        final String pincode = place.postalCode ?? '';

        // Duplicate Check: Look for existing address with same street and pincode
        DeliveryAddressData? existingAddress;
        for (var addr in commonController.addresses) {
          if (addr.addressLine1 == street && addr.pincode == pincode) {
            existingAddress = addr;
            break;
          }
        }

        String? addressIdToSetDefault;

        if (existingAddress != null) {
          addressIdToSetDefault = existingAddress.id;
          debugPrint("Duplicate address found: ${existingAddress.id}");
        } else {
          final String addressLine2 = [
            place.subLocality,
            place.locality,
          ].where((element) => element != null && element.isNotEmpty).join(", ");

          final Map<String, dynamic> payload = {
            "label": "Project Address",
            "addressLine1": street,
            "addressLine2": addressLine2,
            "city": place.locality ?? place.subAdministrativeArea ?? '',
            "state": place.administrativeArea ?? '',
            "pincode": pincode,
            "country": place.country ?? '',
            "latitude": position.latitude,
            "longitude": position.longitude,
            "isDefault": false,
          };

          final response = await DeliveryAddressService.createAddress(payload);

          if (response != null && response is Map<String, dynamic>) {
            if (response['data'] != null && response['data']['id'] != null) {
              addressIdToSetDefault = response['data']['id'].toString();
            } else if (response['address'] != null && response['address']['id'] != null) {
              addressIdToSetDefault = response['address']['id'].toString();
            } else if (response['id'] != null) {
              addressIdToSetDefault = response['id'].toString();
            }
          }
        }

        if (addressIdToSetDefault != null) {
          await commonController.setDefaultAddress(addressIdToSetDefault);
          SnackBars.successSnackBar(content: "Current location set as default address");
        } else {
          // fallback refresh
          await fetchAddresses();
          await commonController.fetchProfileData();
          SnackBars.successSnackBar(content: "Current location synced");
        }
      }
    } catch (e) {
      SnackBars.errorSnackBar(content: 'Error setting current location: $e');
    } finally {
      commonController.isLoading.value = false;
    }
  }
}
