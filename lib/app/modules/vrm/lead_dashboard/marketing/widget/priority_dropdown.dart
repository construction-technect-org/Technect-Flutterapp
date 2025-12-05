import 'package:flutter/material.dart';

class PriorityDropdown extends StatefulWidget {
  final String value;
  final bool? isEnable;
  final void Function(String) onChanged;
  final void Function(bool)? onMenuStateChange;

  const PriorityDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.isEnable = true,
    this.onMenuStateChange,
  });

  @override
  State<PriorityDropdown> createState() => _PriorityDropdownState();
}

class _PriorityDropdownState extends State<PriorityDropdown> {
  final List<String> items = ['High', 'Medium', 'Low'];
  final GlobalKey _key = GlobalKey();

  Color getColor(String v) {
    switch (v) {
      case 'High':
        return Colors.green.shade700;
      case 'Medium':
        return Colors.orange.shade700;
      case 'Low':
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  Future<void> _openMenu() async {
    if (widget.isEnable != true) return;

    widget.onMenuStateChange?.call(true);

    final RenderBox button =
        _key.currentContext!.findRenderObject()! as RenderBox;
    final Offset topLeft = button.localToGlobal(Offset.zero);
    final Size size = button.size;

    final RelativeRect position = RelativeRect.fromLTRB(
      topLeft.dx,
      topLeft.dy + size.height,
      topLeft.dx + size.width,
      topLeft.dy,
    );

    final selected = await showMenu<String>(
      context: context,
      position: position,
      items: items.map((e) {
        return PopupMenuItem<String>(
          value: e,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: getColor(e),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }).toList(),
      elevation: 4,
    );

    widget.onMenuStateChange?.call(false);

    if (selected != null) widget.onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: getColor(widget.value),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: _openMenu,
        borderRadius: BorderRadius.circular(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.value, style: const TextStyle(color: Colors.white)),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
