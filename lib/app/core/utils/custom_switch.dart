import 'package:construction_technect/app/core/utils/imports.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 54,
        height: 30,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: widget.value ? MyColors.primary : MyColors.spanishGray, // navy / grey
          borderRadius: BorderRadius.circular(30),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: MyColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: MyColors.white, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
