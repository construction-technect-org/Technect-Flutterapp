import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/modules/CustomerSupport/controller/customer_support_controller.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketCategoriesModel.dart';
import 'package:construction_technect/app/modules/CustomerSupport/models/SupportTicketPrioritiesModel.dart';

class CreatNewTicket extends StatelessWidget {
  CreatNewTicket({super.key});

  final CustomerSupportController controller = Get.put(CustomerSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(
          "Create New Ticket",
          style: MyTexts.medium18.copyWith(color: MyColors.fontBlack),
        ),
        centerTitle: false, // 👈 This aligns the title to the start
        elevation: 0,
        backgroundColor: MyColors.white,
        titleSpacing: 0, // 👈 removes space between icon and text
        forceMaterialTransparency: true,
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
                Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
              ],
            ),
            SizedBox(height: 1.h),
            CommonDropdown<SupportCategory>(
              itemLabel: (item) => item.name, // Show category name
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
                Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
              ],
            ),
            SizedBox(height: 1.h),
            CommonDropdown<SupportPriority>(
              itemLabel: (item) => item.name,
              items: controller.priorities, // should be RxList<SupportPriority>
              selectedValue: controller.selectedPriority,
              onChanged: controller.onPrioritySelected,
              hintText: 'Select Priority',
            ),

            SizedBox(height: 2.h),
            Row(
              children: [
                Text(
                  'Subject',
                  style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                ),
                Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
              ],
            ),
            SizedBox(height: 1.h),
            CustomTextField(
              controller: controller.subjectController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 2.h),
            Text(
              'Description',
              style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
            ),
            SizedBox(height: 1.h),
            CustomTextField(controller: controller.descriptionController, maxLines: 3),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => RoundedButton(
            buttonName: controller.isSubmitting.value ? 'Submitting...' : 'SUBMIT',
            onTap: controller.isSubmitting.value
                ? null
                : () {
                    controller.submitTicket();
                  },
          ),
        ),
      ),
    );
  }
}
