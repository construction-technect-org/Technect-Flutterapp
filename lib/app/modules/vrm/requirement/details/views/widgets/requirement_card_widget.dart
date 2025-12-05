import 'package:construction_technect/app/core/utils/imports.dart';

class RequirementCardWidget extends StatelessWidget {
  const RequirementCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MyColors.grayEA),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.asset(
                  Asset.profil,
                  height: 52,
                  width: 52,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Team Member Name',
                      style: MyTexts.bold18.copyWith(color: MyColors.fontBlack),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '12345',
                      style: MyTexts.medium14.copyWith(color: MyColors.gray54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEAEAEA)),
          const SizedBox(height: 16),

          // Details two-column layout
          _detailRow('Dummy data', 'Lead ID'),
          _detailRow('Anand', 'RFQ ID'),
          _detailRow('1234567890', 'Customer id'),
          _detailRow('12345678', 'Connector Name'),
          _detailRow('M Sand', 'Phone no'),
          _detailRow('M 1324', 'Alternative no'),
          _detailRow('M 1324', 'POC'),
          _detailRow('M 1324', 'Time,date of Lead generated'),
          _detailRow('M 1324', 'Product'),
          _detailRow('M 1324', 'Qty'),
          _detailRow('M 1324', 'Note'),
          _detailRow('M 1324', 'Site No'),
          _detailRow('M 1324', 'Site Location'),
          _detailRow('M 1324', 'Site contact person'),
          _detailRow('M 1324', 'Site photo'),
          _detailRow('M 1324', 'Estimated delivery date'),
          _detailRow('M 1324', 'Estimated delivery Time'),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFDEA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MyColors.grayEA),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Set a Reminder',
                        style: MyTexts.medium14.copyWith(
                          color: MyColors.fontBlack,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EDFF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MyColors.grayEA),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add note',
                          style: MyTexts.medium14.copyWith(
                            color: MyColors.fontBlack,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.edit_note_rounded,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              left,
              style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
            ),
          ),
          const SizedBox(width: 12),
          Text(right, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
        ],
      ),
    );
  }
}
