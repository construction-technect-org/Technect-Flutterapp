import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/vrm/requirement/details/views/widgets/pill_button_widget.dart';
import 'package:construction_technect/app/modules/vrm/requirement/details/views/widgets/requirement_card_widget.dart';

class RequirementDetailScreen extends StatelessWidget {
  const RequirementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Requirement'),
                  isCenter: false,
                  leading: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 20),
                    ),
                  ),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PillButtonWidget(
                              text: 'Mark as completed',
                              trailingChevron: true,
                              icon: Icons.done_all_outlined,
                              background: Color(0xFFF2F2F2),
                            ),
                            PillButtonWidget(
                              text: 'Today',
                              trailingChevron: true,
                              background: Color(0xFFFFFDEA),
                            ),
                          ],
                        ),
                        Gap(16),
                        RequirementCardWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
