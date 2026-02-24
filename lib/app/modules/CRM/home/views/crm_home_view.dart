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
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: MyColors.tertiary,
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 16),
                child: CrmHeader().paddingSymmetric(horizontal: 16),
              ),
              CommonDashboard(),
            ],
          ),
        ),
      ),
    );
  }
}
