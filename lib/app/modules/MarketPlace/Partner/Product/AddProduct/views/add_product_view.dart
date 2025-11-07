import 'dart:io';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/view/add_service_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/AddProduct/controller/add_product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class AddProductView extends GetView<AddProductController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (controller.pageController.page == 0) {
            Get.back();
          } else {
            controller.pageController.jumpToPage(0);
          }
        }
      },
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Scaffold(
            backgroundColor: MyColors.white,
            appBar: CommonAppBar(
              leading: GestureDetector(
                onTap: () {
                  if (controller.pageController.page == 0) {
                    Get.back();
                  }
                  if (controller.pageController.page == 1) {
                    controller.pageController.jumpToPage(0);
                  } else {
                    controller.pageController.jumpToPage(1);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.arrow_back_ios, color: MyColors.black),
                ),
              ),
              title: Text(controller.isEdit ? "Edit product" : "Add product"),
              isCenter: false,
            ),

            body: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: controller.formKey2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildStepper(0),
                        const Gap(20),
                        if (controller.isEdit)
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
                                          padding: const EdgeInsets.only(right: 8.0, top: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: GestureDetector(
                                              child: path.contains('http')
                                                  ? getImageView(
                                                      finalUrl: path,
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : Image.file(
                                                      File(path),
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.contain,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 4,
                                          child: GestureDetector(
                                            onTap: () => controller.removeImageAt(index),
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
                                      padding: const EdgeInsets.only(right: 8.0, top: 8),
                                      child: GestureDetector(
                                        onTap: controller.pickImageEdit,
                                        child: Container(
                                          width: 78,
                                          height: 78,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: MyColors.grayCD, width: 1.2),
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
                        if (!controller.isEdit)
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
                                          padding: const EdgeInsets.only(right: 8.0, top: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(53),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.dialog(
                                                  Dialog(
                                                    backgroundColor: Colors.white,
                                                    insetPadding: const EdgeInsets.all(20),
                                                    child: Stack(
                                                      alignment: Alignment.topRight,
                                                      children: [
                                                        InteractiveViewer(
                                                          child: path.contains('http')
                                                              ? Image.network(
                                                                  path,
                                                                  fit: BoxFit.contain,
                                                                  width: double.infinity,
                                                                  height: double.infinity,
                                                                )
                                                              : Image.file(
                                                                  File(path),
                                                                  fit: BoxFit.contain,
                                                                  width: double.infinity,
                                                                  height: double.infinity,
                                                                ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(16.0),
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
                                            onTap: () => controller.pickedFilePathList.remove(path),
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
                                      padding: const EdgeInsets.only(right: 8.0, top: 8),
                                      child: GestureDetector(
                                        onTap: controller.pickImage,
                                        child: Container(
                                          width: 78,
                                          height: 78,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: MyColors.grayCD, width: 1.2),
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
                        CommonTextField(
                          headerText: 'Brand Name',
                          hintText: "Enter product brand name",
                          controller: controller.brandNameController,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter brand name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        if (controller.isEdit)
                          CommonTextField(
                            headerText: 'Product Code',
                            readOnly: true,
                            hintText: "CTPC01",
                            bgColor: Colors.grey.shade100,
                            controller: controller.productCodeController,
                          ),
                        if (controller.isEdit) SizedBox(height: 2.h),

                        CommonDropdown<String>(
                          headerText: 'Details of warehouse',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please select a details of warehouse";
                            }
                            return null;
                          },
                          hintText: "Select the detail of warehouse",
                          items: const ["Manufacture unit", "Stock yard", "Ware-house"],
                          selectedValue: controller.selectedWareHouseType,
                          itemLabel: (item) => item,
                          onChanged: controller.isEdit
                              ? null
                              : (value) {
                                  controller.selectedWareHouseType.value = value;
                                },
                          enabled: !controller.isEdit,
                        ),
                        Obx(() {
                          return controller.selectedWareHouseType.value == "Stock yard"
                              ? controller.isEdit
                                    ? Column(
                                        children: [
                                          SizedBox(height: 2.h),
                                          CommonTextField(
                                            readOnly: true,
                                            bgColor: Colors.grey.shade100,

                                            headerText: 'Stock yard Address',
                                            controller: controller.stockYardAddressController,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 2.h),
                                          CommonDropdown<ManufacturerAddress>(
                                            headerText: 'Select Stock yard Address',
                                            validator: (val) {
                                              if (val == null) {
                                                return "Please select stock yard address";
                                              }
                                              return null;
                                            },
                                            hintText: "Select stock yard address",
                                            items: controller.siteLocations,
                                            selectedValue: controller.selectedSiteAddress,
                                            itemLabel: (item) =>
                                                item.fullAddress ?? 'No address name',
                                            onChanged: (val) {
                                              controller.selectSiteAddress(val);
                                            },
                                          ),
                                        ],
                                      )
                              : const SizedBox();
                        }),
                        SizedBox(height: 2.h),
                        CommonDropdown<String>(
                          headerText: 'Main Category',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please select a main category";
                            }
                            return null;
                          },
                          hintText: "Select product main category",
                          items: controller.mainCategoryNames,
                          selectedValue: controller.selectedMainCategory,
                          itemLabel: (item) => item,
                          onChanged: controller.isEdit
                              ? null
                              : (value) {
                                  controller.onMainCategorySelected(value);
                                },
                          enabled: !controller.isEdit,
                        ),
                        SizedBox(height: 2.h),
                        CommonDropdown<String>(
                          headerText: 'Sub-category',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please select a sub category";
                            }
                            return null;
                          },
                          hintText: "Select product sub-category",
                          items: controller.subCategoryNames,
                          selectedValue: controller.selectedSubCategory,
                          itemLabel: (item) => item,
                          onChanged: controller.isEdit
                              ? null
                              : (value) {
                                  controller.onSubCategorySelected(value);
                                },
                          enabled: !controller.isEdit,
                        ),
                        SizedBox(height: 2.h),
                        Obx(() {
                          if (controller.productNames.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonDropdown<String>(
                                  headerText: 'Product',
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please select product";
                                    }
                                    return null;
                                  },
                                  hintText: "Select Product",
                                  items: controller.productNames,
                                  selectedValue: controller.selectedProduct,
                                  itemLabel: (item) => item,
                                  onChanged: controller.isEdit
                                      ? null
                                      : (val) {
                                          controller.onProductSelected(val);
                                        },
                                  enabled: !controller.isEdit,
                                ),
                                SizedBox(height: 2.h),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                        Obx(() {
                          if (controller.subProductNames.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonDropdown<String>(
                                  headerText: 'Product type',
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please select product type";
                                    }
                                    return null;
                                  },
                                  hintText: "Select Product tye",
                                  items: controller.subProductNames,
                                  selectedValue: controller.selectedSubProduct,
                                  itemLabel: (item) => item,
                                  onChanged: controller.isEdit
                                      ? null
                                      : (val) {
                                          controller.onSubProductSelected(val);
                                        },
                                  enabled: !controller.isEdit,
                                ),
                                SizedBox(height: 2.h),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: MyColors.grayEA),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: Row(
                                children: [
                                  Text(
                                    'In Stock',
                                    style: MyTexts.medium14.copyWith(color: MyColors.gra54),
                                  ),
                                  const Spacer(),
                                  Obx(() {
                                    return CupertinoSwitch(
                                      value: controller.isOutStock.value,
                                      onChanged: (val) {
                                        controller.isOutStock.value = val;
                                      },
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Obx(() {
                              return controller.isOutStock.value
                                  ? Column(
                                      children: [
                                        SizedBox(height: 2.h),
                                        CommonTextField(
                                          headerText: "Add Stock",
                                          hintText: "Enter stock quantity",
                                          controller: controller.stockController,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Please enter stock";
                                            }
                                            if (double.tryParse(val) == null) {
                                              return "Enter valid number";
                                            }
                                            if (int.tryParse(val) == 0) {
                                              return "Stock can not be zero";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox();
                            }),
                            SizedBox(height: 2.h),
                          ],
                        ),
                        CommonTextField(
                          headerText: 'Note',
                          hintText: "Write a note",
                          maxLine: 4,
                          controller: controller.noteController,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter note";
                            }
                            if (!RegExp('[a-zA-Z0-9]').hasMatch(val.trim())) {
                              return "Note must contain at least one letter or number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        CommonTextField(
                          headerText: 'Terms & Conditions',
                          hintText: "Write terms & conditions",
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter terms & conditions";
                            }
                            if (!RegExp('[a-zA-Z]').hasMatch(val.trim())) {
                              return "Terms & Conditions must include at least one alphabet character";
                            }
                            return null;
                          },
                          maxLine: 4,
                          controller: controller.termsController,
                        ),
                        SizedBox(height: 4.h),
                        Center(
                          child: RoundedButton(
                            buttonName: 'Continue',
                            onTap: () {
                              if (controller.pickedFilePathList.isEmpty && !controller.isEdit) {
                                SnackBars.errorSnackBar(
                                  content: 'Please upload at least one image',
                                );
                                return;
                              }
                              if (controller.isEdit) {
                                final hasImage = controller.imageSlots.any(
                                  (path) => path != null && path.trim().isNotEmpty,
                                );
                                if (!hasImage) {
                                  SnackBars.errorSnackBar(
                                    content: 'Please upload at least one image',
                                  );
                                  return;
                                }
                              }
                              if (controller.formKey2.currentState!.validate()) {
                                controller.showExtraFields.value = true;
                                controller.pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                SnackBars.errorSnackBar(
                                  content: "Please fill all required fields properly",
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: controller.formKey3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildStepper(1),
                        const Gap(20),

                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                headerText: 'Ex Factory Price',
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
                                items: controller.gstList,
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
                                headerText: 'Ex Factory Amount',
                                hintText: "ENTER AMOUNT",
                                controller: controller.amountController,
                                keyboardType: TextInputType.number,
                                onChange: (p0) {
                                  // controller.gstCalculate();
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
                        Text(
                          "Product Demo Video",
                          style: MyTexts.medium14.copyWith(color: MyColors.gray2E),
                        ),
                        const Gap(16),
                        if (controller.isEdit)
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
                                        GestureDetector(
                                          onTap: () => controller.openVideoDialog(
                                            context,
                                            APIConstants.bucketUrl +
                                                controller.product.productVideo.toString(),
                                            true,
                                          ),
                                          child: Stack(
                                            alignment: AlignmentGeometry.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: VideoPlayer(
                                                    controller.videoPlayerController!,
                                                  ),
                                                ),
                                              ),
                                              const VideoPlay(),
                                            ],
                                          ),
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
                                      onTap: () =>
                                          controller.openVideoPickerBottomSheet(Get.context!),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Gap(24),

                                            SvgPicture.asset(Asset.add, height: 40),
                                            const Gap(16),
                                            Text(
                                              "Upload Video (max 24 MB)",
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
                        if (!controller.isEdit)
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
                                                aspectRatio: 16 / 9,
                                                child: VideoPlayer(
                                                  controller.videoPlayerController!,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.openVideoDialog(
                                                  context,
                                                  video.path,
                                                  false,
                                                );
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
                                      onTap: () =>
                                          controller.openVideoPickerBottomSheet(Get.context!),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Gap(24),

                                            SvgPicture.asset(Asset.add, height: 40),
                                            const Gap(16),
                                            Text(
                                              "Upload Video (max 24 MB)",
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

                        const Gap(35),
                        Center(
                          child: RoundedButton(
                            buttonName: 'Continue',
                            onTap: () {
                              hideKeyboard();
                              if (controller.formKey3.currentState!.validate()) {
                                if (controller.selectedVideo.value == null) {
                                  SnackBars.errorSnackBar(content: "Please upload a video");
                                  return;
                                }
                                controller.showExtraFields.value = true;
                                controller.pageController.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: controller.formKey1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildStepper(2),
                        const Gap(20),
                        Obx(() {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.filters.length,
                            itemBuilder: (context, index) {
                              final filter = controller.filters[index];
                              final controllerField =
                                  controller.dynamicControllers[filter.filterName];

                              if (filter.filterType == 'dropdown') {
                                controller.dropdownValues.putIfAbsent(
                                  filter.filterName!,
                                  () => Rxn<String>(),
                                );

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: CommonDropdown<String>(
                                    headerText: filter.filterLabel ?? '',
                                    hintText: "Select ${filter.filterLabel ?? ''}",
                                    items: (filter.dropdownList ?? []).cast<String>(),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please select ${filter.filterLabel ?? 'a value'}";
                                      }
                                      return null;
                                    },
                                    selectedValue: controller.dropdownValues[filter.filterName]!,
                                    itemLabel: (item) => item,
                                    onChanged: (val) {
                                      controller.dynamicControllers[filter.filterName]?.text =
                                          val ?? '';
                                    },
                                  ),
                                );
                              }

                              if (filter.filterType == 'dropdown_multiple') {
                                controller.multiDropdownValues.putIfAbsent(
                                  filter.filterName!,
                                  () => <String>[].obs,
                                );

                                final RxString errorText = ''.obs;

                                final selectedList =
                                    controller.multiDropdownValues[filter.filterName]!;

                                return Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(bottom: 2.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              filter.filterLabel ?? '',
                                              style: MyTexts.medium14.copyWith(
                                                color: MyColors.gra54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(5),
                                        GestureDetector(
                                          onTap: () async {
                                            final List<String> items = (filter.dropdownList ?? [])
                                                .cast<String>();

                                            final selected = await showDialog<List<String>>(
                                              context: context,
                                              builder: (_) {
                                                final tempSelection = selectedList.toSet().obs;
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  title: Text("Select ${filter.filterLabel ?? ''}"),
                                                  titleTextStyle: MyTexts.medium15.copyWith(
                                                    color: MyColors.primary,
                                                    fontFamily: MyTexts.SpaceGrotesk,
                                                  ),
                                                  content: Obx(
                                                    () => SingleChildScrollView(
                                                      child: Column(
                                                        children: items.map((item) {
                                                          final isSelected = tempSelection.contains(
                                                            item,
                                                          );
                                                          return CheckboxListTile(
                                                            title: Text(item),
                                                            value: isSelected,
                                                            fillColor:
                                                                WidgetStateProperty.resolveWith<
                                                                  Color
                                                                >((states) {
                                                                  if (states.contains(
                                                                    WidgetState.selected,
                                                                  )) {
                                                                    return MyColors.primary;
                                                                  }
                                                                  return Colors.white;
                                                                }),
                                                            onChanged: (checked) {
                                                              if (checked == true) {
                                                                tempSelection.add(item);
                                                              } else {
                                                                tempSelection.remove(item);
                                                              }
                                                            },
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Get.back(result: tempSelection.toList()),
                                                      child: Text(
                                                        "OK",
                                                        style: MyTexts.bold16.copyWith(
                                                          color: MyColors.primary,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (selected != null) {
                                              selectedList.assignAll(selected);
                                              controller
                                                  .dynamicControllers[filter.filterName]
                                                  ?.text = selected.join(
                                                ', ',
                                              );
                                              if (selectedList.isNotEmpty) {
                                                errorText.value = '';
                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 14,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: errorText.isNotEmpty
                                                    ? Colors.red
                                                    : MyColors.grayEA,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    selectedList.isEmpty
                                                        ? "Select ${filter.filterLabel ?? ''}"
                                                        : selectedList.join(', '),
                                                    style: selectedList.isEmpty
                                                        ? MyTexts.medium13.copyWith(
                                                            color: MyColors.primary.withValues(
                                                              alpha: 0.5,
                                                            ),
                                                            fontFamily: MyTexts.SpaceGrotesk,
                                                          )
                                                        : MyTexts.medium15.copyWith(
                                                            color: MyColors.primary,
                                                          ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.keyboard_arrow_down_rounded,
                                                  size: 24,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (errorText.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4, left: 8),
                                            child: Text(
                                              errorText.value,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              if (filter.filterType == 'number') {
                                final min = double.tryParse(filter.minValue?.toString() ?? '');
                                final max = double.tryParse(filter.maxValue?.toString() ?? '');

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: CommonTextField(
                                    keyboardType: const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    headerText: filter.filterLabel ?? '',
                                    hintText: "Enter ${filter.filterLabel ?? ''}",
                                    controller: controllerField,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Please enter a value";
                                      }

                                      final numValue = double.tryParse(val);
                                      if (numValue == null) {
                                        return "Enter a valid number";
                                      }

                                      if (min != null && max != null && min == max) {
                                        if (numValue != min) {
                                          return "Value must be exactly $min";
                                        }
                                        return null;
                                      }

                                      if (min != null && numValue < min) {
                                        return "Value must be ≥ $min";
                                      }
                                      if (max != null && numValue > max) {
                                        return "Value must be ≤ $max";
                                      }

                                      return null;
                                    },

                                    suffixIcon: filter.unit != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(right: 8.0, top: 12.0),
                                            child: Text(
                                              filter.unit!,
                                              style: MyTexts.medium14.copyWith(
                                                color: MyColors.primary,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                );
                              }

                              return Padding(
                                padding: EdgeInsets.only(bottom: 2.h),
                                child: CommonTextField(
                                  headerText: filter.filterLabel ?? '',
                                  hintText: "Enter ${filter.filterLabel ?? ''}",
                                  controller: controllerField,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Please enter a value";
                                    }
                                    return null;
                                  },
                                  suffixIcon: filter.unit != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                                          child: Text(
                                            filter.unit!,
                                            style: MyTexts.regular14.copyWith(color: MyColors.grey),
                                          ),
                                        )
                                      : null,
                                ),
                              );
                            },
                          );
                        }),

                        SizedBox(height: 2.h),
                        Center(
                          child: RoundedButton(
                            buttonName: 'Submit',
                            onTap: () {
                              hideKeyboard();

                              if (!controller.formKey1.currentState!.validate()) {
                                SnackBars.errorSnackBar(
                                  content: "Please fill all required fields properly",
                                );
                                return;
                              }

                              bool allValid = true;

                              controller.multiDropdownValues.forEach((key, list) {
                                if (list.isEmpty) {
                                  allValid = false;
                                  SnackBars.errorSnackBar(
                                    content: "Please select at least one value for $key",
                                  );
                                }
                              });

                              if (!allValid) return;

                              controller.submitProduct(controller.formKey1);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStepper(int index) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.addProduct.length,
        itemBuilder: (context, i) {
          final isActive = i <= index;
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              controller.addProduct[i] ?? "",
              style: MyTexts.medium14.copyWith(
                decoration: isActive ? TextDecoration.underline : TextDecoration.none,
                color: isActive ? MyColors.primary : MyColors.grayA5,
              ),
            ),
          );
        },
      ),
    );
  }
}
