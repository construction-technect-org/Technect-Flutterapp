// import 'package:construction_technect/app/core/utils/common_appbar.dart';
// import 'package:construction_technect/app/core/utils/imports.dart';
// import 'package:construction_technect/app/core/utils/input_field.dart';
// import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/components/product_card.dart';
// import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductManagement/controllers/product_management_controller.dart';
// import 'package:gap/gap.dart';
//
// class ProductManagementView extends StatelessWidget {
//   final ProductManagementController controller = Get.put(
//     ProductManagementController(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         backgroundColor: MyColors.white,
//         appBar: CommonAppBar(
//           isCenter: false,
//           leading: const SizedBox(),
//           leadingWidth: 0,
//           title: const Text("PRODUCT MANAGEMENT"),
//         ),
//         body: Obx(() {
//           return controller.isLoading.value
//               ? const Center(
//                   child: CircularProgressIndicator(color: MyColors.primary),
//                 )
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                       child: Column(
//                         children: [
//                           CommonTextField(
//                             onChange: (value) {
//                               controller.searchProduct(value ?? "");
//                             },
//                             borderRadius: 22,
//                             hintText: 'Search',
//                             // suffixIcon: SvgPicture.asset(
//                             //   Asset.filterIcon,
//                             //   height: 20,
//                             //   width: 20,
//                             // ),
//                             prefixIcon: SvgPicture.asset(
//                               Asset.searchIcon,
//                               height: 16,
//                               width: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: RefreshIndicator(
//                         backgroundColor: MyColors.primary,
//                         color: Colors.white,
//                         onRefresh: () async {
//                           controller.clearSearch();
//                           await controller.fetchProducts();
//                         },
//                         child: SingleChildScrollView(
//                           physics: const AlwaysScrollableScrollPhysics(),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                 ),
//                                 child: IntrinsicHeight(
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: MyColors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               12,
//                                             ),
//                                             border: Border.all(
//                                               color: MyColors.black,
//                                             ),
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 8,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SvgPicture.asset(
//                                                 Asset.noOfConectors,
//                                               ),
//                                               const Gap(10),
//                                               Text(
//                                                 "Total Products",
//                                                 style: MyTexts.regular14
//                                                     .copyWith(
//                                                       color: MyColors.black,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 controller
//                                                     .statistics
//                                                     .value
//                                                     .totalProducts
//                                                     .toString(),
//                                                 style: MyTexts.bold16.copyWith(
//                                                   color: MyColors.fontBlack,
//                                                 ),
//                                               ),
//                                               const Gap(10),
//                                               Text(
//                                                 "Active Products",
//                                                 style: MyTexts.regular14
//                                                     .copyWith(
//                                                       color: MyColors.black,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 controller
//                                                     .statistics
//                                                     .value
//                                                     .featured
//                                                     .toString(),
//                                                 style: MyTexts.bold16.copyWith(
//                                                   color: MyColors.green,
//                                                 ),
//                                               ),
//                                               const Gap(5),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       const Gap(12),
//                                       Expanded(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: MyColors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               12,
//                                             ),
//                                             border: Border.all(
//                                               color: MyColors.americanSilver,
//                                             ),
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 8,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const Gap(10),
//                                               SvgPicture.asset(Asset.warning),
//                                               const Gap(10),
//                                               Text(
//                                                 "Low Stock",
//                                                 style: MyTexts.regular16
//                                                     .copyWith(
//                                                       color: MyColors.gray53,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 controller
//                                                     .statistics
//                                                     .value
//                                                     .lowStock
//                                                     .toString(),
//                                                 style: MyTexts.bold20.copyWith(
//                                                   color: MyColors.redgray,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       const Gap(12),
//                                       Expanded(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: MyColors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               12,
//                                             ),
//                                             border: Border.all(
//                                               color: MyColors.americanSilver,
//                                             ),
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 8,
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               const Gap(10),
//                                               Text(
//                                                 "Interest Products",
//                                                 style: MyTexts.regular14
//                                                     .copyWith(
//                                                       color: MyColors.black,
//                                                     ),
//                                                 textAlign: TextAlign.center,
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               const Gap(15),
//                                               Stack(
//                                                 alignment: Alignment.center,
//                                                 children: [
//                                                   SizedBox(
//                                                     width: 55,
//                                                     height: 55,
//                                                     child: CircularProgressIndicator(
//                                                       value:
//                                                           (double.tryParse(
//                                                                 "${controller.statistics.value.totalInterests}",
//                                                               ) ??
//                                                               0) /
//                                                           100,
//                                                       strokeWidth: 8,
//                                                       backgroundColor: MyColors
//                                                           .profileRemaining,
//                                                       valueColor:
//                                                           const AlwaysStoppedAnimation<
//                                                             Color
//                                                           >(MyColors.redgray),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     '${controller.statistics.value.totalInterests}%',
//                                                     style: MyTexts.medium16
//                                                         .copyWith(
//                                                           color: MyColors.black,
//                                                         ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Obx(
//                                 () => Padding(
//                                   padding: EdgeInsets.zero,
//                                   child: controller.filteredProducts.isEmpty
//                                       ? Padding(
//                                           padding: const EdgeInsets.only(
//                                             top: 100.0,
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               const Gap(20),
//                                               Icon(
//                                                 controller
//                                                         .searchQuery
//                                                         .value
//                                                         .isNotEmpty
//                                                     ? Icons.search_off
//                                                     : Icons
//                                                           .inventory_2_outlined,
//                                                 size: 64,
//                                                 color: MyColors.grey,
//                                               ),
//                                               SizedBox(height: 2.h),
//                                               Text(
//                                                 controller
//                                                         .searchQuery
//                                                         .value
//                                                         .isNotEmpty
//                                                     ? 'No products found'
//                                                     : 'No products available',
//                                                 style: MyTexts.medium18
//                                                     .copyWith(
//                                                       color: MyColors.fontBlack,
//                                                     ),
//                                               ),
//                                               SizedBox(height: 0.5.h),
//                                               Text(
//                                                 controller
//                                                         .searchQuery
//                                                         .value
//                                                         .isNotEmpty
//                                                     ? 'Try searching with different keywords'
//                                                     : 'Add your first product to get started',
//                                                 style: MyTexts.regular14
//                                                     .copyWith(
//                                                       color: MyColors.grey,
//                                                     ),
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       : SingleChildScrollView(
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 20,
//                                             horizontal: 18,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "All Products",
//                                                 style: MyTexts.medium18
//                                                     .copyWith(
//                                                       color: MyColors.fontBlack,
//                                                   fontFamily: MyTexts.SpaceGrotesk
//                                                     ),
//                                               ),
//                                               const Gap(16),
//                                               Wrap(
//                                                 spacing: 12,
//                                                 runSpacing: 12,
//                                                 children: controller
//                                                     .filteredProducts
//                                                     .map((product) {
//                                                       return GestureDetector(
//                                                         onTap: () {
//                                                           Get.toNamed(
//                                                             Routes
//                                                                 .PRODUCT_DETAILS,
//                                                             arguments: {
//                                                               "product":
//                                                                   product,
//                                                               "isFromAdd":
//                                                                   false,
//                                                               "isFromConnector":
//                                                                   false,
//                                                             },
//                                                           );
//                                                         },
//                                                         child: SizedBox(
//                                                           width:
//                                                               Get.width / 2 -
//                                                               24,
//                                                           child: ProductCard(
//                                                             product: product,
//                                                           ),
//                                                         ),
//                                                       );
//                                                     })
//                                                     .toList(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 2.h),
//                   ],
//                 );
//         }),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.only(left: 120, right: 120, bottom: 20),
//           child: RoundedButton(
//             onTap: () {
//               Get.toNamed(Routes.ADD_PRODUCT);
//             },
//             buttonName: '',
//             borderRadius: 12,
//             width: 50,
//             height: 45,
//             verticalPadding: 0,
//             horizontalPadding: 0,
//             child: Center(
//               child: Text(
//                 '+ Add Product',
//                 style: MyTexts.medium16.copyWith(
//                   color: MyColors.white,
//                   fontFamily: MyTexts.SpaceGrotesk,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
