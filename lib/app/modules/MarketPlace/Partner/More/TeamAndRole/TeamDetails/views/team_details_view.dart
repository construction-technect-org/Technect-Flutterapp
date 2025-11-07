// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:construction_technect/app/core/utils/imports.dart';
// import 'package:construction_technect/app/core/widgets/photo_view.dart';
// import 'package:construction_technect/app/core/widgets/welcome_name.dart';
// import 'package:construction_technect/app/modules/MarketPlace/Partner/More/TeamAndRole/TeamDetails/controllers/team_details_controller.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
//
// class TeamDetailsView extends GetView<TeamDetailsController> {
//   const TeamDetailsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: MyColors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0.0,
//         title: WelcomeName(),
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.only(bottom: 3.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 1.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 4.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Team Details",
//                       style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.toNamed(
//                           Routes.ADD_TEAM,
//                           arguments: {"data": controller.teamDetailsModel},
//                         );
//                       },
//                       child: Container(
//                         width: 7.w,
//                         height: 3.5.h,
//                         decoration: BoxDecoration(
//                           color: MyColors.primary,
//                           borderRadius: BorderRadius.circular(2.w),
//                         ),
//                         child: const Icon(Icons.edit, size: 16, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// Team Info Card
//               Padding(
//                 padding: EdgeInsets.all(4.w),
//                 child: Obx(
//                   () => Container(
//                     padding: EdgeInsets.all(3.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(3.w),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 4.h,
//                               child: ClipOval(
//                                 child: CachedNetworkImage(
//                                   imageUrl: controller.profileUrl.value.isNotEmpty
//                                       ? controller.profileUrl.value
//                                       : "https://via.placeholder.com/150",
//                                   width: 8.h,
//                                   height: 8.h,
//                                   fit: BoxFit.cover,
//                                   placeholder: (context, url) => Container(
//                                     width: 8.h,
//                                     height: 8.h,
//                                     decoration: const BoxDecoration(
//                                       color: MyColors.grey1,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Center(
//                                       child: CupertinoActivityIndicator(
//                                         color: MyColors.primary,
//                                         radius: 1.h,
//                                       ),
//                                     ),
//                                   ),
//                                   errorWidget: (context, url, error) => Container(
//                                     width: 8.h,
//                                     height: 8.h,
//                                     decoration: const BoxDecoration(
//                                       color: MyColors.grey1,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(
//                                       Icons.person,
//                                       color: MyColors.grey,
//                                       size: 3.h,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 3.w),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     controller.userName.value,
//                                     style: MyTexts.extraBold20.copyWith(
//                                       color: MyColors.fontBlack,
//                                     ),
//                                   ),
//                                   Text(
//                                     controller.userEmail.value,
//                                     style: MyTexts.regular14.copyWith(
//                                       color: MyColors.lightGray,
//                                     ),
//                                   ),
//                                   Text(
//                                     "User Role: ${controller.userRole.value}",
//                                     style: MyTexts.regular14.copyWith(
//                                       color: MyColors.fontBlack,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Divider(color: MyColors.hexGray92),
//                         Row(
//                           children: [
//                             const Icon(Icons.phone, size: 18, color: MyColors.primary),
//                             SizedBox(width: 2.w),
//                             Text(
//                               controller.userPhone.value,
//                               style: MyTexts.regular14.copyWith(
//                                 color: MyColors.lightGray,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 1.h),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.location_on,
//                               size: 18,
//                               color: MyColors.primary,
//                             ),
//                             SizedBox(width: 2.w),
//                             Expanded(
//                               child: Text(
//                                 controller.userAddress.value,
//                                 style: MyTexts.regular14.copyWith(
//                                   color: MyColors.lightGray,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 2.h),
//
//               /// Documents Section
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 4.w),
//                 child: const Text(
//                   "Documents",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(height: 1.5.h),
//
//               Obx(
//                 () => controller.documents.isEmpty
//                     ? const Center(child: Text('No Data Found !!'))
//                     : Column(
//                         children: controller.documents.map((doc) {
//                           return Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
//                             child: _buildCertificationItem(
//                               doc["title"]!,
//                               doc["url"]!,
//                               doc["type"]!,
//                               context,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildCertificationItem(
//   String title,
//   String organization,
//   String expiryDate,
//   BuildContext context,
// ) {
//   return DottedBorder(
//     options: const RectDottedBorderOptions(color: Color(0xFF8C8C8C), dashPattern: [5, 5]),
//     child: Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
//       decoration: BoxDecoration(
//         color: MyColors.white,
//         borderRadius: BorderRadius.circular(3.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: 10.w,
//                 height: 5.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFD9F0FF),
//                   borderRadius: BorderRadius.circular(2.w),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(2.w),
//                   child: SvgPicture.asset(
//                     Asset.certificateIcon,
//                     colorFilter: const ColorFilter.mode(
//                       MyColors.primary,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PhotoView(image: organization),
//                         ),
//                       );
//                     },
//                     child: SvgPicture.asset(Asset.viewEye),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 2.h),
//
//           /// Content
//           Text(
//             title,
//             style: MyTexts.medium22.copyWith(
//               color: MyColors.black,
//               fontFamily: MyTexts.SpaceGrotesk,
//             ),
//           ),
//
//           Text(
//             organization,
//             style: MyTexts.medium14.copyWith(
//               color: const Color(0xFF717171),
//               fontFamily: MyTexts.SpaceGrotesk,
//             ),
//           ),
//           SizedBox(height: 0.5.h),
//           Text(
//             expiryDate,
//             style: MyTexts.medium14.copyWith(
//               color: const Color(0xFF717171),
//               fontFamily: MyTexts.SpaceGrotesk,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
