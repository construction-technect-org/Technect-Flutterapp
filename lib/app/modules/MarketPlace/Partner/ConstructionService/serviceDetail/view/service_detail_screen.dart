import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/addService/view/add_service_screen.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/ConstructionService/serviceDetail/controller/service_detail_controller.dart';
import 'package:video_player/video_player.dart';

class ServiceDetailScreen extends GetView<ServiceDetailController> {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      isLoading: controller.isLoading,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: const CommonAppBar(title: Text("Service Details"), isCenter: false),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Gap(16),
            if (myPref.role.val == "connector")
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.MAIN);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Explore More!",
                        style: MyTexts.medium14.copyWith(color: MyColors.grayA5),
                      ),
                      const Gap(8),
                      Text(
                        "View Categories >",
                        style: MyTexts.medium16.copyWith(color: MyColors.gray54),
                      ),
                    ],
                  ),
                ),
              ),
            if (myPref.role.val == "connector") _buildConnectionButton(context, controller),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              Obx(() {
                final service = controller.service.value;

                final List<Map<String, dynamic>> mediaList = [];

                if (service.images != null && service.images!.isNotEmpty) {
                  for (final image in service.images!) {
                    if (image.mediaUrl != null && image.mediaUrl!.isNotEmpty) {
                      mediaList.add({'type': 'image', 'path': image.mediaUrl ?? ''});
                    }
                  }
                }

                if (service.video != null && service.video!.mediaUrl != null) {
                  final url = service.video?.mediaUrl ?? '';
                  if (url.isNotEmpty) {
                    mediaList.add({'type': 'video', 'path': url});
                  }
                }

                if (mediaList.isEmpty) {
                  return Container(
                    height: 35.h,
                    width: 360.w,
                    color: MyColors.grayF2,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
                  );
                }

                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: 35.h,
                      width: 360.w,
                      child: PageView.builder(
                        itemCount: mediaList.length,
                        controller: PageController(),
                        onPageChanged: (index) {
                          controller.currentIndex.value = index;
                          final media = mediaList[index];
                          if (media['type'] == 'video') {
                            if (controller.videoPlayerController != null &&
                                controller.videoPlayerController!.value.isInitialized) {
                              controller.videoPlayerController!.play();
                            }
                          } else {
                            if (controller.videoPlayerController != null &&
                                controller.videoPlayerController!.value.isInitialized) {
                              controller.videoPlayerController!.pause();
                            }
                          }
                        },
                        itemBuilder: (context, index) {
                          final media = mediaList[index];
                          final path = media['path'] as String;
                          final isHttp = path.startsWith('http');

                          if (media['type'] == 'video') {
                            final videoController = controller.videoPlayerController;
                            final isPlaying =
                                videoController != null &&
                                videoController.value.isInitialized &&
                                videoController.value.isPlaying;
                            final hasError = videoController != null;

                            return GestureDetector(
                              onTap: () {
                                if (hasError) {
                                  final videoPath =
                                      controller.service.value.video?.mediaS3Key ??
                                      controller.service.value.video?.mediaUrl ??
                                      "";
                                  if (videoPath.isNotEmpty) {
                                    final videoUrl = videoPath.startsWith('http')
                                        ? videoPath
                                        : APIConstants.bucketUrl + videoPath;
                                    controller.openVideoDialog(context, videoUrl, true);
                                  }
                                } else if (videoController != null &&
                                    videoController.value.isInitialized) {
                                  if (isPlaying) {
                                    videoController.pause();
                                  } else {
                                    videoController.play();
                                  }
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ColoredBox(
                                    color: Colors.black,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child:
                                          videoController != null &&
                                              videoController.value.isInitialized
                                          ? VideoPlayer(videoController)
                                          : videoController != null &&
                                                videoController.value.hasError
                                          ? Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                    size: 48,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text(
                                                    'Failed to load video',
                                                    style: MyTexts.medium14.copyWith(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Video codec may not be supported on this device',
                                                    style: MyTexts.medium12.copyWith(
                                                      color: Colors.white70,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          controller.retryVideoInitialization();
                                                        },
                                                        child: const Text(
                                                          'Retry',
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      TextButton(
                                                        onPressed: () {
                                                          final videoPath =
                                                              controller
                                                                  .service
                                                                  .value
                                                                  .video
                                                                  ?.mediaS3Key ??
                                                              controller
                                                                  .service
                                                                  .value
                                                                  .video
                                                                  ?.mediaUrl ??
                                                              "";
                                                          if (videoPath.isNotEmpty) {
                                                            final videoUrl =
                                                                videoPath.startsWith('http')
                                                                ? videoPath
                                                                : APIConstants.bucketUrl +
                                                                      videoPath;
                                                            controller.openReferenceUrl(videoUrl);
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Open in Browser',
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const Center(
                                              child: CircularProgressIndicator(color: Colors.white),
                                            ),
                                    ),
                                  ),
                                  if (!isPlaying) const VideoPlay(),

                                  if (videoController != null &&
                                      videoController.value.isInitialized)
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: VideoProgressIndicator(
                                        videoController,
                                        allowScrubbing: true,
                                        colors: const VideoProgressColors(
                                          backgroundColor: Colors.black26,
                                          playedColor: Colors.white,
                                          bufferedColor: Colors.white38,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  insetPadding: const EdgeInsets.all(16),
                                  child: InteractiveViewer(
                                    child: isHttp
                                        ? Image.network(
                                            path,
                                            width: 360.w,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.broken_image,
                                                  size: 60,
                                                  color: Colors.grey,
                                                ),
                                          )
                                        : Image.file(File(path), fit: BoxFit.contain),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: isHttp
                                    ? Image.network(
                                        path,
                                        fit: BoxFit.cover,
                                        height: 35.h,
                                        width: 360.w,
                                      )
                                    : Image.file(
                                        File(path),
                                        fit: BoxFit.cover,
                                        height: 35.h,
                                        width: 360.w,
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            mediaList.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: controller.currentIndex.value == index ? 14 : 9,
                              width: controller.currentIndex.value == index ? 14 : 9,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == index
                                    ? MyColors.primary
                                    : MyColors.primary.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image/video
                    // 🟦 IMAGE / VIDEO SECTION

                    /// =============== SERVICE INFO SECTION ===============
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            controller.service.value.serviceCategoryName?.capitalizeFirst ?? '-',
                            style: MyTexts.medium18.copyWith(
                              color: MyColors.fontBlack,
                              fontFamily: MyTexts.SpaceGrotesk,
                            ),
                          ),
                        ),
                        const Gap(16),

                        Obx(() {
                          return controller.isEdit.value
                              ? TextButton.icon(
                                  onPressed: () {
                                    controller.onEditService();
                                  },
                                  icon: SvgPicture.asset(
                                    Asset.edit,
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                      MyColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  label: Text(
                                    "Edit",
                                    style: MyTexts.regular16.copyWith(
                                      color: MyColors.primary,
                                      fontFamily: MyTexts.SpaceGrotesk,
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                      ],
                    ),
                    const Gap(20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFF9BD),
                            const Color(0xFFFFF9BD).withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          rowText('₹ ${controller.service.value.price ?? 0}', 'Ex factory rate'),
                          const Gap(4),
                          rowText(
                            '₹ ${controller.service.value.gstPercentage?.split(".").first ?? 0}% - (₹${controller.service.value.gstAmount ?? 0})',
                            'Gst',
                          ),
                          Divider(color: MyColors.white),
                          rowText(
                            "₹ ${controller.service.value.price ?? "0"}",
                            'Ex Factory Amount',
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    _buildSpecificationsTable(),
                    const Gap(20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF7E8),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFFDEBC8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: MyTexts.medium14.copyWith(color: MyColors.grayA5),
                          ),
                          const Gap(8),
                          Text(
                            controller.service.value.description ?? "-",
                            style: MyTexts.medium16.copyWith(color: MyColors.gray54),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Obx(() {
                      final reference = controller.service.value.reference;
                      if (reference == null) {
                        return const SizedBox();
                      }

                      final referenceType = reference.referenceType?.toLowerCase() ?? '';
                      final referenceUrl =
                          APIConstants.bucketUrl + (reference.referenceS3Key ?? '');

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reference ${referenceType.toUpperCase()}",
                            style: MyTexts.bold16.copyWith(color: MyColors.fontBlack),
                          ),
                          const Gap(10),
                          // Video reference
                          if (referenceType == 'video')
                            Obx(() {
                              final refController = controller.refVideoPlayerController;
                              if (controller.isRefVideo.value &&
                                  refController != null &&
                                  refController.value.isInitialized) {
                                return GestureDetector(
                                  onTap: () =>
                                      controller.openVideoDialog(context, referenceUrl, true),
                                  child: Stack(
                                    alignment: AlignmentGeometry.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: VideoPlayer(refController),
                                        ),
                                      ),
                                      const VideoPlay(),
                                    ],
                                  ),
                                );
                              } else if (refController != null && refController.value.hasError) {
                                return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: MyColors.grayEA,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          size: 48,
                                          color: MyColors.gray54,
                                        ),
                                        const SizedBox(height: 8),
                                        const Text('Failed to load video'),
                                        TextButton(
                                          onPressed: controller.retryReferenceVideoInitialization,
                                          child: const Text('Retry'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: MyColors.grayEA,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(child: CircularProgressIndicator()),
                                );
                              }
                            })
                          // Image reference
                          else if (referenceType == 'image')
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    insetPadding: const EdgeInsets.all(16),
                                    child: InteractiveViewer(
                                      child: Image.network(
                                        referenceUrl,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          Icons.broken_image,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  referenceUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 200,
                                    color: MyColors.grayEA,
                                    child: const Center(
                                      child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                                    ),
                                  ),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      height: 200,
                                      color: MyColors.grayEA,
                                      child: const Center(child: CircularProgressIndicator()),
                                    );
                                  },
                                ),
                              ),
                            )
                          // PDF or DOC reference
                          else if (referenceType == 'pdf' || referenceType == 'document')
                            GestureDetector(
                              onTap: () {
                                // Open URL in external browser
                                controller.openReferenceUrl(referenceUrl);
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: MyColors.grayEA,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: MyColors.grayD4),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      referenceType == 'pdf'
                                          ? Icons.picture_as_pdf
                                          : Icons.description,
                                      size: 64,
                                      color: MyColors.primary,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      reference.referenceType?.toUpperCase() ?? 'Document',
                                      style: MyTexts.medium16.copyWith(color: MyColors.fontBlack),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tap to open',
                                      style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: MyColors.grayEA,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.insert_drive_file,
                                      size: 64,
                                      color: MyColors.gray54,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      reference.referenceType?.toUpperCase() ?? 'Reference',
                                      style: MyTexts.medium16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Explore our other services', style: MyTexts.bold18),
                        const Gap(12),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5, // showing 5 dummy services
                            itemBuilder: (context, index) {
                              // Dummy data list
                              final dummyServices = [
                                {
                                  "title": "Plumbing Repair",
                                  "image": "https://picsum.photos/200/300?random=1",
                                  "category": "Home Maintenance",
                                },
                                {
                                  "title": "House Painting",
                                  "image": "https://picsum.photos/200/300?random=2",
                                  "category": "Interior Design",
                                },
                                {
                                  "title": "Electric Fittings",
                                  "image": "https://picsum.photos/200/300?random=3",
                                  "category": "Electrical",
                                },
                                {
                                  "title": "Carpentry Work",
                                  "image": "https://picsum.photos/200/300?random=4",
                                  "category": "Woodwork",
                                },
                                {
                                  "title": "Tile Installation",
                                  "image": "https://picsum.photos/200/300?random=5",
                                  "category": "Flooring",
                                },
                              ];

                              final data = dummyServices[index];

                              return GestureDetector(
                                onTap: () {
                                  // you can navigate later, for now just show snackbar
                                  SnackBars.successSnackBar(content: "Clicked on ${data["title"]}");
                                },
                                child: Container(
                                  width: 112,
                                  margin: EdgeInsets.only(right: index < 4 ? 12 : 0),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          height: 90,
                                          width: 112,
                                          imageUrl: data["image"]!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Icon(
                                            Icons.build,
                                            color: MyColors.primary,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      Text(
                                        data["title"]!,
                                        style: MyTexts.medium14,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        data["category"]!,
                                        style: MyTexts.regular12.copyWith(color: MyColors.grey),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

  Widget _buildSpecificationsTable() {
    final product = controller.service;
    final specifications = [
      {'label': 'Brand Name', 'value': product.value.mainCategoryName.toString()},
      {'label': 'Category', 'value': product.value.subCategoryName.toString()},
      {'label': 'Sub category', 'value': product.value.subCategoryName.toString()},
      {'label': 'Unit', 'value': product.value.units.toString()},
    ];

    return _buildSpecificationTable(specifications);
  }

  Widget _buildSpecificationTable(List<Map<String, String>> specifications) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.grayE6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
          children: [
            TableRow(
              decoration: const BoxDecoration(color: MyColors.grayE6),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Specification',
                    style: MyTexts.medium16.copyWith(
                      color: MyColors.black,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                ),
                const SizedBox(),
              ],
            ),
            ...specifications.map(
              (spec) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      spec['label']!,
                      style: MyTexts.medium15.copyWith(color: MyColors.gray54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Text(
                        spec['value']?.capitalizeFirst ?? '',
                        style: MyTexts.medium15.copyWith(color: MyColors.black),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowText(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              fontSize: isBold ? 18 : 14,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
              fontSize: 14,
              fontFamily: MyTexts.SpaceGrotesk,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionButton(BuildContext context, ServiceDetailController controller) {
    final service = controller.service.value;
    final String? connectionStatus = service.connectionRequestStatus;

    if ((connectionStatus ?? "").isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: RoundedButton(
          horizontalPadding: 20,
          buttonName: 'Connect',
          color: MyColors.primary,
          style: MyTexts.medium16.copyWith(color: Colors.white),
          onTap: () {
            Get.arguments["onConnectTap"]?.call();
          },
        ),
      );
    } else if (connectionStatus == 'pending') {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: RoundedButton(
          color: MyColors.pendingBtn,
          horizontalPadding: 20,
          buttonName: 'Pending',
          style: MyTexts.medium16.copyWith(color: MyColors.gray54),
        ),
      );
    } else if (connectionStatus == 'accepted') {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: RoundedButton(
          horizontalPadding: 20,
          color: MyColors.grayEA,
          buttonName: 'Connected',
          borderRadius: 8,
          style: MyTexts.medium16.copyWith(color: MyColors.gray54),
        ),
      );
    } else if (connectionStatus == 'rejected') {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: RoundedButton(
          horizontalPadding: 20,
          color: MyColors.rejectBtn,
          buttonName: 'Rejected',
          borderRadius: 8,
          style: MyTexts.medium16.copyWith(color: MyColors.gray54),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: RoundedButton(
          horizontalPadding: 20,
          color: MyColors.grey,
          buttonName: connectionStatus ?? '',
          fontColor: Colors.white,
        ),
      );
    }
  }
}
