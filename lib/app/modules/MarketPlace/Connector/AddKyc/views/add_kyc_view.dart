import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/AddKyc/controllers/add_kyc_controller.dart';
import 'package:gap/gap.dart';

class AddKycView extends StatefulWidget {
  const AddKycView({super.key});

  @override
  State<AddKycView> createState() => _AddKycViewState();
}

class _AddKycViewState extends State<AddKycView> {
  final AddKycController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: CommonAppBar(isCenter: false, title: Text("ADD PROFILE".toUpperCase())),
          backgroundColor: MyColors.white,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: RoundedButton(
                      buttonName: 'PROCEED',
                      onTap: () => controller.proceedKyc(),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 30, right: 20, left: 20),
            ],
          ),
          body: SingleChildScrollView(
            controller: controller.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                SizedBox(height: 0.6.h),
                Text(
                  "Update your KYC Documents",
                  style: MyTexts.medium16.copyWith(
                    color: MyColors.greyDetails,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                const Gap(20),

                // Aadhaar Number
                CommonTextField(
                  maxLength: 12,
                  headerText: "Aadhaar Card Number",
                  hintText: "Enter your Aadhaar Card Number",
                  controller: controller.aadhaarController,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                ),
                SizedBox(height: 1.h),

                // Aadhaar Front & Back
                _buildUploadField("Aadhaar Card Front", "aadhaarFront"),
                _buildUploadField("Aadhaar Card Back", "aadhaarBack"),
                SizedBox(height: 1.h),

                // PAN Number
                CommonTextField(
                  maxLength: 10,
                  // inputFormatters: [
                  //   UpperCaseTextFormatter()
                  // ],
                  headerText: "PAN Card Number",
                  hintText: "Enter your PAN Card Number",
                  controller: controller.panController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 1.h),

                // PAN Front & Back
                _buildUploadField("PAN Card Front", "panFront"),
                _buildUploadField("PAN Card Back", "panBack"),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadField(String title, String docKey) {
    final file = controller.selectedDocuments[docKey];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Row(
            children: [
              Text(
                title,
                style: MyTexts.regular16.copyWith(
                  color: MyColors.lightBlue,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
              const Text("*", style: TextStyle(color: Colors.red)),
            ],
          ),
          const SizedBox(height: 6),

          // Upload Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.textFieldBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    file?.name ?? "Upload Image or drag here",
                    style: MyTexts.regular16.copyWith(
                      color: MyColors.primary.withOpacity(0.5),
                      fontFamily: MyTexts.Roboto,
                    ),
                  ),
                ),
                SizedBox(
                  width: 75,
                  height: 29,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () async {
                      await controller.pickFile(docKey);
                      setState(() {}); // Refresh UI after file selection
                    },
                    child: Text(
                      "Choose File",
                      style: MyTexts.regular12.copyWith(
                        color: MyColors.white,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
