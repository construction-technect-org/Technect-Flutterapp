import 'package:construction_technect/app/core/utils/imports.dart';

class PillButton extends StatelessWidget {
  final String text;
  const PillButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF17345A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(text, style: MyTexts.medium16.copyWith(color: Colors.white)),
    );
  }
}
