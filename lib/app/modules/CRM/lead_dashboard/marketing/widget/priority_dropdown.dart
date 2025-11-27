import 'package:construction_technect/app/core/utils/imports.dart';

class PriorityDropdown extends StatefulWidget {
  final String value;
  bool? isEnable;
  final Function(String) onChanged;

  PriorityDropdown({super.key, required this.value, required this.onChanged, this.isEnable = true});

  @override
  State<PriorityDropdown> createState() => _PriorityDropdownState();
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  final List<String> items = ["High", "Medium", "Low"];

  Color getColor(String v) {
    switch (v) {
      case "High":
        return Colors.green.shade700;
      case "Medium":
        return Colors.orange.shade700;
      case "Low":
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: getColor(widget.value),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.value,

          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
          dropdownColor: Colors.white,
          style: const TextStyle(color: Colors.black, fontSize: 14),
          onChanged: widget.isEnable == true
              ? (value) {
                  if (value != null) widget.onChanged(value);
                }
              : null,
          isDense: true,
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: getColor(e),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(e, style: MyTexts.medium14.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
