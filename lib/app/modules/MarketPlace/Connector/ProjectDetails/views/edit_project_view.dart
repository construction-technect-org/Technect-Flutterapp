import 'dart:io';

import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validators.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/ProjectDetails/controllers/edit_product_controller.dart';
import 'package:dotted_border/dotted_border.dart';

class EditProjectView extends StatelessWidget {
  EditProjectView({super.key});

  final EditProductController controller = Get.put(EditProductController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isEditLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: const CommonAppBar(
            title: Text('Project Add'),
            isCenter: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextField(
                      hintText: "Enter project name",
                      headerText: "Project Name",
                      controller: controller.pNameController,
                      autofillHints: const [AutofillHints.givenName],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        NameInputFormatter(),
                      ],
                      validator: (value) =>
                          validateName(value, fieldName: "Project Name"),
                    ),
                    const Gap(16),
                    CommonTextField(
                      hintText: "Enter project code",
                      headerText: "Project Code",
                      controller: controller.pCodeController,
                      //autofillHints: const [AutofillHints.givenName],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        NameInputFormatter(),
                      ],
                      validator: (value) =>
                          validateName(value, fieldName: "Project Code"),
                    ),
                    const Gap(16),
                    CommonTextField(
                      hintText: "Enter project area",
                      headerText: "Project Area",
                      controller: controller.pAreaController,
                      //autofillHints: const [AutofillHints.givenName],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        NameInputFormatter(),
                      ],
                      validator: (value) =>
                          validateName(value, fieldName: "Project Area"),
                    ),
                    const Gap(16),
                    CommonTextField(
                      hintText: "Enter the address",
                      headerText: "Address",
                      controller: controller.pAddressController,
                      //autofillHints: const [AutofillHints.givenName],
                      maxLine: 5,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        NameInputFormatter(),
                      ],
                      validator: (value) =>
                          validateName(value, fieldName: "Address"),
                    ),
                    const Gap(16),
                  CommonTextField(
                    hintText: "Enter floor numbers",
                    headerText: "No. of Floors",
                    controller: controller.pFloorsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) => validateNumber(value, fieldName: "No. of Floors"), // ✅
                  ),
                    const Gap(16),
                    CommonTextField(
                      hintText: "Enter Project  Type",
                      headerText: "Project Type",
                      controller: controller.pTypeController,
                      //autofillHints: const [AutofillHints.givenName],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        NameInputFormatter(),
                      ],
                      validator: (value) =>
                          validateName(value, fieldName: "Project Type"),
                    ),
                    const Gap(16),
                    CommonDropdown(
                      hintText: "Enter Project Status",
                      headerText: "Project Status",
                      items: const ["Planning", "In Progress", "Completed"],
                      selectedValue: controller.selectedValue,
                      itemLabel: (item) => item,
                    ),

                    const Gap(16),
                    CommonTextField(
                      hintText: "Description",
                      headerText: "Description",
                      controller: controller.pDescController,
                      maxLine: 5,
                      autofillHints: const [AutofillHints.givenName],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        NameInputFormatter(),
                      ],
                      validator: (value) =>
                          validateName(value, fieldName: "Description"),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Project Images",
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.black,
                          ),
                        ),
                        Text(
                          "Max 5 Images",
                          style: MyTexts.regular12.copyWith(
                            color: MyColors.black,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: () {
                        controller.openMediaBottomSheet();
                      },
                      child: DottedBorder(
                        options: const RectDottedBorderOptions(
                          color: Colors.black, // border color
                          strokeWidth: 2, // border width
                          dashPattern: [8, 4], // dash length and gap
                        ),
                        // rounded corners
                        child: Container(
                          width: double.maxFinite,
                          height: 170,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                Asset.imageUploadIcon,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const Gap(20),
                              Text("Tap to Upload", style: MyTexts.medium16),
                              const Gap(2),
                              Text(
                                "Or drag and drop",
                                style: MyTexts.regular12.copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Obx(() => buildImageList()),

                    /* controller.images.isEmpty
                        ? const SizedBox(height: 0)
                        : const SizedBox(height: 20), */

                    // PDFs
                    Obx(() => buildPdfList()),

                    /*  controller.pdfs.isEmpty
                        ? const SizedBox(height: 0)
                        : const SizedBox(height: 20), */

                    // Video
                    Obx(() => buildVideoTile()),

                    /* controller.video.value == null
                        ? const SizedBox(height: 0)
                        : const SizedBox(height: 20), */
                    RoundedButton(
                      buttonName: "Add",
                      onTap: () async {
                        if (!controller.formKey.currentState!.validate()) return;

                        final bool result = await controller.submitProject();

                        if (result) {
                          // ✅ Back navigate karo
                          Get.back();
                          Navigator.pop(context);
                          await controller.fetchProjects();

                          // ✅ rawSnackbar use karo
                          Get.rawSnackbar(
                            title: "Success",
                            message: "Project created successfully",
                            backgroundColor: Colors.green,
                            icon: const Icon(Icons.check_circle, color: Colors.white),
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 3),
                          );
                        } else {
                          Get.rawSnackbar(
                            title: "Error",
                            message: "Something went wrong",
                            backgroundColor: Colors.red,
                            icon: const Icon(Icons.error, color: Colors.white),
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 3),
                          );
                        }
                      },
                    ),
                    // RoundedButton(
                    //   buttonName: "Add",
                    //   onTap: () {
                    //     if (!controller.formKey.currentState!.validate())
                    //       return;
                    //     Get.toNamed(Routes.SIGN_UP_PASSWORD);
                    //   },
                    // ),

                    // Buttons
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageList() {
    // final bool allNull = controller.images.every((e) => e == null);
    if (controller.images.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 120,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.images.length,
        itemBuilder: (context, index) {
          final file = controller.images[index];

          return Stack(
            children: [
              Container(
                width: 110,
                height: 130,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(File(file.path!), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => controller.removeImage(index),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.red, size: 20),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildPdfList() {
    if (controller.pdfs.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.pdfs.length,
        itemBuilder: (context, index) {
          final file = controller.pdfs[index];
          return Stack(
            children: [
              Container(
                width: 140,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.picture_as_pdf, size: 40),
                      Text(file.name, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => controller.removePdf(index),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildVideoTile() {
    return controller.video.value == null
        ? const SizedBox.shrink()
        : Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.play_circle_fill, size: 60),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: controller.removeVideo,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
