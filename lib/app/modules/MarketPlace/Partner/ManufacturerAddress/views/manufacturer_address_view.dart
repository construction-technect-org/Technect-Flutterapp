import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ManufacturerAddress/controller/manufacturer_address_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class ManufacturerAddressView extends GetView<ManufacturerAddressController> {
  ManufacturerAddressView({super.key});

  final CommonController homeController = Get.find<CommonController>();

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
                  title: const Text('Shipping Address'),
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
                                  SvgPicture.asset(Asset.add),
                                  const Gap(8),
                                  Text(
                                    "Add Shipping Address",
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
                            "Saved Shipping Address",
                            style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
                          ),
                          const Gap(16),
                          // Saved Addresses List
                          Obx(
                            () => homeController.profileData.value.data?.addresses?.isEmpty ?? true
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height / 3,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No Manufacturer Address Found',
                                        style: MyTexts.medium16.copyWith(color: MyColors.gray2E),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount:
                                        homeController.profileData.value.data?.addresses?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      final address =
                                          homeController.profileData.value.data?.addresses?[index];
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 16),
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
                                        child: GestureDetector(
                                          onTap: address?.isDefault == true
                                              ? null
                                              : () => controller.setDefaultAddress(
                                                  address?.id.toString() ?? '',
                                                ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: address?.isDefault == true
                                                  ? MyColors.veryPaleBlue
                                                  : Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              border: address?.isDefault == true
                                                  ? Border.all(
                                                      color: MyColors.verypaleBlue,
                                                      width: 1.2,
                                                    )
                                                  : null,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  address
                                                                          ?.addressName
                                                                          ?.capitalizeFirst ??
                                                                      'Address',
                                                                  style: MyTexts.medium16.copyWith(
                                                                    color: MyColors.black,
                                                                  ),
                                                                ),
                                                                if (address?.isDefault == true) ...[
                                                                  const Gap(8),
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets.symmetric(
                                                                          horizontal: 8,
                                                                          vertical: 3,
                                                                        ),
                                                                    decoration: BoxDecoration(
                                                                      color: MyColors.primary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(12),
                                                                    ),
                                                                    child: Text(
                                                                      'Default',
                                                                      style: MyTexts.medium13
                                                                          .copyWith(
                                                                            color: Colors.white,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ],
                                                            ),
                                                            const Gap(4),
                                                            Text(
                                                              address
                                                                      ?.fullAddress
                                                                      ?.capitalizeFirst ??
                                                                  '',
                                                              style: MyTexts.medium14.copyWith(
                                                                color: MyColors.gray54,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Gap(8),
                                                      GestureDetector(
                                                        onTap: () => controller.editAddress(
                                                          (address?.id ?? '').toString(),
                                                        ),
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: SvgPicture.asset(Asset.edit),
                                                        ),
                                                      ),
                                                      const Gap(4),
                                                      GestureDetector(
                                                        onTap: () => controller.deleteAddress(
                                                          (address?.id ?? '').toString(),
                                                        ),
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: SvgPicture.asset(Asset.delete),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
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
