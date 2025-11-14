import 'dart:io';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/controller/add_service_controller.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

class AddServiceScreen extends GetView<AddServiceController> {
  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          appBar: const CommonAppBar(
            title: Text("Add Service"),
            isCenter: false,
          ),
          backgroundColor: MyColors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.isEdit.value)
                    Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(5, (index) {
                            final path = controller.imageSlots[index];

                            if (path != null) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                      top: 8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                              insetPadding:
                                                  const EdgeInsets.all(16),
                                              child: InteractiveViewer(
                                                child: path.contains('http')
                                                    ? Image.network(
                                                        path,
                                                        width: 360.w,
                                                        fit: BoxFit.contain,
                                                        errorBuilder:
                                                            (
                                                              _,
                                                              _,
                                                              _,
                                                            ) => const Icon(
                                                              Icons
                                                                  .broken_image,
                                                              size: 60,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      )
                                                    : Image.file(
                                                        File(path),
                                                        fit: BoxFit.contain,
                                                      ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: path.contains('http')
                                            ? getImageView(
                                                finalUrl: path,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(path),
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.removeImageAt(index),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  top: 8,
                                ),
                                child: GestureDetector(
                                  onTap: controller.pickImageEdit,
                                  child: Container(
                                    width: 78,
                                    height: 78,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.grayCD,
                                        width: 1.2,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                      color: MyColors.grayEA,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Asset.add,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                  if (!controller.isEdit.value)
                    Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...controller.pickedFilePathList.map(
                              (path) => Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                      top: 8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(53),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.dialog(
                                            Dialog(
                                              backgroundColor: Colors.white,
                                              insetPadding:
                                                  const EdgeInsets.all(20),
                                              child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  InteractiveViewer(
                                                    child: path.contains('http')
                                                        ? Image.network(
                                                            path,
                                                            fit: BoxFit.contain,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          )
                                                        : Image.file(
                                                            File(path),
                                                            fit: BoxFit.contain,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          16.0,
                                                        ),
                                                    child: GestureDetector(
                                                      onTap: () => Get.back(),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: path.contains('http')
                                            ? getImageView(
                                                finalUrl: path,
                                                width: 78,
                                                height: 78,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(path),
                                                width: 78,
                                                height: 78,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => controller.pickedFilePathList
                                          .remove(path),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (controller.pickedFilePathList.length < 5)
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  top: 8,
                                ),
                                child: GestureDetector(
                                  onTap: controller.pickImage,
                                  child: Container(
                                    width: 78,
                                    height: 78,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.grayCD,
                                        width: 1.2,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                      color: MyColors.grayEA,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Asset.add,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  SizedBox(height: 3.h),

                  Obx(() {
                    return CommonDropdown<String>(
                      headerText: 'Main Category',
                      validator: (val) => val == null || val.isEmpty
                          ? "Please select a main category"
                          : null,
                      hintText: "Select Main Category",
                      items: controller.mainCategories
                          .map((e) => e.name ?? "")
                          .toList(),
                      selectedValue:
                          (controller.selectedMainCategory.value?.name ?? "")
                              .obs,
                      itemLabel: (item) => item,
                      onChanged: controller.isEdit.value
                          ? null
                          : controller.onMainCategorySelected,
                      enabled: !controller.isEdit.value,
                    );
                  }),
                  const Gap(16),

                  Obx(() {
                    return CommonDropdown<String>(
                      headerText: 'Sub Category',
                      validator: (val) => val == null || val.isEmpty
                          ? "Please select a sub category"
                          : null,
                      hintText: "Select Sub Category",
                      items: controller.subCategories
                          .map((e) => e.name ?? "")
                          .toList(),
                      selectedValue:
                          (controller.selectedSubCategory.value?.name ?? "")
                              .obs,
                      itemLabel: (item) => item,
                      onChanged: controller.isEdit.value
                          ? null
                          : controller.onSubCategorySelected,
                      enabled: !controller.isEdit.value,
                    );
                  }),
                  const Gap(16),

                  Obx(() {
                    return CommonDropdown<String>(
                      headerText: 'Service Category',
                      validator: (val) => val == null || val.isEmpty
                          ? "Please select a service category"
                          : null,
                      hintText: "Select Service Category",
                      items: controller.serviceCategories
                          .map((e) => e.name ?? "")
                          .toList(),
                      selectedValue:
                          (controller.selectedServiceCategory.value?.name ?? "")
                              .obs,
                      itemLabel: (item) => item,
                      onChanged: controller.isEdit.value
                          ? null
                          : controller.onServiceCategorySelected,
                      enabled: !controller.isEdit.value,
                    );
                  }),
                  const Gap(16),
                  CommonTextField(
                    controller: controller.unitController,
                    headerText: "Unit",
                    hintText: "Enter unit (e.g., Sqft, Hour, etc.)",
                    validator: (val) => val == null || val.isEmpty
                        ? "Please enter service unit"
                        : null,
                  ),
                  const Gap(16),

                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          headerText: 'Price',
                          hintText: "ENTER PRICE",
                          controller: controller.priceController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter price";
                            }
                            if (double.tryParse(val) == null) {
                              return "Enter valid number";
                            }
                            if (int.tryParse(val) == 0) {
                              return "Rate can not be zero";
                            }
                            return null;
                          },
                          onChange: (p0) {
                            if (controller.selectedGST.value != null) {
                              controller.gstCalculate();
                            }
                          },
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "₹",
                              style: MyTexts.regular20.copyWith(
                                color: MyColors.lightBlueSecond,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: CommonDropdown<String>(
                          headerText: 'GST',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please select gst";
                            }
                            return null;
                          },
                          onChanged: (val) {
                            if ((val ?? "").isNotEmpty) {
                              if (controller.priceController.text.isNotEmpty) {
                                controller.gstCalculate();
                              }
                            }
                          },
                          hintText: "SELECT GST PERCENTAGE",
                          items: const ["5%", "12%", "18%", "28%"],
                          selectedValue: controller.selectedGST,
                          itemLabel: (item) => item,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          readOnly: true,
                          headerText: 'Amount',
                          hintText: "ENTER AMOUNT",
                          controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          onChange: (p0) {},
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "₹",
                              style: MyTexts.regular20.copyWith(
                                color: MyColors.lightBlueSecond,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const Gap(20),
                      Expanded(
                        child: CommonTextField(
                          headerText: 'GST amount',
                          hintText: "GST AMOUNT",
                          readOnly: true,
                          controller: controller.gstPriceController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  const Gap(20),
                  CommonTextField(
                    controller: controller.descriptionController,
                    headerText: "Description",
                    hintText: "Enter service description",
                    validator: (val) => val == null || val.isEmpty
                        ? "Please enter service description"
                        : null,
                    maxLine: 3,
                  ),
                  const Gap(16),
                  CommonTextField(
                    controller: controller.noteController,
                    headerText: "Note",
                    hintText: "Enter service note",
                    maxLine: 2,
                    validator: (val) => val == null || val.isEmpty
                        ? "Please enter service note"
                        : null,
                  ),
                  const Gap(16),
                  CommonTextField(
                    controller: controller.refUrlController,
                    headerText: "Reference Url (Optional)",
                    hintText: "Enter reference url",
                  ),
                  const Gap(20),
                  Text(
                    "Features",
                    style: MyTexts.medium16.copyWith(color: MyColors.black),
                  ),
                  const Gap(8),
                  Obx(() {
                    return Column(
                      children: [
                        ...List.generate(controller.featureList.length, (
                          index,
                        ) {
                          final feature = controller.featureList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Feature ${index + 1}",
                                    style: MyTexts.medium14.copyWith(
                                      color: MyColors.lightBlueSecond,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        controller.removeFeature(index),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              CommonTextField(
                                controller: feature.headerController,
                                headerText: "Header",
                                hintText: "Enter feature header",
                                validator: (val) => val == null || val.isEmpty
                                    ? "Please enter header"
                                    : null,
                              ),
                              const Gap(10),
                              CommonTextField(
                                controller: feature.descController,
                                headerText: "Detail",
                                hintText: "Enter feature detail",
                                validator: (val) => val == null || val.isEmpty
                                    ? "Please enter detail"
                                    : null,
                                maxLine: 2,
                              ),
                              const Divider(thickness: 1, height: 24),
                            ],
                          );
                        }),
                        GestureDetector(
                          onTap: controller.addNewFeature,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.lightBlueSecond.withOpacity(0.1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: MyColors.lightBlueSecond,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Add Feature",
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.lightBlueSecond,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const Gap(20),
                  //==============Service Demo Video===================
                  Text(
                    "Service Demo Video",
                    style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                  ),
                  const Gap(16),
                  if (controller.isEdit.value)
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MyColors.grayF7,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyColors.grayEA),
                        ),
                        child: Column(
                          children: [
                            if (controller.selectedVideo.value != null)
                              Stack(
                                alignment: AlignmentGeometry.topRight,
                                children: [
                                  //play video
                                  GestureDetector(
                                    onTap: () {
                                      controller.openVideoDialog(
                                        context,
                                        ((controller
                                                        .selectedVideo
                                                        .value
                                                        ?.path ??
                                                    "") ==
                                                "abc")
                                            ? (controller
                                                      .serviceVid
                                                      .value
                                                      .mediaUrl ??
                                                  "")
                                            : (controller
                                                      .selectedVideo
                                                      .value
                                                      ?.path ??
                                                  ""),
                                        true,
                                      );
                                    },
                                    child: Stack(
                                      alignment: AlignmentGeometry.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: AspectRatio(
                                            // aspectRatio isPortrait ?
                                            //     9 / 16
                                            //     : 16 / 9,
                                            aspectRatio: 16 / 9,
                                            child: ColoredBox(
                                              color: Colors.black,
                                              child: Center(
                                                child: AspectRatio(
                                                  aspectRatio: controller
                                                      .videoPlayerController!
                                                      .value
                                                      .aspectRatio,
                                                  child: VideoPlayer(
                                                    controller
                                                        .videoPlayerController!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const VideoPlay(),
                                      ],
                                    ),
                                  ),
                                  //delect icon
                                  GestureDetector(
                                    onTap: controller.removeVideo,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(Asset.delete),
                                    ),
                                  ),
                                ],
                              )
                            else
                              //No video
                              GestureDetector(
                                onTap: () => controller
                                    .openVideoPickerBottomSheet(Get.context!),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Gap(24),

                                      SvgPicture.asset(Asset.add, height: 40),
                                      const Gap(16),
                                      Text(
                                        "Upload Video (max 10 MB)",
                                        textAlign: TextAlign.center,
                                        style: MyTexts.regular14,
                                      ),
                                      const Gap(24),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  //add Service
                  if (!controller.isEdit.value)
                    Obx(() {
                      final video = controller.selectedVideo.value;
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MyColors.grayF7,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyColors.grayEA),
                        ),
                        child: Column(
                          children: [
                            if (video != null)
                              Stack(
                                alignment: AlignmentGeometry.topRight,
                                children: [
                                  Stack(
                                    alignment: AlignmentGeometry.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: AspectRatio(
                                          // aspectRatio isPortrait ?
                                          //     9 / 16
                                          //     : 16 / 9,
                                          aspectRatio: 16 / 9,
                                          child: ColoredBox(
                                            color: Colors.black,
                                            child: Center(
                                              child: AspectRatio(
                                                aspectRatio: controller
                                                    .videoPlayerController!
                                                    .value
                                                    .aspectRatio,
                                                child: VideoPlayer(
                                                  controller
                                                      .videoPlayerController!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          OpenFilex.open(video.path);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColors.primary,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          child: const Icon(
                                            Icons.video_camera_back_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: controller.removeVideo,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(Asset.delete),
                                    ),
                                  ),
                                ],
                              )
                            else
                              GestureDetector(
                                onTap: () => controller
                                    .openVideoPickerBottomSheet(Get.context!),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Gap(24),

                                      SvgPicture.asset(Asset.add, height: 40),
                                      const Gap(16),
                                      Text(
                                        "Upload Video (max 10 MB)",
                                        textAlign: TextAlign.center,
                                        style: MyTexts.regular14,
                                      ),
                                      const Gap(24),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  const Gap(24),
                  //==============Reference File (Optional)===================
                  Text(
                    "Reference File (Optional)",
                    style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                  ),
                  const Gap(12),

                  Obx(() {
                    if (!controller.referenceDeleted.value) {
                      final reference = controller.serviceRef.value;
                      final hasReference =
                          reference.referenceS3Key?.isNotEmpty ?? false;

                      // If reference deleted manually, show add UI again
                      if (controller.referenceDeleted.value || !hasReference) {
                        return GestureDetector(
                          onTap: controller.pickReferenceFile,
                          // your existing picker
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColors.grayEA,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.grayD4),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_circle_outline,
                                  size: 40,
                                  color: MyColors.primary,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Add Reference File",
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.gray54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final referenceType =
                          reference.referenceType?.toLowerCase() ?? '';
                      final referenceUrl =
                          APIConstants.bucketUrl +
                          (reference.referenceS3Key ?? '');

                      Widget referenceWidget;

                      // --- VIDEO ---
                      if (referenceType == 'video') {
                        referenceWidget = GestureDetector(
                          onTap: () => controller.openVideoDialog(
                            context,
                            referenceUrl,
                            true,
                          ),
                          child: Stack(
                            alignment: AlignmentGeometry.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: AspectRatio(
                                  // aspectRatio isPortrait ?
                                  //     9 / 16
                                  //     : 16 / 9,
                                  aspectRatio: 16 / 9,
                                  child: ColoredBox(
                                    color: Colors.black,
                                    child: Center(
                                      child: AspectRatio(
                                        aspectRatio: controller
                                            .refVideoPlayerController!
                                            .value
                                            .aspectRatio,
                                        child: VideoPlayer(
                                          controller.refVideoPlayerController!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const VideoPlay(),
                            ],
                          ),
                        );
                      }
                      // --- IMAGE ---
                      else if (referenceType == 'image') {
                        referenceWidget = GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                insetPadding: const EdgeInsets.all(16),
                                child: InteractiveViewer(
                                  child: Image.network(
                                    referenceUrl,
                                    width: 360.w,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.broken_image,
                                              size: 60,
                                              color: Colors.grey,
                                            ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              referenceUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    height: 200,
                                    color: MyColors.grayEA,
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 200,
                                      color: MyColors.grayEA,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                            ),
                          ),
                        );
                      } else if (referenceType == 'pdf' ||
                          referenceType == 'document') {
                        referenceWidget = GestureDetector(
                          onTap: () =>
                              controller.openReferenceUrl(referenceUrl),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: MyColors.grayEA,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColors.grayD4),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  referenceType == 'pdf'
                                      ? Icons.picture_as_pdf
                                      : Icons.description,
                                  size: 64,
                                  color: MyColors.primary,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  reference.referenceType?.toUpperCase() ??
                                      'Document',
                                  style: MyTexts.medium16.copyWith(
                                    color: MyColors.fontBlack,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap to open',
                                  style: MyTexts.medium14.copyWith(
                                    color: MyColors.gray54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      // --- UNKNOWN ---
                      else {
                        referenceWidget = Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: MyColors.grayEA,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.insert_drive_file,
                              size: 64,
                              color: MyColors.gray54,
                            ),
                          ),
                        );
                      }

                      return Stack(
                        alignment: AlignmentGeometry.topRight,
                        children: [
                          referenceWidget,
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.deleteReferenceFile();
                            },
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  Obx(() {
                    if (controller.referenceDeleted.value) {
                      final file = controller.referenceFile.value;
                      final url = controller.referenceFileUrl.value;

                      Widget? preview;

                      if (file != null) {
                        final ext = file.path.split('.').last.toLowerCase();
                        preview = _buildReferencePreview(ext, file.path);
                      } else if (url.isNotEmpty) {
                        final ext = url.split('.').last.toLowerCase();
                        preview = _buildReferencePreview(
                          ext,
                          url,
                          isNetwork: true,
                        );
                      }

                      return Row(
                        children: [
                          if (preview != null)
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      OpenFilex.open(file?.path ?? url),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: preview,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: controller.removeReferenceFile,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(3),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            GestureDetector(
                              onTap: controller.pickReferenceFile,
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: MyColors.grayCD,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: MyColors.grayEA,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 28,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  const Gap(32),
                  RoundedButton(
                    buttonName: controller.isEdit.value
                        ? "Update Service"
                        : "Add Service",
                    onTap: () async {
                      if (controller.pickedFilePathList.isEmpty &&
                          !controller.isEdit.value) {
                        SnackBars.errorSnackBar(
                          content: 'Please upload at least one image',
                        );
                        return;
                      }

                      if (controller.videoPlayerController == null &&
                          !controller.isEdit.value) {
                        SnackBars.errorSnackBar(
                          content: 'Please upload service demo video',
                        );
                        return;
                      }
                      if (controller.isEdit.value) {
                        final hasImage = controller.imageSlots.any(
                          (path) =>
                              path != null && path.toString().trim().isNotEmpty,
                        );
                        if (!hasImage) {
                          SnackBars.errorSnackBar(
                            content: 'Please upload at least one image',
                          );
                          return;
                        }
                      }
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        if (controller.isEdit.value) {
                          controller.updateService(controller.serviceId.value);
                        } else {
                          controller.createService();
                        }
                      } else {
                        SnackBars.errorSnackBar(
                          content: "Please fill all required fields properly",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReferencePreview(
    String ext,
    String path, {
    bool isNetwork = false,
  }) {
    if (['jpg', 'jpeg', 'png'].contains(ext)) {
      return isNetwork
          ? Image.network(path, width: 90, height: 90, fit: BoxFit.cover)
          : Image.file(File(path), width: 90, height: 90, fit: BoxFit.cover);
    } else if (ext == 'mp4') {
      return Container(
        width: 90,
        height: 90,
        color: Colors.black12,
        child: const Icon(Icons.videocam, color: MyColors.primary),
      );
    } else if (ext == 'pdf') {
      return Container(
        width: 90,
        height: 90,
        color: Colors.red.shade50,
        child: const Icon(Icons.picture_as_pdf, color: Colors.red),
      );
    } else {
      return Container(
        width: 90,
        height: 90,
        color: Colors.blue.shade50,
        child: const Icon(Icons.description, color: Colors.blue),
      );
    }
  }
}

class VideoPlay extends StatelessWidget {
  const VideoPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: MyColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
    );
  }
}
