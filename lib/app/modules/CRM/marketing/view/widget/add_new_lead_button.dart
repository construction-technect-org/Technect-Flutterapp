import 'package:construction_technect/app/core/utils/imports.dart';

class AddNewLeadButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddNewLeadButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade800,),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, size: 22),
            const SizedBox(width: 8),
            Text('Add New Lead', style: MyTexts.medium14),
          ],
        ),
      ),
    );
  }
}
