import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/ServiceDetail/controllers/service_detail_controller.dart';

class ServiceDetailsView extends GetView<ServiceDetailsController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MyColors.veryPaleBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: MyColors.veryPaleBlue,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
          ),
          title: Text(
            "Service Details",
            style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 360.w,
                  height: 30.h,
                  decoration: const BoxDecoration(
                    color: MyColors.veryPaleBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(37),
                      bottomRight: Radius.circular(37),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 2.h),
                  alignment: Alignment.center,
                  child: Obx(
                    () =>
                        controller.service.value.serviceImage != null &&
                            controller.service.value.serviceImage!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl:
                                "${APIConstants.bucketUrl}${controller.service.value.serviceImage}",
                            width: 200.w,
                            height: 200.w,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 200.w,
                              height: 200.w,
                              decoration: const BoxDecoration(
                                color: MyColors.grey1,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(color: MyColors.primary),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 200.w,
                              height: 200.w,
                              decoration: const BoxDecoration(
                                color: MyColors.grey1,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: MyColors.grey,
                              ),
                            ),
                          )
                        : Container(
                            width: 200.w,
                            height: 200.w,
                            decoration: const BoxDecoration(
                              color: MyColors.grey1,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: MyColors.grey,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.service.value.serviceName ?? '',
                        style: MyTexts.extraBold20.copyWith(color: MyColors.fontBlack),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Obx(
                      () => Text(
                        controller.service.value.serviceTypeName ?? '',
                        style: MyTexts.regular16.copyWith(color: MyColors.primary),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Obx(
                      () => Text(
                        '₹${controller.service.value.price ?? '0'}/unit',
                        style: MyTexts.medium24.copyWith(color: MyColors.primary),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.veryPaleBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'UOM',
                                  style: MyTexts.regular14.copyWith(
                                    color: MyColors.graniteg,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Obx(
                                  () => Text(
                                    controller.service.value.uom ?? '',
                                    style: MyTexts.bold16.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.veryPaleBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GST%',
                                  style: MyTexts.regular14.copyWith(
                                    color: MyColors.graniteg,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Obx(
                                  () => Text(
                                    '${controller.service.value.gstPercentage ?? '0'}%',
                                    style: MyTexts.bold16.copyWith(
                                      color: MyColors.fontBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Description',
                      style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
                    ),
                    SizedBox(height: 1.h),
                    Obx(
                      () => Text(
                        controller.service.value.description ?? '',
                        style: MyTexts.regular16.copyWith(
                          color: MyColors.graniteg,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Terms & Conditions',
                      style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
                    ),
                    SizedBox(height: 1.h),
                    Obx(
                      () => Text(
                        controller.service.value.termsAndConditions ?? '',
                        style: MyTexts.regular16.copyWith(
                          color: MyColors.graniteg,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Expanded(
                          child: RoundedButton(
                            borderRadius: 12,
                            height: 50,
                            verticalPadding: 0,
                            fontSize: 16.sp,
                            buttonName: 'EDIT SERVICE',
                            onTap: () {
                              Get.toNamed(
                                Routes.ADD_SERVICE,
                                arguments: {
                                  "service": controller.service.value,
                                  "isEdit": true,
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (controller.service.value.isActive == true) {
                                controller.showDeleteConfirmationDialog();
                              } else {
                                SnackBars.errorSnackBar(
                                  content: 'Activate functionality coming soon',
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: MyColors.primary),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    controller.service.value.isActive == true
                                        ? 'DELETE'
                                        : 'ACTIVATE',
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
