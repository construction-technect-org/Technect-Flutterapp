import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/QuickAccess/Invetory/model/all_service_model.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback? onTap;
  final VoidCallback? onConnectTap;

  const ServiceCard({super.key, required this.service, this.onTap, this.onConnectTap});

  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    if (service.images != null && service.images!.isNotEmpty) {
      imageUrl = APIConstants.bucketUrl + (service.images?.first.mediaS3Key ?? '');
    }
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.build, color: Colors.grey, size: 40)),
                        )
                      : const Center(child: Icon(Icons.build, color: Colors.grey, size: 40)),
                ),
                // Distance overlay (top left)
                if (myPref.role.val == "connector")
                  if (service.distanceKm != null && service.distanceKm! > 0)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20)
                        // ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        color: Colors.white,
                        child: Text(
                          "${service.distanceKm!.toStringAsFixed(1)} km",
                          style: MyTexts.light14,
                        ),
                      ),
                    ),
              ],
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
                Text('₹ ', style: MyTexts.medium14.copyWith(color: MyColors.custom('0B1429'))),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.price?.toString() ?? 'N/A',
                      style: MyTexts.medium14.copyWith(color: MyColors.custom('0B1429')),
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
          if (myPref.role.val == "connector") ...[const Gap(8), _buildConnectButton(context)],
        ],
      ),
    );
  }

  Widget _buildConnectButton(BuildContext context) {
    if (service.connectionRequestStatus == null && service.leadCreated == false) {
      return _buildConnectServiceButton(context);
    } else if (service.connectionRequestStatus != null && service.leadCreated == false) {
      return _buildRequirementButton(context);
    } else if (service.connectionRequestStatus != null && service.leadCreated == true) {
      return _buildStaticButton('Send', MyColors.pendingBtn);
    }

    return const SizedBox.shrink();
  }

  Widget _buildRequirementButton(BuildContext context) {
    return RoundedButton(
      buttonName: 'Requirement',
      color: MyColors.primary,
      fontColor: Colors.white,
      onTap: onConnectTap,
      height: 32,
      borderRadius: 8,
      verticalPadding: 0,
      style: MyTexts.medium14.copyWith(color: Colors.white),
    );
  }

  Widget _buildConnectServiceButton(BuildContext context) {
    final connectionStatus = service.connectionRequestStatus ?? '';

    switch (connectionStatus) {
      case '':
        return RoundedButton(
          buttonName: 'Connect',
          color: MyColors.primary,
          fontColor: Colors.white,
          onTap: onConnectTap,
          height: 32,
          borderRadius: 8,
          verticalPadding: 0,
          style: MyTexts.medium14.copyWith(color: Colors.white),
        );

      case 'pending':
        return _buildStaticButton('Pending', MyColors.pendingBtn);

      case 'accepted':
        return _buildStaticButton('Connected', MyColors.grayEA);

      case 'rejected':
        return _buildStaticButton('Rejected', MyColors.rejectBtn);

      default:
        return _buildStaticButton(
          connectionStatus.capitalizeFirst ?? connectionStatus,
          MyColors.grayEA,
        );
    }
  }

  Widget _buildStaticButton(String text, Color color) {
    return RoundedButton(
      buttonName: text,
      color: color,
      borderRadius: 8,
      height: 32,
      horizontalPadding: 20,
      verticalPadding: 0,
      style: MyTexts.medium14.copyWith(color: MyColors.gray54),
    );
  }
}
