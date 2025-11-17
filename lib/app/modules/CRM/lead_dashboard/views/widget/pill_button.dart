import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const PillButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E305C) : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF1E305C),
          ),
        ),
      ),
    );
  }
}

class PillButtonWithOuter extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const PillButtonWithOuter({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E305C) : Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF1E305C),
          ),
        ),
      ),
    );
  }
}
