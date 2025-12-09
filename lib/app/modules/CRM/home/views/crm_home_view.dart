import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dashboard_component.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/controller/crm_dashboard_controller.dart';
import 'package:construction_technect/app/modules/CRM/dashboard/mainDashboard/views/widget/crm_header.dart';

class CRMHomeView extends StatelessWidget {
  CRMHomeView({super.key});

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
                  SizedBox(height: MediaQuery.of(context).padding.top + 10),
                  CrmHeader(),
                  const Gap(16),
                  CommonDashboard(),
                ],
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ),
      ),
    );
  }
}
