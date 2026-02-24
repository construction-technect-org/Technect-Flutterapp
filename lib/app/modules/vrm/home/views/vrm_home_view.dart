import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/common_dashboard_component.dart';
import 'package:construction_technect/app/data/CommonController.dart';
import 'package:construction_technect/app/modules/vrm/dashboard/widget/vrm_header.dart';

class VRMHomeView extends StatelessWidget {
  VRMHomeView({super.key});

  final CommonController commonController = Get.find<CommonController>();
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
                child: VrmHeader().paddingSymmetric(horizontal: 16),
              ),
              CommonDashboard(),
            ],
          ),
        ),
      ),
    );
  }
}
