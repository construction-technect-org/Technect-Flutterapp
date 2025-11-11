import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/utils/validate.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/CRM/requirement/add/controller/add_new_requ_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class AddNewRequirement extends GetView<AddNewRequController> {
  const AddNewRequirement({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Add New Requirement'),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () => Get.back(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),

                          CommonTextField(
                            controller: controller.unitOfMeasureCtrl,
                            headerText: "Lead ID - #CT001",
                            hintText: "Unit of Measure",
                            validator: (val) =>
                                Validate.validateNull(val, "Unit of Measure"),
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.customerNameCtrl,
                            headerText: "Customer Name",
                            hintText: "Enter Customer Name",
                            validator: (val) =>
                                Validate.validateNull(val, "Customer Name"),
                          ),
                          const Gap(20),
                          CommonDropdown(
                            headerText: "Customer Type",
                            hintText: "Select the Customer Type",
                            items: const ["Individual", "Company"],
                            selectedValue: controller.selectedCustomerType,
                            itemLabel: (item) => item,
                            validator: (val) =>
                                Validate.validateNull(val, "Customer Type"),
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.customerIdCtrl,
                            headerText: "Customer ID",
                            hintText: "Enter the Customer ID",
                            validator: (val) =>
                                Validate.validateNull(val, "Customer ID"),
                          ),
                          const Gap(20),

                          CommonTextField(
                            headerText: "Customer Phone no",
                            hintText: "Enter customer phone number",
                            keyboardType: TextInputType.phone,
                            readOnly: true,
                            onTap: () =>
                                controller.openPhoneNumberBottomSheet(),
                            suffixIcon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.black54,
                            ),
                          ),
                          Obx(() {
                            if (controller.numList.isEmpty) {
                              return const SizedBox();
                            }
                            return Column(
                              children: [
                                const Gap(10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: controller.numList
                                      .map<Widget>(
                                        (number) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE9EDFF),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                number,
                                                style: MyTexts.medium14,
                                              ),
                                              const SizedBox(width: 6),
                                              GestureDetector(
                                                onTap: () => controller.numList
                                                    .remove(number),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 16,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            );
                          }),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.productNameCtrl,
                            headerText: "Product Name",
                            hintText: "Enter Product Name",
                            validator: (val) =>
                                Validate.validateNull(val, "Product Name"),
                          ),
                          const Gap(20),

                          // Product Code
                          CommonTextField(
                            controller: controller.productCodeCtrl,
                            headerText: "Product Code",
                            hintText: "Enter Product Code",
                            readOnly: true,
                            validator: (val) =>
                                Validate.validateNull(val, "Product Code"),
                          ),
                          const Gap(20),

                          // Contacted Person
                          CommonTextField(
                            controller: controller.contactedPersonCtrl,
                            headerText: "Contacted Person",
                            hintText: "Enter Contacted Person Name",
                            validator: (val) =>
                                Validate.validateNull(val, "Contacted Person"),
                          ),
                          const Gap(20),

                          // Source Dropdown
                          CommonDropdown(
                            headerText: "Contacted Person",
                            hintText: "Select the Source",
                            items: const [
                              "Construction technect",
                              "Field Marketing",
                              "India mart",
                              "Year",
                              "Justdail",
                              "Facebook",
                              "Whatsapp",
                              "Digital Marketing - adds",
                              "Reference",
                              "Others",
                            ],
                            selectedValue: controller.selectedSource,
                            itemLabel: (item) => item,
                            validator: (val) =>
                                Validate.validateNull(val, "Contacted Person"),
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.referenceCtrl,
                            headerText: "Reference",
                            hintText: "Enter the Reference",
                            validator: (val) =>
                                Validate.validateNull(val, "Reference"),
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.referralPhoneCtrl,
                            headerText: "Referral Phone no",
                            hintText: "Enter Referral Phone number",
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (val) =>
                                Validate.validateIndianMobileNumber(val),
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.siteLocationCtrl,
                            headerText: "Site Location",
                            hintText: "Enter the Site Location",
                            validator: (val) =>
                                Validate.validateNull(val, "Site Location"),
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.companyNameCtrl,
                            headerText: "Company Name",
                            hintText: "Enter Company Name",
                            validator: (val) =>
                                Validate.validateNull(val, "Company Name"),
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.gstNumberCtrl,
                            headerText: "GST Number",
                            hintText: "Enter GST Number",
                            validator: (val) => Validate.validateGST(val),
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.companyAddressCtrl,
                            headerText: "Company Address",
                            hintText: "Enter Company Address",
                            validator: (val) =>
                                Validate.validateNull(val, "Company Address"),
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.contactPersonCtrl,
                            headerText: "Contact Person",
                            hintText: "Enter Contact Person",
                            validator: (val) =>
                                Validate.validateNull(val, "Contact Person"),
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.companyPhoneCtrl,
                            headerText: "Company Phone",
                            hintText: "Enter Company Phone",
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (val) =>
                                Validate.validateIndianMobileNumber(val),
                          ),
                          const Gap(30),
                          RoundedButton(
                            buttonName: "Add Requirement",
                            onTap: controller.onSubmit,
                          ),
                          const Gap(40),
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
