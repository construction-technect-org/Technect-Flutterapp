import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
class ConnectorMenuView extends StatelessWidget {
  const ConnectorMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CommonAppBar(
        isCenter: false,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text("MENU"),
      ),
    );
  }
}
