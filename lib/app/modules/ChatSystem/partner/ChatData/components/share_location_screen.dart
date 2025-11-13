import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:construction_technect/app/core/utils/imports.dart';

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({super.key});

  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  bool isLoading = true;
  final TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Permission Denied', 'Please enable location access in settings');
        return;
      }

      final Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        selectedLatLng = LatLng(pos.latitude, pos.longitude);
        isLoading = false;
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: $e');
      setState(() => isLoading = false);
    }
  }

  void _onSendLocation() {
    if (selectedLatLng != null) {
      Navigator.pop(context, {
        "location": selectedLatLng,
        "caption": captionController.text.trim(),
      });
    }
  }

  void _onMapTap(LatLng tappedPoint) {
    setState(() {
      selectedLatLng = tappedPoint;
    });
    mapController?.animateCamera(CameraUpdate.newLatLng(tappedPoint));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: Text('Share Location'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: MyColors.primary))
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLatLng!,
              zoom: 16,
            ),
            onMapCreated: (controller) => mapController = controller,
            markers: {
              if (selectedLatLng != null)
                Marker(
                  markerId: const MarkerId('selected'),
                  position: selectedLatLng!,
                  draggable: true,
                ),
            },
            myLocationEnabled: true,
            onTap: _onMapTap,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: captionController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Add a caption...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[800],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        maxLines: 3,
                        minLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: MyColors.primary,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _onSendLocation,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
