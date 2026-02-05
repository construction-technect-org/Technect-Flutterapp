import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/widget/file_icon_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:open_filex/open_filex.dart';

class CertificationsComponent extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.certs.asMap().entries.map((entry) {
            final index = entry.key;
            final cert = entry.value;
            print("Index $index, Entry $entry");

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cert.title ?? "",
                      style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        final url = cert.url;
                        if (url != null && url.isNotEmpty) {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        }
                      },
                      child: const Icon(
                        Icons.visibility,
                        color: MyColors.primary,
                      ),
                    ),
                    if (cert.url != null)
                      Row(
                        children: [
                          const Gap(10),
                          GestureDetector(
                            onTap: () {
                              controller.removeCertificate(index);
                            },
                            child: SvgPicture.asset(Asset.delete),
                          ),
                        ],
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
                        if (cert.url == null) ...[
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
                                  fontFamily: MyTexts.SpaceGrotesk,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                "Upload Certification",
                                style: MyTexts.bold16.copyWith(
                                  color: MyColors.black,
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Column(
                            children: [
                              const Gap(14),
                              FileIconWidget(
                                fileName: cert.originalName ?? '',
                                showFileName: true,
                              ),
                            ],
                          ),
                        ],
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
                Get.to(() => AddCertificate())?.then((val) {
                  if (val != null) {
                    controller.certificates.add(val);
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MyTexts.medium22.copyWith(
                        color: MyColors.black,
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                    Text(
                      organization,
                      style: MyTexts.medium14.copyWith(
                        color: const Color(0xFF717171),
                        fontFamily: MyTexts.SpaceGrotesk,
                      ),
                    ),
                    SizedBox(height: 0.3.h),
                    Text(
                      expiryDate,
                      style: MyTexts.medium14.copyWith(
                        color: const Color(0xFF717171),
                        fontFamily: MyTexts.SpaceGrotesk,
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
