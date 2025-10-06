import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:gap/gap.dart';

class MerchantCard extends StatelessWidget {
  const MerchantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: MyColors.americanSilver),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(Asset.profil, height: 46, width: 46),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mohan Das',
                          style: MyTexts.bold18.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        Text(
                          'Company: JK Manufacturers',
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.sonicSilver,
                            fontFamily: MyTexts.Roboto,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 0.7.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.philippineGray,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'mike@constructiontechnet.com',
                      style: MyTexts.regular14.copyWith(
                        color: MyColors.gray32,
                        fontFamily: MyTexts.Roboto,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              RoundedButton(
                onTap: () {
                  // Navigator.of(context).pop();
                  // Get.toNamed(Routes.CONNECTOR_MAIN_TAB);
                },
                height: 40,
                borderRadius: 12,
                verticalPadding: 0,
                horizontalPadding: 8,
                color: MyColors.lightBlue,
                buttonName: '',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Asset.call,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Contact Merchant',
                      style: MyTexts.extraBold14.copyWith(
                        color: MyColors.white,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
