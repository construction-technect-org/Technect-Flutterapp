import 'package:construction_technect/app/core/utils/imports.dart';

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
          padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header row
              Row(
                children: [
                  Image.asset(
                   Asset.profil,  
                   height: 46, 
                   width: 46,                    
                      ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // aligns text to the left
                      mainAxisSize: MainAxisSize.min, // takes minimum height
                      children: [
                        Text(
                          'Mohan Das',
                          style: MyTexts.extraBold20.copyWith(color: MyColors.fontBlack),
                        ),
                        Text(
                          'Company: JK Manufacturers',
                          style: MyTexts.extraBold14.copyWith(
                            color: MyColors.sonicSilver,
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
                    margin: const EdgeInsets.only(
                      top: 6,
                      right: 6,
                    ), // space between dot & text
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.philippineGray, // 👈 change color if needed
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'mike@constructiontechnet.com',
                      style: MyTexts.regular16.copyWith(color: MyColors.gray32),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.7.h),

              RoundedButton(
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(Routes.CONNECTOR_MAIN_TAB);
                },
                borderRadius: 12,
                width: 40.w,
                height: 24,
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
                      height: 10, // adjust as needed
                      width: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Contact Merchant',
                      style: MyTexts.extraBold12.copyWith(
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
