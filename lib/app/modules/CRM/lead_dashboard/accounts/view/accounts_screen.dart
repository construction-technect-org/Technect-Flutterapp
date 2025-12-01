import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/controller/accounts_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_lead_screen.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/accounts/widget/account_segment_filters_widget.dart';

class AccountsScreen extends GetView<AccountsController> {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Asset.categoryBg), fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar(
                    backgroundColor: Colors.transparent,
                    isCenter: false,
                    title: const Text("Accounts"),
                    leading: GestureDetector(
                      onTap: Get.back,
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                  // const TopBarHeader(),
                  const AccountSegmentFiltersWidget(),
                  Expanded(
                    child: RefreshIndicator(
                      backgroundColor: MyColors.primary,
                      color: Colors.white,
                      onRefresh: () async {
                        await controller.fetchAllLead(isLoad: true);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: Obx(() {
                            return controller.filterScreens[controller.activeFilter.value] ??
                                const AccountLeadScreen();
                          }),
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
