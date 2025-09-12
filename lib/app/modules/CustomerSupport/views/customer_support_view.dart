import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dropdown.dart';
import 'package:construction_technect/app/core/widgets/custom_text_field.dart';
import 'package:construction_technect/app/core/widgets/welcome_name.dart';
import 'package:construction_technect/app/modules/CustomerSupport/controller/customer_support_controller.dart';
import 'package:construction_technect/app/modules/CustomerSupport/views/ticket_list_view.dart';
import 'package:construction_technect/app/modules/ProductManagement/components/stat_card.dart';

class CustomerSupportView extends StatelessWidget {
  final CustomerSupportController controller = Get.put(CustomerSupportController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false, // This removes the back button
          backgroundColor: MyColors.white,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          title: WelcomeName(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(22.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 8),
                          child: SvgPicture.asset(
                            Asset.searchIcon,
                            height: 16,
                            width: 16,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        hintText: 'Search',
                        hintStyle: MyTexts.medium16.copyWith(color: MyColors.darkGray),
                        filled: true,
                        fillColor: MyColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22.5),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            Asset.filterIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Customer Support Ticket",
                    style: MyTexts.extraBold18.copyWith(color: MyColors.fontBlack),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              title: 'Total Products',
                              value: '0',
                              icon: SvgPicture.asset(Asset.TotalProducts),
                              iconBackground: MyColors.yellowundertones,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              title: 'Featured',
                              value: '0',
                              icon: SvgPicture.asset(Asset.Featured),
                              iconBackground: MyColors.verypaleBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              title: 'Low Stock',
                              value: '0',
                              icon: SvgPicture.asset(Asset.LowStock),
                              iconBackground: MyColors.paleRed,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              title: 'Total Interests',
                              value: '0',
                              icon: SvgPicture.asset(Asset.TotalInterests),
                              iconBackground: MyColors.warmOrange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 24, top: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 42.w, // responsive width
                                height: 48, // fixed height
                                child: OutlinedButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => const RequestDemoDialog(),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: MyColors.primary),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ), // Rounded corners
                                    ),
                                  ),
                                  child: Text(
                                    "Request a Demo",
                                    style: MyTexts.medium16.copyWith(
                                      color: MyColors.primary,
                                      fontFamily: MyTexts.Roboto,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Center(
                                child: RoundedButton(
                                  onTap: () {
                                    // Get.toNamed(Routes.ADD_PRODUCT);
                                  },
                                  buttonName: '',
                                  borderRadius: 12,
                                  width: 40.w,
                                  height: 48,
                                  verticalPadding: 0,
                                  horizontalPadding: 0,
                                  child: Center(
                                    child: Text(
                                      '+ Create New Ticket',
                                      style: MyTexts.medium16.copyWith(
                                        color: MyColors.white,
                                        fontFamily: MyTexts.Roboto,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TicketListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequestDemoDialog extends StatefulWidget {
  const RequestDemoDialog({super.key});

  @override
  State<RequestDemoDialog> createState() => _RequestDemoDialogState();
}

class _RequestDemoDialogState extends State<RequestDemoDialog> {
  String? selectedOption;
  final TextEditingController emailController = TextEditingController();
  final CustomerSupportController controller = Get.put(CustomerSupportController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MyColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Request Demo",
                    style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: MyColors.red),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Video placeholder
              Container(
                height: 159,
                decoration: BoxDecoration(
                  color: MyColors.progressRemaining,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(Icons.play_circle_fill, size: 48, color: MyColors.white),
                ),
              ),

              // Dropdown
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    'Request Demo for',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                ],
              ),
              SizedBox(height: 1.h),
              CommonDropdown<String>(
                hintText: "Select Main Category",
                items: controller.mainCategories,
                selectedValue: controller.selectedMainCategory, // pass Rx directly
                itemLabel: (item) => item,
                onChanged: controller.isEdit
                    ? null
                    : (value) {
                        controller.onMainCategorySelected(value);
                      },
                enabled: !controller.isEdit,
              ),

              SizedBox(height: 2.h),
              // Price
              Row(
                children: [
                  Text(
                    'Company Email',
                    style: MyTexts.light16.copyWith(color: MyColors.lightBlue),
                  ),
                  Text('*', style: MyTexts.light16.copyWith(color: MyColors.red)),
                ],
              ),

              SizedBox(height: 1.h),
              CustomTextField(controller: emailController, onChanged: (p0) {}),
              SizedBox(height: 2.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("CANCEL", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Submit logic here
                        Navigator.pop(context);
                      },
                      child:  Text("SUBMIT", style: TextStyle(color: MyColors.white)),
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
