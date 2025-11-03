import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';
import 'package:gap/gap.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.service,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = (service.media != null && service.media!.isNotEmpty)
        ? APIConstants.bucketUrl + service.media!.first.toString()
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              child: imageUrl != null
                  ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.build, color: Colors.grey, size: 40)),
              )
                  : const Center(child: Icon(Icons.build, color: Colors.grey, size: 40)),
            ),
          ),
          const Gap(8),
          // SERVICE NAME
          Text(
            service.mainCategoryName ?? "Unknown Service",
            style: MyTexts.medium14.copyWith(color: MyColors.custom('2E2E2E')),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(4),
          // CATEGORY NAME
          Text(
            service.serviceCategoryName ?? "No Category",
            style: MyTexts.medium12.copyWith(color: MyColors.gray54),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(8),
          // PRICE + GST
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyColors.custom('FFF9BD'),
                  MyColors.custom('FFF9BD').withValues(alpha: 0.1),
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹ ',
                  style: MyTexts.medium14.copyWith(color: MyColors.custom('0B1429')),
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.price?.toString() ?? 'N/A',
                      style: MyTexts.medium14.copyWith(
                        color: MyColors.custom('0B1429'),
                      ),
                    ),
                    Text(
                      "(${service.gstPercentage ?? 0}% GST)",
                      style: MyTexts.medium12.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
