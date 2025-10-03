// // saved_addresses_view.dart
// import 'package:construction_technect/app/core/utils/colors.dart';
// import 'package:construction_technect/app/core/utils/text_theme.dart';
// import 'package:construction_technect/app/modules/AddLocationManually/controller/add_location_manually_controller.dart';
// import 'package:construction_technect/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SavedAddressesView extends StatelessWidget {
//   const SavedAddressesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const background = Color(0xFFF3F2F6);
//     final controller = Get.put(AddLocationController());

//     return Scaffold(
//       backgroundColor: background,
//       appBar: AppBar(
//         backgroundColor: background,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           "Saved Addresses",
//           style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
//           child: Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (controller.addresses.isEmpty) {
//               return const Center(child: Text("No saved addresses found"));
//             }
//             return Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: MyColors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: ListView.separated(
//                 itemCount: controller.addresses.length,
//                 separatorBuilder: (_, __) =>
//                     const Divider(height: 1, color: Color(0xFFF0F0F2)),
//                 itemBuilder: (context, index) {
//                   final addr = controller.addresses[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Left icon box
//                         Container(
//                           width: 64,
//                           height: 64,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFF4F4F6),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 addr.addressType == "Home" ? Icons.Home : Icons.work,
//                                 size: 24,
//                                 color: Colors.black87,
//                               ),
//                               const SizedBox(height: 6),
//                               Text(
//                                 "—",
//                                 style: MyTexts.regular12.copyWith(
//                                   color: MyColors.fontBlack,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 12),

//                         // Middle content
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     addr.addressType,
//                                     style: MyTexts.extraBold16.copyWith(
//                                       color: MyColors.fontBlack,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   if (addr.isDefault)
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 8,
//                                         vertical: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFFDFF8EA),
//                                         borderRadius: BorderRadius.circular(16),
//                                       ),
//                                       child: Text(
//                                         'SELECTED',
//                                         style: MyTexts.regular12.copyWith(
//                                           color: MyColors.green,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(height: 6),
//                               Text(
//                                 "${addr.addressLine1}, ${addr.city} - ${addr.pinCode}",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: MyTexts.regular16.copyWith(
//                                   color: MyColors.fontBlack,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // Right menu dots
//                         const SizedBox(width: 8),
//                         GestureDetector(
//                           onTap: () {
//                             // Navigate to AddLocationManually screen with address argument
//                             Get.toNamed(
//                               Routes.ADD_LOCATION_MANUALLY,
//                               arguments: {"address": addr},
//                             );
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//                             child: Text(
//                               'Edit',
//                               style: TextStyle(
//                                 fontSize: 14, // adjust as needed
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(
//                                   0xFF007AFF,
//                                 ),  
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }



// saved_addresses_view.dart
import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/text_theme.dart';
import 'package:construction_technect/app/modules/Authentication/Location/AddLocationManually/controller/add_location_manually_controller.dart';
import 'package:construction_technect/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedAddressesView extends StatelessWidget {
  const SavedAddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddLocationController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: const Text(
          "Saved Addresses",
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.addresses.isEmpty) {
            return const Center(child: Text("No saved addresses found"));
          }

          return ListView.builder(
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final addr = controller.addresses[index];

              IconData typeIcon;
              if (addr.addressType == "Home") {
                typeIcon = Icons.home;
              } else if (addr.addressType == "Office") {
                typeIcon = Icons.business_center_outlined;
              } else {
                typeIcon = Icons.factory_outlined; // factory case
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left icon box
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(typeIcon, size: 26, color: MyColors.fontBlack),
                    ),
                    const SizedBox(width: 12),

                    // Middle content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                addr.addressType,
                                style: MyTexts.extraBold16.copyWith(
                                  color: MyColors.fontBlack,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (addr.isDefault)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDFF8EA),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    'SELECTED',
                                    style: MyTexts.regular12.copyWith(
                                      color: MyColors.green,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${addr.addressLine1}, ${addr.city} - ${addr.pinCode}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: MyTexts.regular14.copyWith(
                              color: MyColors.shadeOfGray,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right edit button
                    GestureDetector(
                      onTap: () {
                        controller.isEditing.value = true; // set editing mode
                        Get.toNamed(
                          Routes.ADD_LOCATION_MANUALLY,
                          arguments: {"address": addr},
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF007AFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
