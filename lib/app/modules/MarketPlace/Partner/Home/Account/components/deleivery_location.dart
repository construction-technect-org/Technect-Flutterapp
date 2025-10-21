import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:gap/gap.dart';

class DeliveryLocation extends StatelessWidget {
  const DeliveryLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        body: Stack(
          children: [
            const CommonBgImage(),
            Column(
              children: [
                CommonAppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Delivery location'),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColors.grayEA.withValues(
                                    alpha: 0.32,
                                  ),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                SvgPicture.asset(Asset.add),
                                const Gap(8),
                                Text(
                                  "Add Address",
                                  style: MyTexts.medium15.copyWith(
                                    color: MyColors.gray2E,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                          const Gap(16),
                          Text(
                            "Saved Address",
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.gray2E,
                            ),
                          ),
                          const Gap(16),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyColors.grayEA.withValues(
                                        alpha: 0.32,
                                      ),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Home",
                                                      style: MyTexts.medium16
                                                          .copyWith(
                                                            color:
                                                                MyColors.black,
                                                          ),
                                                    ),
                                                    const Gap(4),
                                                    Text(
                                                      "Flat No. 302, Green Heights Apartment 5th Cross Road, Sector 2 HSR Layout, Bengaluru – 560102 Karnataka, India",
                                                      style: MyTexts.medium14
                                                          .copyWith(
                                                            color:
                                                                MyColors.gray54,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              GestureDetector(
                                                onTap: () {},
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    Asset.edit,
                                                  ),
                                                ),
                                              ),
                                              const Gap(4),
                                              GestureDetector(
                                                onTap: () {},
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    Asset.delete,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
