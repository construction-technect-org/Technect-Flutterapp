import 'package:construction_technect/app/core/utils/common_fun.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Connector/home/ConnectorHome/model/merchat_model.dart';
import 'package:gap/gap.dart';

class MerchantCard extends StatelessWidget {
  Stores data;

  MerchantCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.americanSilver),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: (data.ownerProfileImage ?? "").isEmpty
                        ? Image.asset(
                            Asset.aTeam,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          )
                        : getImageView(
                            finalUrl:
                                APIConstants.bucketUrl +
                                (data.ownerProfileImage ?? ""),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.businessName ?? "",
                          style: MyTexts.bold18.copyWith(
                            color: MyColors.fontBlack,
                            fontFamily: MyTexts.SpaceGrotesk,
                          ),
                        ),
                        Text(
                          'Owner: ${data.ownerName ?? ""}',
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.sonicSilver,
                            fontFamily: MyTexts.SpaceGrotesk,
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
                      data.businessEmail ?? "",
                      style: MyTexts.regular14.copyWith(
                        color: MyColors.gray32,
                        fontFamily: MyTexts.SpaceGrotesk,
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
                  makePhoneCall(phoneNumber: data.businessContactNumber ?? "");
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
                    Image.asset(Asset.call, height: 16, width: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Contact Merchant',
                      style: MyTexts.extraBold14.copyWith(
                        color: MyColors.white,
                        fontFamily: MyTexts.SpaceGrotesk,
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
