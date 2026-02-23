import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/widget/file_icon_widget.dart';

class AddCertificate extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Add Certificate'),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(16),
                            CommonTextField(
                              controller: controller.titleController,
                              headerText: "Certificate",
                              hintText: "Enter your certificate name",
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                                NameInputFormatter(),
                              ],
                              validator: (value) => validateName(
                                value,
                                fieldName: "certificate name",
                              ),
                            ),
                            const Gap(20),
                            Text(
                              "Add File",
                              style: MyTexts.bold16.copyWith(
                                color: MyColors.gray2E,
                              ),
                            ),
                            const Gap(10),
                            GestureDetector(
                              onTap: controller.pickFiles,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: MyColors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Obx(
                                  () => controller.filePath.value == ''
                                      ? Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: MyColors.grey,
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(14),
                                              child: const Icon(
                                                Icons.add,
                                                size: 30,
                                                color: MyColors.grey,
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              "Select File you want to upload",
                                              style: MyTexts.medium14.copyWith(
                                                color: MyColors.grey,
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              "Upload Certification",
                                              style: MyTexts.bold16.copyWith(
                                                color: MyColors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      : FileIconWidget(
                                          fileName: controller.filePath.value,
                                          showFileName: true,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: RoundedButton(
            buttonName: "Add",
            onTap: () async {
              if (controller.filePath.value.isEmpty) {
                SnackBars.errorSnackBar(content: "Please upload certificate");
              }
              if (controller.formKey.currentState!.validate()) {
                if (controller.filePath.value.isNotEmpty &&
                    controller.titleController.text.isNotEmpty) {
                  final cert = AllCertificateModel(
                    title: controller.titleController.text,
                    filePath: controller.filePath.value,
                    // name: basename(controller.filePath.value),
                  );
                  await controller.updateCert(
                    controller.titleController.text.trim(),
                    controller.filePath.value,
                  );
                  //Get.back(result: cert);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

class CommonBgImage extends StatelessWidget {
  const CommonBgImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Asset.moreIBg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
