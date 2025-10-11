import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/components/connector_home_components.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/controllers/connector_home_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/model/merchat_model.dart';

class AllMerchantScreen extends StatelessWidget {
  AllMerchantScreen({super.key});

  final controller = Get.find<ConnectorHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: const Text("All Merchant Store"),
        isCenter: false,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
          itemCount: controller.merchantStoreList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final Stores data = controller.merchantStoreList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MerchantCard(data: data),
            );
          },
        );
      }),
    );
  }
}
