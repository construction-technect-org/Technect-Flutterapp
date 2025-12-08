import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dashboard_component.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/controller/crm_dashboard_controller.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/mainDashboard/views/widget/crm_header.dart';

class CRMDashboardScreen extends StatelessWidget {
  CRMDashboardScreen({super.key});

  final commonController = Get.find<CommonController>();
  final controller = Get.put<CRMDashboardController>(CRMDashboardController());

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: commonController.isLoading,
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
                  const Gap(25),
                  const CrmHeader(),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() {
                      return CommonDashboard(
                        totalMerchant:
                            commonController
                                .profileData
                                .value
                                .data
                                ?.statistics
                                ?.totalMerchantProfilesCreated
                                ?.toString() ??
                            "0",
                        totalConnector:
                            commonController
                                .profileData
                                .value
                                .data
                                ?.statistics
                                ?.totalConnectorProfilesCreated
                                ?.toString() ??
                            "0",
                      );
                    }),
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
