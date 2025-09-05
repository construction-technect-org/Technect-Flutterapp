import 'dart:developer';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
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

          // Filter out documents with null or invalid data
          final validDocuments = documents.where((document) {
            return document.id != null &&
                document.documentType != null &&
                document.documentName != null &&
                document.filePath != null;
          }).toList();

          if (validDocuments.isEmpty) {
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
            children: validDocuments.asMap().entries.map((entry) {
              final index = entry.key;
              final document = entry.value;
              log(document.documentType ?? '');
              return Column(
                children: [
                  _buildCertificationItem(
                    controller.getDocumentDisplayName(document.documentType),
                    document.documentName ?? 'Document Name',
                    'Uploaded',
                    document,
                  ),
                  if (index < validDocuments.length - 1) SizedBox(height: 1.7.h),
                ],
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildCertificationItem(
    String title,
    String organization,
    String expiryDate,
    Documents document,
  ) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: const Color(0xFF8C8C8C),
      dashPattern: const [5, 5],
      child: Stack(
        children: [
          Container(
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
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => controller.viewDocument(document),
                  child: SvgPicture.asset(Asset.eyeIcon, width: 26, height: 20),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => controller.showDeleteConfirmationDialog(
                    document.id ?? 0,
                    document.documentName ?? 'Document',
                  ),
                  child: SvgPicture.asset(Asset.delete, width: 20, height: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
