import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/controllers/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:gap/gap.dart';

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
                      '${cert.title}${cert.isDefault ? "*" : ''}',
                      style: MyTexts.medium16.copyWith(
                        color: MyColors.fontBlack,
                        fontFamily: MyTexts.Roboto,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        final url = cert.filePath;
                        final fileName = cert.name ?? '';

                        if (url != null && url.isNotEmpty) {
                          final fileExtension = fileName.toLowerCase().split('.').last;
                          final isImage = [
                            'jpg',
                            'jpeg',
                            'png',
                            'gif',
                            'bmp',
                            'webp',
                          ].contains(fileExtension);
                          final isPdf = fileExtension == 'pdf';
                          if (url.startsWith("merchant")) {
                            final uri = Uri.parse(APIConstants.bucketUrl + url);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          } else if (url.startsWith("/") ||
                              url.contains("file://") ||
                              url.contains("storage/") ||
                              url.contains("CoreSimulator") ||
                              url.contains("tmp/")) {
                            try {
                              final file = File(url);
                              final fileExists = await file.exists();

                              if (fileExists) {
                                final uri = Uri.file(url);

                                if (isImage) {
                                  final imageLaunchMethods = [
                                    () async => await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    ),
                                    () async => await launchUrl(uri),
                                    () async => await launchUrl(uri),
                                  ];

                                  bool launched = false;
                                  for (final method in imageLaunchMethods) {
                                    if (!launched) {
                                      try {
                                        await method();
                                        launched = true;
                                      } catch (e) {}
                                    }
                                  }

                                  if (!launched) {
                                    SnackBars.errorSnackBar(
                                      content:
                                          "Cannot open image. No image viewer available.",
                                    );
                                  }
                                } else if (isPdf) {
                                  final pdfLaunchMethods = [
                                    () async => await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    ),
                                    () async => await launchUrl(uri),
                                    () async => await launchUrl(uri),
                                    () async => await launchUrl(Uri.parse('file://$url')),
                                  ];

                                  bool launched = false;
                                  for (final method in pdfLaunchMethods) {
                                    if (!launched) {
                                      try {
                                        await method();
                                        launched = true;
                                      } catch (e) {}
                                    }
                                  }

                                  if (!launched) {
                                    SnackBars.errorSnackBar(
                                      content:
                                          "Cannot open PDF. No PDF viewer available.",
                                    );
                                  }
                                } else {
                                  SnackBars.errorSnackBar(
                                    content: "Only PDF and image files are supported.",
                                  );
                                }
                              } else {
                                SnackBars.errorSnackBar(content: "File not found");
                              }
                            } catch (e) {
                              SnackBars.errorSnackBar(content: "Unable to open file: $e");
                            }
                          } else if (url.startsWith("http://") ||
                              url.startsWith("https://")) {
                            final uri = Uri.parse(url);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          }
                        }
                      },
                      child: const Icon(Icons.visibility, color: MyColors.primary),
                    ),
                    if (cert.filePath != null)
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
                        ] else ...[
                          Column(
                            children: [
                              const Gap(14),
                              _buildFileIcon(cert.name ?? ''),
                              const Gap(14),
                              Text(
                                "File uploaded: ${cert.name}",
                                textAlign: TextAlign.center,
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
                Get.to(() => const AddCertificate())?.then((val) {
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

  Widget _buildFileIcon(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;

    switch (extension) {
      case 'pdf':
        return Image.asset(Asset.pdfImage, height: 50, width: 32);
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: MyColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.image, color: MyColors.primary, size: 30),
        );
      case 'doc':
      case 'docx':
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.description, color: Colors.blue, size: 30),
        );
      case 'txt':
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.text_snippet, color: Colors.grey, size: 30),
        );
      default:
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.warning, color: Colors.orange, size: 30),
        );
    }
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
