import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';

class CertificationsComponent extends StatelessWidget {
  const CertificationsComponent({super.key});

  ProfileController get controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            SvgPicture.asset(Asset.certificateIcon, width: 20, height: 20),
            SizedBox(width: 1.w),
            Text(
              'Certifications & Licenses',
              style: MyTexts.medium16.copyWith(
                color: MyColors.black,
                fontFamily: MyTexts.Roboto,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Obx(() {
          final documents = controller.documents;

          if (documents.isEmpty) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColors.white,
                border: Border.all(color: const Color(0xFFD0D0D0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'No certifications uploaded yet',
                style: MyTexts.regular14.copyWith(
                  color: const Color(0xFF838383),
                  fontFamily: MyTexts.Roboto,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return Column(
            children: documents.asMap().entries.map((entry) {
              final index = entry.key;
              final document = entry.value;

              return Column(
                children: [
                  _buildCertificationItem(
                    document.documentType ?? 'Document',
                    document.documentName ?? 'Document Name',
                    'Uploaded',
                  ),
                  if (index < documents.length - 1) SizedBox(height: 1.7.h),
                ],
              );
            }).toList(),
          );
        }),
        SizedBox(height: 3.h),
        Center(
          child: RoundedButton(
            buttonName: '',
            borderRadius: 12,
            width: 50.w,
            height: 45,
            verticalPadding: 0,
            horizontalPadding: 0,
            child: Center(
              child: Text(
                '+ Add Certification',
                style: MyTexts.medium16.copyWith(
                  color: MyColors.white,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCertificationItem(
    String title,
    String organization,
    String expiryDate,
  ) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: const Color(0xFF8C8C8C),
      dashPattern: const [5, 5],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD9F0FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  Asset.certificateIcon,
                  colorFilter: const ColorFilter.mode(
                    MyColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.w),
            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyTexts.medium22.copyWith(
                    color: MyColors.black,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                Text(
                  organization,
                  style: MyTexts.medium14.copyWith(
                    color: const Color(0xFF717171),
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  expiryDate,
                  style: MyTexts.medium14.copyWith(
                    color: const Color(0xFF717171),
                    fontFamily: MyTexts.Roboto,
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
