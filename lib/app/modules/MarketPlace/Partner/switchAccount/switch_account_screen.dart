import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:gap/gap.dart';

class SwitchAccountScreen extends StatelessWidget {
  const SwitchAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CommonBgImage(),
          Column(
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Switch Account'),
                isCenter: false,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.grayEA.withValues(alpha: 0.32),
                            blurRadius: 4,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: MyColors.grayEA.withValues(alpha: 0.32),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Gst",
                                style: MyTexts.medium15.copyWith(
                                  color: MyColors.gray2E,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
