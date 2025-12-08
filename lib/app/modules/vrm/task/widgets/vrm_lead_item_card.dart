import 'package:cached_network_image/cached_network_image.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/vrm/task/model/vrm_lead_model.dart';
import 'package:intl/intl.dart';

class VrmLeadItemCard extends StatelessWidget {
  final VrmLead lead;
  const VrmLeadItemCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    final mainStage = lead.mainStage ?? '';
    final isPurchase = mainStage == 'Purchase';
    final isAccount = mainStage == 'Account';

    final leadId = isPurchase
        ? (lead.salesId ?? lead.leadId ?? '')
        : isAccount
        ? (lead.accountId ?? lead.leadId ?? '')
        : (lead.leadId ?? '');
    final connector = lead.connectorName ?? '';
    final product = lead.productName ?? '';
    final location = lead.siteLocation ?? '';
    final status = isPurchase
        ? (lead.salesLeadStatus ?? '')
        : isAccount
        ? (lead.accountLeadStatus ?? '')
        : (lead.status ?? '');
    final stage = isPurchase
        ? (lead.salesLeadsStage ?? '')
        : isAccount
        ? (lead.accountLeadsStage ?? '')
        : (lead.leadStage ?? '');
    final createdAt = lead.createdAt ?? '';
    final connectorImg = lead.connectorProfileImage ?? '';

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
              imageUrl: connectorImg.isNotEmpty
                  ? "${APIConstants.bucketUrl}$connectorImg"
                  : (lead.merchantProfileImageUrl ?? ''),
              width: 80,
              height: 97,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(width: 80, height: 97, color: Colors.grey.shade200),
              errorWidget: (_, __, ___) => Container(
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
                                  text: 'Connector - ',
                                  style: MyTexts.regular14.copyWith(color: Colors.black),
                                ),
                                TextSpan(
                                  text: connector,
                                  style: MyTexts.medium14.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Lead Id - $leadId',
                            style: MyTexts.regular13.copyWith(color: MyColors.black),
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
                    _pill(status.capitalizeFirst ?? status, MyColors.gray2E),
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
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
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
