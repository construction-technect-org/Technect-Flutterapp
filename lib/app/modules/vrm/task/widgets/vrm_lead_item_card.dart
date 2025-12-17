import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/model/vrm_lead_model.dart';
import 'package:intl/intl.dart';

class VrmLeadItemCard extends StatelessWidget {
  final VrmLead lead;
  const VrmLeadItemCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    final baseLeadId = lead.leadId ?? '';
    final salesId = lead.salesId ?? '';
    final accountId = lead.accountId ?? '';
    final merchant = lead.merchantName ?? '';
    final product = lead.productName ?? '';
    final location = lead.siteLocation ?? '';
    final status = lead.currentStatus ?? '';
    final stage = lead.currentStage ?? '';
    final createdAt = lead.createdAt ?? '';
    final merchantImg = lead.merchantProfileImageUrl ?? '';

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFFFFBCC)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColors.grayD6),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: merchantImg.isNotEmpty ? "${APIConstants.bucketUrl}$merchantImg" : '',
              width: 80,
              height: 97,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(width: 80, height: 97, color: Colors.grey.shade200),
              errorWidget: (_, _, _) => Container(
                width: 80,
                height: 97,
                color: Colors.grey.shade200,
                child: Image.asset(Asset.appLogo),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Merchant - ',
                                  style: MyTexts.regular14.copyWith(color: Colors.black),
                                ),
                                TextSpan(
                                  text: merchant,
                                  style: MyTexts.medium14.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Builder(
                            builder: (context) {
                              final List<String> ids = [];
                              if (baseLeadId.isNotEmpty) ids.add(baseLeadId);
                              if (salesId.isNotEmpty) ids.add(salesId);
                              if (accountId.isNotEmpty) ids.add(accountId);

                              if (ids.isEmpty) {
                                return const SizedBox(height: 3);
                              }

                              return Text(
                                ids.join(' / '),
                                style: MyTexts.regular13.copyWith(color: MyColors.black),
                              );
                            },
                          ),
                          const SizedBox(height: 3),
                          if (product.isNotEmpty)
                            Text(
                              'Product Interested - $product',
                              style: MyTexts.regular13.copyWith(color: MyColors.black),
                            ),
                          const SizedBox(height: 4),
                          if (location.isNotEmpty)
                            Row(
                              children: [
                                SvgPicture.asset(Asset.location, height: 14, width: 14),
                                const SizedBox(width: 3),
                                Expanded(
                                  child: Text(
                                    location,
                                    style: MyTexts.regular13.copyWith(color: MyColors.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 3),
                        if (createdAt.isNotEmpty)
                          Text(
                            _formatDateTime(createdAt),
                            style: MyTexts.regular12.copyWith(color: MyColors.black),
                            textAlign: TextAlign.right,
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _pill(stage.capitalizeFirst ?? stage, MyColors.primary),
                    const Gap(16),
                    _pill(status.capitalizeFirst ?? status, MyColors.gray2E),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.CONNECTOR_CHAT_SYSTEM,
                          arguments: {
                            "groupId": lead.groupId ?? 0,
                            "groupName": lead.groupName ?? "Unknown",
                            "groupImage": lead.merchantLogo ?? "Unknown",
                            "myUserID": lead.connectorId ?? 0,
                          },
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(Asset.chat, height: 18),
                      ),
                    ),
                    const Gap(16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(text, style: MyTexts.medium13.copyWith(color: color)),
    );
  }

  String _formatDateTime(String iso) {
    try {
      final d = DateTime.parse(iso);
      final date = DateFormat('MMM d').format(d);
      final time = DateFormat('hh:mm a').format(d);
      return '$time, $date';
    } catch (_) {
      return '';
    }
  }
}
