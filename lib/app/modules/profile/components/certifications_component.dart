import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:gap/gap.dart';
import 'package:construction_technect/app/core/widgets/custom_dotted_border.dart';

class CertificationsComponent extends StatelessWidget {
  const CertificationsComponent({this.isDelete});

  final bool? isDelete;

  ProfileController get controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.certificates.asMap().entries.map((entry) {
            final index = entry.key;
            final cert = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cert.title,
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.visibility, color: MyColors.primary),
                    if (!cert.isDefault)
                      IconButton(
                        icon: const Icon(Icons.delete, color: MyColors.red),
                        onPressed: () => controller.removeCertificate(index),
                      ),
                  ],
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () => controller.pickAndSetCertificateFile(index),

                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: MyColors.grey),
                    ),
                    padding: const EdgeInsets.all(17),
                    child: Column(
                      children: [
                        if (cert.filePath == null) ...[
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyColors.grey),
                                ),
                                padding: const EdgeInsets.all(14),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: MyColors.grey,
                                ),
                              ),
                              const Gap(10),
                              const Gap(10),
                              Text(
                                "Select File you want to upload",
                                style: MyTexts.medium14.copyWith(
                                  color: MyColors.grey,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                "Upload Certification",
                                style: MyTexts.bold16.copyWith(
                                  color: MyColors.black,
                                  fontFamily: MyTexts.Roboto,
                                ),
                              ),
                            ],
                          ),
                        ] else
                          Text("File uploaded: ${cert.filePath}"),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
              ],
            );
          }),
          Align(
            child: GestureDetector(
              onTap: () {
                // Example: open dialog to enter title

                Get.to(() => const AddCertificate())?.then((val) {
                  if (val != null) {
                    controller.documents.add(val);
                  }
                });
              },
              child: RoundedButton(
                width: 200,
                height: 40,
                verticalPadding: 0,
                style: MyTexts.medium14.copyWith(color: Colors.white),
                buttonName: '+ Add Certification',
              ),
            ),
          ),
          const Gap(20),
        ],
      );
    });
  }

  Widget _buildCertificationItem(
    String title,
    String organization,
    String expiryDate,
    Documents document,
  ) {
    return DottedBorder(
      options: const RectDottedBorderOptions(
        color: Color(0xFF8C8C8C),
        dashPattern: [5, 5],
      ),
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
                  color: Colors.black.withValues(alpha: 0.1),
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
