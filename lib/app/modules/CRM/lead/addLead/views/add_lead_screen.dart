import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/CRM/lead/addLead/controller/add_lead_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';

class AddLeadScreen extends GetView<AddLeadController> {
  const AddLeadScreen({super.key});

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
                  title: const Text('Add Lead'),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
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
                          // const Gap(10),
                          // const Text(
                          //   "Lead ID - #CT001",
                          //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          // ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.unitOfMeasureCtrl,
                            headerText: "Unit of Measure",
                            hintText: "Enter the Unit of Measure",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter Unit of Measure";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.customerNameCtrl,
                            headerText: "Customer Name",
                            hintText: "Enter Customer Name",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter customer name";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CommonDropdown(
                            headerText: "Customer Type",
                            hintText: "Select the Customer Type",
                            items: const ["Individual", "Company"],
                            selectedValue: controller.selectedCustomerType,
                            itemLabel: (item) => item,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please select a customer type";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.customerIdCtrl,
                            headerText: "Customer ID",
                            hintText: "Enter the Customer ID",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter customer ID";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.customerPhoneCtrl,
                            headerText: "Customer Phone no",
                            hintText: "Enter customer phone number",
                            keyboardType: TextInputType.phone,
                            readOnly: true,
                            onTap: () {
                              controller.openPhoneNumberBottomSheet();
                            },
                            validator: (val) {
                              if (controller.numList.isEmpty) {
                                return "Please enter at least one phone number";
                              }
                              return null;
                            },
                            suffixIcon: const Icon(Icons.add_circle_outline, color: Colors.black54),
                          ),
                          Obx(() {
                            if (controller.numList.isEmpty) return const SizedBox();
                            return Column(
                              children: [
                                const Gap(10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: controller.numList.map<Widget>((number) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE9EDFF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(number.toString(), style: MyTexts.medium14),
                                          const SizedBox(width: 6),
                                          GestureDetector(
                                            onTap: () => controller.numList.remove(number),
                                            child: const Icon(
                                              Icons.close,
                                              size: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )).toList(),
                                ),
                              ],
                            );
                          }),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.productNameCtrl,
                            headerText: "Product Name",
                            hintText: "Enter Product Name",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter product name";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          // Product Code
                          CommonTextField(
                            controller: controller.productCodeCtrl,
                            headerText: "Product Code",
                            hintText: "Enter Product Code",
                            readOnly: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter product name";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          // Contacted Person
                          CommonTextField(
                            controller: controller.contactedPersonCtrl,
                            headerText: "Contacted Person",
                            hintText: "Enter Contacted Person Name",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter contact person name";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          // Source Dropdown
                          CommonDropdown(
                            headerText: "Source",
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
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please select a source";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.referenceCtrl,
                            headerText: "Reference",
                            hintText: "Enter the Reference",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter reference name";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.referralPhoneCtrl,
                            headerText: "Referral Phone no.",
                            hintText: "Enter Referral Phone number",
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter phone number";
                              } else if (val.length < 10) {
                                return "Please enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.siteLocationCtrl,
                            headerText: "Site Location",
                            hintText: "Enter the Site Location",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter site location";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.companyNameCtrl,
                            headerText: "Company Name",
                            hintText: "Enter Company Name",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter company name";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.gstNumberCtrl,
                            headerText: "GST Number",
                            hintText: "Enter GST Number",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter gst number";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.companyAddressCtrl,
                            headerText: "Company Address",
                            hintText: "Enter Company Address",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter company address";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),

                          CommonTextField(
                            controller: controller.contactPersonCtrl,
                            headerText: "Contact Person",
                            hintText: "Enter Contact Person",
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter contact person detail";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          CommonTextField(
                            controller: controller.companyPhoneCtrl,
                            headerText: "Company Phone",
                            hintText: "Enter Company Phone",
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter phone number";
                              } else if (val.length < 10) {
                                return "Please enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          const Gap(30),
                          RoundedButton(buttonName: "Add Lead", onTap: controller.onSubmit),
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
