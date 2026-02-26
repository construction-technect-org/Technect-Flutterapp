import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/DeliveryLocation/controller/delivery_location_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class DeliveryLocationView extends GetView<DeliveryLocationController> {
  DeliveryLocationView({super.key});

  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        body: Stack(
          children: [
            const CommonBgImage(),
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink(),
            ),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Select location'),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(16),
                          // Build Search for also i wat border for it
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: MyColors.gra54.withValues(alpha: 0.8)),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColors.grayEA.withValues(alpha: 0.32),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: MyColors.gray2E),
                                const Gap(8),
                                Text(
                                  "Search",
                                  style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                ),
                                const Spacer(),
                                // microphone icon
                                Icon(Icons.mic, color: MyColors.gray2E),
                              ],
                            ),
                          ),
                          const Gap(16),
                          // Add Address Button
                          GestureDetector(
                            onTap: controller.addAddress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColors.grayEA.withValues(alpha: 0.32),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(Icons.gps_not_fixed_rounded, color: MyColors.gray2E),
                                  const Gap(8),
                                  Text(
                                    "Use my Current Location",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.addAddress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColors.grayEA.withValues(alpha: 0.32),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  SvgPicture.asset(Asset.add),
                                  const Gap(8),
                                  Text(
                                    "Add New Address",
                                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ),
                          const Gap(16),
                          Text(
                            "Saved Address",
                            style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
                          ),
                          const Gap(16),
                          // Saved Addresses List
                          Obx(
                            () => CommonAddressList(
                              addresses: Get.find<CommonController>()
                                  .profileData
                                  .value
                                  .data
                                  ?.siteLocations,
                              onEdit: commonController.editAddress,
                              onDelete: commonController.deleteAddress,
                              onSetDefault: commonController.setDefaultAddress,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommonAddressList extends StatelessWidget {
  final List<dynamic>? addresses;
  final Function(String id)? onEdit;
  final Function(String id)? onDelete;
  final Function(String id)? onSetDefault;
  final bool? isBack;

  const CommonAddressList({
    super.key,
    required this.addresses,
    this.onEdit,
    this.onDelete,
    this.onSetDefault,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<dynamic> displayAddresses = (addresses == null || addresses!.isEmpty)
        ? [
            {
              'id': '1',
              'siteName': 'Manufacturing unit',
              'fullAddress': 'Garuda Bhive, BMTC Complex, Outer Ring Rd, Old Madiwala, Ku...',
              'isDefault': true,
              'siteCode': 'MFG-001',
            },
            {
              'id': '2',
              'siteName': 'Stockyard',
              'fullAddress': 'Garuda Bhive, BMTC Complex, Outer Ring Rd, Old Madiwala, Ku...',
              'isDefault': false,
              'siteCode': 'STK-402',
            },
            {
              'id': '3',
              'siteName': 'Billing Address',
              'fullAddress': 'Garuda Bhive, BMTC Complex, Outer Ring Rd, Old Madiwala, Ku...',
              'isDefault': false,
              'siteCode': 'BIL-990',
            },
          ]
        : addresses!;

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: displayAddresses.length,
      itemBuilder: (context, index) {
        final addressData = displayAddresses[index];
        // Convert to Map if dynamic
        final Map<String, dynamic> address = (addressData is Map)
            ? addressData.cast<String, dynamic>()
            : {
                'id': addressData.id?.toString(),
                'siteName': addressData.siteName,
                'fullAddress': addressData.fullAddress,
                'isDefault': addressData.isDefault,
                'siteCode': addressData.siteCode,
              };

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: MyColors.grayEA.withValues(alpha: 0.32), blurRadius: 4)],
          ),
          child: GestureDetector(
            onTap: address['isDefault'] == true
                ? (isBack == true ? () => Get.back() : null)
                : () => onSetDefault?.call(address['id'].toString()),
            child: Container(
              decoration: BoxDecoration(
                color: address['isDefault'] == true ? MyColors.veryPaleBlue : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: address['isDefault'] == true
                    ? Border.all(color: MyColors.verypaleBlue, width: 1.2)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: MyColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.location_on, color: MyColors.primary, size: 18),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    address['siteName'] ?? 'Address',
                                    style: MyTexts.medium16.copyWith(color: MyColors.black),
                                  ),
                                  if (address['isDefault'] == true) ...[
                                    const Gap(8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: MyColors.primary,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Default',
                                        style: MyTexts.medium13.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const Gap(4),
                              Text(
                                address['fullAddress'] ?? '',
                                style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Share functionality (e.g., using share_plus)
                              },
                              child: const Icon(
                                Icons.share_outlined,
                                size: 20,
                                color: MyColors.grey,
                              ),
                            ),
                            const Gap(8),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  onEdit?.call(address['id'].toString());
                                } else if (value == 'delete') {
                                  onDelete?.call(address['id'].toString());
                                }
                              },
                              icon: const Icon(Icons.more_horiz, size: 20, color: MyColors.grey),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_outlined, size: 18),
                                      Gap(8),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline, color: Colors.red, size: 18),
                                      Gap(8),
                                      Text('Delete', style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topRight: Radius.circular(12),
                      ),
                      color: address['isDefault'] == true ? Colors.white : MyColors.gra54EA,
                    ),
                    child: Text(
                      "Site Code: ${address['siteCode'] ?? '-'}",
                      style: MyTexts.medium14.copyWith(color: MyColors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
