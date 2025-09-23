import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/input_field.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/modules/CustomerSupport/controller/customer_support_controller.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketPrioritiesModel.dart';

class CreatNewTicket extends StatelessWidget {
  CreatNewTicket({super.key});

  final CustomerSupportController controller = Get.put(
    CustomerSupportController(),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: CommonAppBar(
          title: const Text("Create New Ticket"),
          isCenter: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    'Select Category',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  Text(
                    '*',
                    style: MyTexts.light16.copyWith(color: MyColors.red),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              CommonDropdown<SupportCategory>(
                itemLabel: (item) => item.name,
                // Show category name
                items: controller.categories,
                selectedValue: controller.selectedCategory,
                onChanged: controller.onCategorySelected,
                hintText: 'Select Category',
              ),

              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    'Select Priority',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  Text(
                    '*',
                    style: MyTexts.light16.copyWith(color: MyColors.red),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              CommonDropdown<SupportPriority>(
                itemLabel: (item) => item.name,
                items: controller.priorities,
                selectedValue: controller.selectedPriority,
                onChanged: controller.onPrioritySelected,
                hintText: 'Select Priority',
              ),

              SizedBox(height: 2.h),
              CommonTextField(
                headerText: 'Subject',

                controller: controller.subjectController,
                keyboardType: TextInputType.text,
                hintText: "Enter your description",
              ),
              SizedBox(height: 2.h),
              CommonTextField(
                headerText: 'Description',
                hintText: "Enter your description",
                controller: controller.descriptionController,
                maxLine: 3,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => RoundedButton(
              buttonName: controller.isSubmitting.value
                  ? 'Submitting...'
                  : 'SUBMIT',
              onTap: controller.isSubmitting.value
                  ? null
                  : () {
                      controller.submitTicket();
                    },
            ),
          ),
        ),
      ),
    );
  }
}
