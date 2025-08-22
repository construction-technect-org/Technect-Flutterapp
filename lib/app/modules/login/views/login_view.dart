import 'package:construction_technect/app/core/utils/imports.dart';

import 'package:construction_technect/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, backgroundColor: MyColors.primary),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: []),
        ),
      ),
    );
  }
}
