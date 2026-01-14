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
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
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
                            GestureDetector(
                              onTap: () =>
                                  controller.pickImageBottomSheet(context),
                              child: Obx(() {
                                if (controller.selectedImage.value != null) {
                                  return ClipOval(
                                    child: Image.file(
                                      controller.selectedImage.value!,
                                      width: 78,
                                      height: 78,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundColor: MyColors.grayEA,
                                  child: SvgPicture.asset(
                                    Asset.add,
                                    height: 24,
                                    width: 24,
                                  ),
                                );

                                /* final imagePath = eController.image.value;
                                final imageUrl = imagePath.isNotEmpty
                                    ? "${APIConstants.bucketUrl}$imagePath"
                                    : null;
                                if (imageUrl == null) {
                                  return CircleAvatar(
                                    radius: 50,
                                    backgroundColor: MyColors.grayEA,
                                    child: SvgPicture.asset(
                                      Asset.add,
                                      height: 24,
                                      width: 24,
                                    ),
                                  );
                                } */

                                /*  return ClipOval(
                                  child: getImageView(
                                    finalUrl: imageUrl,
                                    height: 78,
                                    width: 78,
                                    fit: BoxFit.cover,
                                  ),
                                ); */
                              }),
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
                                if (controller.customerPhone.value.isEmpty) {
                                  return "Please enter customer phone number";
                                }
                                return null;
                              },
                              suffixIcon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.black54,
                              ),
                            ),
                            Obx(() {
                              return Visibility(
                                visible: controller.isCustomerIdVisible.value,
                                child: Column(
                                  children: [
                                    const Gap(20),
                                    CommonTextField(
                                      readOnly: true,
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
                                  ],
                                ),
                              );
                            }),
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
                              controller: controller.productQtyCtrl,
                              headerText: "Product quantity",
                              hintText: "Enter product quantity",
                              maxLine: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter product quantity";
                                }
                                if (double.tryParse(val) == null) {
                                  return "Enter valid product quantity";
                                }
                                if (int.tryParse(val) == 0) {
                                  return "Product quantity cannot be zero";
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
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter product name";
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            CommonTextField(
                              controller: controller.eDateCtrl,
                              headerText: "Estimated Delivery Date",
                              hintText: "Select estimate delivery date",
                              suffixIcon: const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              maxLine: 1,
                              readOnly: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please select delivery date";
                                }
                                return null;
                              },
                              onTap: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );

                                if (pickedDate != null) {
                                  controller.eDateCtrl.text =
                                      "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                }
                              },
                            ),

                            const Gap(20),

                            CommonTextField(
                              controller: controller.radiusCtrl,
                              headerText: "Estimated Radius (in km)",
                              hintText: "Enter radius",
                              maxLine: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Please enter radius";
                                }
                                if (double.tryParse(val) == null) {
                                  return "Enter valid radius";
                                }
                                if (int.tryParse(val) == 0) {
                                  return "Radius cannot be zero";
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
                            const Gap(20),
                            CommonTextField(
                              headerText: "Note",
                              controller: controller.noteCtrl,
                              hintText: "Enter your note",
                              maxLine: 3,
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return "Please enter your note";
                                }
                                return null;
                              },
                            ),
                            const Gap(30),
                            RoundedButton(
                              buttonName: "Add Lead",
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
      ),
    );
  }
}
