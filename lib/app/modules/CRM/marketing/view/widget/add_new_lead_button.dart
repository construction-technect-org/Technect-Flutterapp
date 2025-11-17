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
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade800, width: 1.6),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 22),
            SizedBox(width: 8),
            Text(
              'Add New Lead',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
