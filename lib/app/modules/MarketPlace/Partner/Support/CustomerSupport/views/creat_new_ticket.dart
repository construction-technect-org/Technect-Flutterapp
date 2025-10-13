import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/controller/create_new_ticket_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportTicketPrioritiesModel.dart';

class CreatNewTicket extends StatelessWidget {
  final CreateNewTicketController controller = Get.put(
    CreateNewTicketController(),
  );
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: LoaderWrapper(
        isLoading: controller.isLoading,
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: CommonAppBar(
            title: const Text("Create New Ticket"),
            isCenter: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  CommonDropdown<SupportCategory>(
                    headerText: 'Select Category',
                    itemLabel: (item) => item.name,
                    // Show category name
                    items: controller.categories,
                    selectedValue: controller.selectedCategory,
                    onChanged: controller.onCategorySelected,
                    hintText: 'Select Category',
                    validator: (val) {
                      if (val == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 2.h),
                  CommonDropdown<SupportPriority>(
                    headerText: 'Select Priority',
                    itemLabel: (item) => item.name,
                    items: controller.priorities,
                    selectedValue: controller.selectedPriority,
                    onChanged: controller.onPrioritySelected,
                    hintText: 'Select Priority',
                    validator: (val) {
                      if (val == null) {
                        return 'Please select a priority';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 2.h),
                  CommonTextField(
                    headerText: 'Subject',
                    controller: controller.subjectController,
                    keyboardType: TextInputType.text,
                    hintText: "Enter your subject",
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return "Please enter a subject";
                      } else if (value!.length < 5) {
                        return "Subject must be at least 5 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.h),
                  CommonTextField(
                    headerText: 'Description',
                    hintText: "Enter your description",
                    controller: controller.descriptionController,
                    maxLine: 3,
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return "Please enter a description";
                      } else if (value!.length < 10) {
                        return "Description must be at least 10 characters long";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: Obx(
              () => RoundedButton(
                buttonName: controller.isSubmitting.value
                    ? 'Submitting...'
                    : 'SUBMIT',
                onTap: controller.isSubmitting.value
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          await controller.submitTicket();
                        }
                      },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
